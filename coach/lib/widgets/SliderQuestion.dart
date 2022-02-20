import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:coach/models/Colors.dart';
import 'package:coach/models/Question.dart';
import 'package:flutter/material.dart';

class SliderQuestion extends StatefulWidget {
  const SliderQuestion({Key? key, required this.question}) : super(key: key);

  final Question question;

  @override
  _SliderQuestionState createState() => _SliderQuestionState();
}

class _SliderQuestionState extends State<SliderQuestion> {
  Widget buildItem(String choice) {
    if (widget.question.isSlider) {
      return SliderItem(choice: choice);
    }
    return Theme(
      data: Theme.of(context).copyWith(
        unselectedWidgetColor: Colors.white,
      ),
      child: RadioListTile(
        contentPadding: EdgeInsets.zero,
        title: AnimatedTextKit(
          isRepeatingAnimation: false,
          animatedTexts: [
            TyperAnimatedText(
              choice,
              textStyle: TextStyle(
                fontSize: 18,
                color: Colors.white,
              ),
            )
          ],
        ),
        value: choice,
        groupValue: widget.question.selectedChoice,
        onChanged: (value) {
          setState(() {
            widget.question.selectedChoice = choice;
          });
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          DefaultTextStyle(
            style: TextStyle(
              fontSize: 20,
              color: Colors.white,
            ),
            child: AnimatedTextKit(
              isRepeatingAnimation: false,
              animatedTexts: [
                TyperAnimatedText(widget.question.prompt),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          if (widget.question.isFreeResponse)
            TextField(
              maxLines: null,
              decoration: InputDecoration(
                hintText: 'Enter your answer here',
                hintStyle: TextStyle(
                  color: Colors.white,
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          for (var choice in widget.question.choices) buildItem(choice),
        ],
      ),
    );
  }
}

class SliderItem extends StatefulWidget {
  const SliderItem({Key? key, required this.choice}) : super(key: key);

  final String choice;

  @override
  _SliderItemState createState() => _SliderItemState();
}

class _SliderItemState extends State<SliderItem> {
  int value = 0;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: AnimatedTextKit(
            isRepeatingAnimation: false,
            animatedTexts: [
              TyperAnimatedText(
                widget.choice,
                textStyle: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 2,
          child: Slider(
            value: value.toDouble(),
            min: 0,
            max: 10,
            divisions: 10,
            activeColor: myYellow,
            thumbColor: myYellow,
            label: '${value.toString()}',
            onChanged: (value) {
              setState(() {
                this.value = value.round();
              });
            },
          ),
        ),
      ],
    );
  }
}
