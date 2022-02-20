import 'dart:async';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:coach/screens/RegisterScreen.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:dio/dio.dart';

import '../models/Colors.dart';
import 'ServeyScreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

enum Status {
  waiting,
  newMatch,
  duringDate,
  expired,
}

class _HomeScreenState extends State<HomeScreen> {
  Status status = Status.waiting;
  String statusIndicator = "······";
  String description = "Please check expiry date at the same time";
  String time = "6:00pm Feb 29";
  String place = "Wilbur Dining Hall";
  String code = "Everything happens for a reason";
  bool checkedExpiry = false;
  Color expiredColor = Colors.redAccent;
  late Timer expiryTimer;
  late DateTime expiryDate;

  Duration defaultDuration = Duration(hours: 5);

  void setWaiting() {
    status = Status.waiting;
    statusIndicator = "······";
    description = "Waiting for a match";
  }

  void setNewMatch() {
    status = Status.newMatch;
    statusIndicator = "✓";
    description = "New match found";
    time = "6:00pm Feb 29";
    place = "Wilbur Dining Hall";
  }

  void setDuringDate() {
    status = Status.duringDate;
    description = "Please check expiry date at the same time";
    time = "6:00pm Feb 29";
    place = "Wilbur Dining Hall";
    checkedExpiry = false;
  }

  void setExpired() {
    status = Status.expired;
    statusIndicator = "00:00";
    description = "Relationship Expired";
  }

  String formatTime(int time) {
    if (time < 10) {
      return "0$time";
    } else {
      return "$time";
    }
  }

  String parseDuration(Duration d) {
    String result = "";
    if (d.inDays > 0) {
      result += "${d.inDays % 365 + 1}\nday" + (d.inDays > 1 ? "s" : "");
      return result;
    }
    // if (d.inHours > 0) {
    //   result += "${d.inHours % 24 + 1}\nhour" + (d.inHours > 1 ? "s" : "");
    //   return result;
    // }
    if (d.inHours > 0) {
      result +=
          "${formatTime(d.inHours % 24)}:${formatTime(d.inMinutes % 60)}:${formatTime(d.inSeconds % 60)}";
      return result;
    }
    if (d.inMinutes > 0) {
      result +=
          "${formatTime(d.inMinutes % 60)}:${formatTime(d.inSeconds % 60)}";
      return result;
    }
    if (d.inSeconds > 0) {
      result += "00:${formatTime(d.inSeconds % 60)}";
      return result;
    }
    if (d.inMilliseconds > 0) {
      result += "00:00";
      return result;
    }
    return result;
  }

  String parseExpiry(Duration d) {
    String result = "";
    if (d.inDays > 0) {
      result += "${d.inDays % 365}\nday" + (d.inDays > 1 ? "s" : "");
      return result;
    }
    if (d.inHours > 0) {
      result += "${d.inHours % 24}\nhour" + (d.inHours > 1 ? "s" : "");
      return result;
    }
    if (d.inMinutes > 0) {
      result += "${d.inMinutes % 60}\nminute" + (d.inMinutes > 1 ? "s" : "");
      return result;
    }
    if (d.inSeconds > 0) {
      result += "${d.inSeconds % 60}\nsecond" + (d.inSeconds > 1 ? "s" : "");
      return result;
    }
    return result;
  }

  // void fetchData() async {
  //   String hostname = "https://localhost:8000/";
  //   String phone = "1234567890";
  //   String url = "$hostname/users/match/$phone";
  //   // get duration
  //   try {
  //     var response = await Dio().post(url);
  //     print(response);
  //     if (response.statusCode == 200) {
  //       var data = response.data;
  //       if (data && data["duration"]) {
  //         defaultDuration = Duration(seconds: data["duration"]);
  //       }
  //     } else {
  //       print(response.statusCode);
  //     }
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  @override
  void initState() {
    super.initState();
    setWaiting();
    Timer(Duration(seconds: 5), () {
      setState(() {
        setNewMatch();
      });
    });
    // fetchData();
  }

