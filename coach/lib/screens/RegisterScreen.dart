import 'package:coach/models/Colors.dart';
import 'package:coach/screens/ServeyScreen.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import 'HomeScreen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool _agree = false;
  bool exit = false;

  Route _createRoute() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
          const ServeyScreen(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Container(
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.1,
                ),
                AnimatedOpacity(
                  opacity: 1,
                  duration: Duration(milliseconds: 1000),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 5,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Semantics(
                          child: Text(
                            "EXSY",
                            style: TextStyle(
                              color: myYellow,
                              fontSize: 50,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Gotham',
                            ),
                          ),
                        ),
                        CircleAvatar(
                          backgroundColor: myYellow,
                          radius: 20,
                          child: Icon(
                            Icons.person,
                            color: Colors.black,
                            size: 30,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                AnimatedOpacity(
                  opacity: exit ? 0 : 1,
                  duration: Duration(milliseconds: 1000),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Divider(color: Color(0xFF626262), thickness: 1),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                ),
                AnimatedOpacity(
                  opacity: exit ? 0 : 1,
                  duration: Duration(milliseconds: 1000),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          blurRadius: 10,
                          spreadRadius: 5,
                        ),
                      ],
                    ),
                    margin: const EdgeInsets.symmetric(horizontal: 15),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 3),
                    child: TextFormField(
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.zero,
                        labelText: "Name",
                        labelStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      ),
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                AnimatedOpacity(
                  opacity: exit ? 0 : 1,
                  duration: Duration(milliseconds: 1000),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          blurRadius: 10,
                          spreadRadius: 5,
                        ),
                      ],
                    ),
                    margin: const EdgeInsets.symmetric(horizontal: 15),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 3),
                    child: TextFormField(
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.zero,
                        labelText: "Phone",
                        labelStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      ),
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                AnimatedOpacity(
                  opacity: exit ? 0 : 1,
                  duration: Duration(milliseconds: 1000),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          blurRadius: 10,
                          spreadRadius: 5,
                        ),
                      ],
                    ),
                    margin: const EdgeInsets.symmetric(horizontal: 15),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 3),
                    child: TextFormField(
                      obscureText: true,
                      enableSuggestions: false,
                      autocorrect: false,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.zero,
                        labelText: "Password",
                        labelStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      ),
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                AnimatedOpacity(
                  opacity: exit ? 0 : 1,
                  duration: Duration(milliseconds: 500),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: [
                        Checkbox(
                          value: _agree,
                          onChanged: (newVal) {
                            setState(() {
                              _agree = !_agree;
                            });
                          },
                          fillColor: MaterialStateColor.resolveWith(
                              (Set<MaterialState> states) {
                            return _agree ? Colors.green : Colors.grey;
                          }),
                        ),
                        const Text(
                          "I read and agree to the terms and conditions",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.1,
                ),
              ],
            ),
          ),
          AnimatedPositioned(
            duration: Duration(milliseconds: 1000),
            bottom: exit ? 500 : 100,
            left: MediaQuery.of(context).size.width / 2 - 125,
            right: MediaQuery.of(context).size.width / 2 - 125,
            child: AnimatedScale(
              scale: exit ? 10 : 1,
              duration: Duration(milliseconds: 1000),
              child: Container(
                width: 250,
                height: 250,
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(200),
                  color: Colors.transparent,
                  border: Border.all(
                    color: myYellow,
                    width: 3,
                  ),
                ),
                child: Container(
                  width: 250,
                  height: 250,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(200),
                    color: Colors.transparent,
                    border: Border.all(
                      color: myYellow,
                      width: 2,
                    ),
                  ),
                  child: AnimatedOpacity(
                    opacity: exit ? 0 : 1,
                    duration: Duration(milliseconds: 600),
                    child: TextButton(
                      onPressed: () async {
                        // Navigator.push(
                        //   context,
                        //   MaterialWithModalsPageRoute(
                        //     builder: (context) => const ServeyScreen(),
                        //   ),
                        // );
                        setState(() {
                          exit = true;
                        });
                        await Future.delayed(Duration(milliseconds: 1100));
                        Navigator.of(context).push(_createRoute());
                      },
                      child: const Text(
                        "START\nMATCHING",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          letterSpacing: 2,
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
