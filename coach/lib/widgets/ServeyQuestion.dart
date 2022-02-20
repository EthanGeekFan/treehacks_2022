import 'package:coach/models/Colors.dart';
import 'package:coach/models/Question.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class ServeyQuestion extends StatefulWidget {
  const ServeyQuestion({Key? key, required this.question}) : super(key: key);

  final Question question;

  @override
  _ServeyQuestionState createState() => _ServeyQuestionState();
}

class _ServeyQuestionState extends State<ServeyQuestion> {
  Widget buildItem(String choice) {
    if (widget.question.isSlider) {
      return SliderItem(
        choice: choice,
        min: widget.question.min,
        max: widget.question.max,
      );
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
      width: MediaQuery.of(context).size.width * 0.9,
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
  const SliderItem(
      {Key? key, required this.choice, required this.min, required this.max})
      : super(key: key);

  final String choice;
  final int min;
  final int max;

  @override
  _SliderItemState createState() => _SliderItemState();
}

class _SliderItemState extends State<SliderItem> {
  late int value;

  @override
  void initState() {
    super.initState();
    value = widget.min;
  }

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
            min: widget.min.toDouble(),
            max: widget.max.toDouble(),
            divisions: widget.max - widget.min,
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