  void dispose() {
    expiryTimer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              Positioned(
                top: MediaQuery.of(context).size.height * 0.1,
                left: MediaQuery.of(context).size.width * 0.1,
                right: MediaQuery.of(context).size.width * 0.1,
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: MediaQuery.of(context).size.width * 0.8,
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      MediaQuery.of(context).size.width * 0.8,
                    ),
                    color: Colors.transparent,
                    border: Border.all(
                      color: status == Status.expired ? expiredColor : myYellow,
                      width: 3,
                    ),
                  ),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: MediaQuery.of(context).size.width * 0.8,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        MediaQuery.of(context).size.width * 0.8,
                      ),
                      color: Colors.transparent,
                      border: Border.all(
                        color:
                            status == Status.expired ? expiredColor : myYellow,
                        width: 1,
                      ),
                    ),
                    child: Center(
                      child: status == Status.duringDate
                          ? checkedExpiry
                              ? Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      statusIndicator.split('\n')[0],
                                      style: TextStyle(
                                        fontSize: 50,
                                        color: Colors.white,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    if (statusIndicator.split('\n').length > 1)
                                      Text(
                                        statusIndicator.split('\n')[1],
                                        style: TextStyle(
                                          fontSize: 40,
                                          color: Colors.white,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                  ],
                                )
                              : GestureDetector(
                                  onTap: (() async {
                                    setState(() {
                                      checkedExpiry = true;
                                      statusIndicator = parseExpiry(
                                        defaultDuration,
                                      );
                                    });
                                    await Future.delayed(Duration(seconds: 3));
                                    expiryDate = DateTime.now().add(
                                      defaultDuration,
                                    );
                                    expiryTimer = Timer.periodic(
                                        Duration(
                                          milliseconds: 100,
                                        ), (timer) {
                                      if (expiryDate.isBefore(DateTime.now())) {
                                        expiryTimer.cancel();
                                        setState(() {
                                          setExpired();
                                        });
                                      } else {
                                        setState(() {
                                          statusIndicator = parseDuration(
                                              expiryDate
                                                  .difference(DateTime.now()));
                                        });
                                      }
                                    });
                                  }),
                                  child: Container(
                                    width: 100,
                                    height: 100,
                                    child:
                                        Image.asset("assets/fingerprint.png"),
                                  ),
                                )
                          : status == Status.waiting
                              ? AnimatedTextKit(
                                  key: ValueKey<String>(statusIndicator),
                                  repeatForever: true,
                                  pause: Duration(milliseconds: 0),
                                  animatedTexts: [
                                    WavyAnimatedText(
                                      statusIndicator,
                                      textStyle: TextStyle(
                                        fontSize: 50,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                )
                              : Text(
                                  statusIndicator,
                                  style: TextStyle(
                                    fontSize: 100,
                                    color: Colors.white,
                                  ),
                                ),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: MediaQuery.of(context).size.height * 0.15 +
                    MediaQuery.of(context).size.width * 0.8,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  child: Builder(
                    builder: ((context) {
                      switch (status) {
                        case Status.waiting:
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 40),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  description,
                                  style: TextStyle(
                                    fontSize: 22,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          );
                        case Status.newMatch:
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 40),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Time:",
                                      style: TextStyle(
                                        fontSize: 25,
                                        color: myYellow,
                                      ),
                                    ),
                                    Text(
                                      time,
                                      style: TextStyle(
                                        fontSize: 25,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Place:",
                                      style: TextStyle(
                                        fontSize: 25,
                                        color: myYellow,
                                      ),
                                    ),
                                    Text(
                                      place,
                                      style: TextStyle(
                                        fontSize: 25,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: 60,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.grey.withOpacity(0.3),
                                  ),
                                  child: Center(
                                    child: Text(
                                      "\"$code\"",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontStyle: FontStyle.italic,
                                        color: Colors.white.withOpacity(0.6),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 40,
                                ),
                                ElevatedButton(
                                  style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.resolveWith(
                                            (states) => myYellow),
                                    foregroundColor:
                                        MaterialStateProperty.resolveWith(
                                            (states) => Colors.black),
                                    elevation:
                                        MaterialStateProperty.resolveWith(
                                            (states) => 0),
                                    shape: MaterialStateProperty.resolveWith(
                                      (states) => RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(40),
                                      ),
                                    ),
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      setDuringDate();
                                    });
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 40, vertical: 10),
                                    child: Text(
                                      "Accept",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                ElevatedButton(
                                  style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.resolveWith(
                                            (states) => Colors.grey),
                                    foregroundColor:
                                        MaterialStateProperty.resolveWith(
                                            (states) => Colors.black),
                                    elevation:
                                        MaterialStateProperty.resolveWith(
                                            (states) => 0),
                                    shape: MaterialStateProperty.resolveWith(
                                      (states) => RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(40),
                                      ),
                                    ),
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      setWaiting();
                                    });
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 40, vertical: 10),
                                    child: Text(
                                      "Decline",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                      ),
                                    ),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {},
                                  child: Text(
                                    "Change Time",
                                    style: TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        case Status.duringDate:
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 40),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Time:",
                                      style: TextStyle(
                                        fontSize: 25,
                                        color: myYellow,
                                      ),
                                    ),
                                    Text(
                                      time,
                                      style: TextStyle(
                                        fontSize: 25,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Place:",
                                      style: TextStyle(
                                        fontSize: 25,
                                        color: myYellow,
                                      ),
                                    ),
                                    Text(
                                      place,
                                      style: TextStyle(
                                        fontSize: 25,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: 60,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.grey.withOpacity(0.3),
                                  ),
                                  child: Center(
                                    child: Text(
                                      "\"$code\"",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontStyle: FontStyle.italic,
                                        color: Colors.white.withOpacity(0.6),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 40,
                                ),
                                Text(
                                  description,
                                  style: TextStyle(
                                    fontSize: 22,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          );
                        case Status.expired:
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 40),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  description,
                                  style: TextStyle(
                                    fontSize: 22,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                ElevatedButton(
                                  style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.resolveWith(
                                            (states) => myYellow),
                                    foregroundColor:
                                        MaterialStateProperty.resolveWith(
                                            (states) => Colors.black),
                                    elevation:
                                        MaterialStateProperty.resolveWith(
                                            (states) => 0),
                                    shape: MaterialStateProperty.resolveWith(
                                      (states) => RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(40),
                                      ),
                                    ),
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const RegisterScreen(),
                                      ),
                                    );
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 40, vertical: 10),
                                    child: Text(
                                      "Commit to Match",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                ElevatedButton(
                                  style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.resolveWith(
                                            (states) => Colors.grey),
                                    foregroundColor:
                                        MaterialStateProperty.resolveWith(
                                            (states) => Colors.black),
                                    elevation:
                                        MaterialStateProperty.resolveWith(
                                            (states) => 0),
                                    shape: MaterialStateProperty.resolveWith(
                                      (states) => RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(40),
                                      ),
                                    ),
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      setWaiting();
                                    });
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 40, vertical: 10),
                                    child: Text(
                                      "Move On",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        default:
                          return Text("none");
                      }
                    }),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
