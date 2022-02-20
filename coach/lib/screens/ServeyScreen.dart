import 'package:coach/models/Question.dart';
import 'package:coach/screens/HomeScreen.dart';
import 'package:coach/widgets/ServeyQuestion.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../models/Colors.dart';

class ServeyScreen extends StatefulWidget {
  const ServeyScreen({Key? key}) : super(key: key);

  @override
  _ServeyScreenState createState() => _ServeyScreenState();
}

class _ServeyScreenState extends State<ServeyScreen> {
  List<Question> questions = introQuestions;

  int questionIndex = 0;

  @override
  Widget build(BuildContext context) {
    Widget content = ServeyQuestion(
        key: ValueKey<String>(questions[questionIndex].prompt),
        question: questions[questionIndex]);
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: SafeArea(
          top: false,
          child: Container(
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.1,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 5,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "EXSY",
                        style: TextStyle(
                          color: myYellow,
                          fontSize: 50,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Gotham',
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
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Divider(color: Color(0xFF626262), thickness: 1),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                ),
                content,
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.1,
                ),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.resolveWith((states) => myYellow),
                    foregroundColor: MaterialStateProperty.resolveWith(
                        (states) => Colors.black),
                    elevation: MaterialStateProperty.resolveWith((states) => 0),
                    shape: MaterialStateProperty.resolveWith(
                      (states) => RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40),
                      ),
                    ),
                  ),
                  onPressed: () {
                    if (questionIndex < questions.length - 1) {
                      setState(() {
                        questionIndex++;
                      });
                    } else {
                      Navigator.push(
                        context,
                        MaterialWithModalsPageRoute(
                          builder: (context) => const HomeScreen(),
                        ),
                      );
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 10),
                    child: Text(
                      "Next",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
