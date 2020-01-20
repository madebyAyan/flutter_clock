import 'package:flutter/material.dart';
import 'package:digital_clock/helpers/values.dart' as values;
import 'package:digital_clock/helpers/clippers.dart';
import 'dart:async';

//Setting up, positioning and animating the minutes of the clock
//The digits are animated from top to bottom by varying their top padding
class MinutesAnimated extends StatefulWidget {
  MinutesAnimated(
    this.hoursAnimVal,
    this.fontSizeMinute,
    this.rightDigit,
    this.colors,
    this.currentWeather,
  );

  double hoursAnimVal;
  double fontSizeMinute;
  bool rightDigit;
  var colors;
  int currentWeather;

  @override
  _MinutesAnimatedState createState() => _MinutesAnimatedState();
}

class _MinutesAnimatedState extends State<MinutesAnimated>
    with SingleTickerProviderStateMixin {
  Animation<double> minutesAnim;
  AnimationController minutesAC;

  int digitPos;
  int currentNum;
  double initMin;
  double initSec;
  PageController
      minute0s_PC; //For the effect of transitioning to the next digit

  void _numTransition(int val) async {
    await minute0s_PC.animateToPage(
      0,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeOutQuart,
    );

    Timer(Duration(milliseconds: 300), () {
      currentNum = int.parse((minutesAnim.value.floor()).toString()) % val;
      minute0s_PC.jumpToPage(2);
      minute0s_PC.animateToPage(
        1,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeOutCubic,
      );
    });
  }

  void initState() {
    super.initState();

    digitPos = widget.rightDigit ? 0 : 1;
    initMin = (widget.hoursAnimVal * 60) % 60;
    initSec = ((((widget.hoursAnimVal * 60) % 60) % 10) * 60) % 60;

    if (digitPos == 1) { //For the Ten's position of the minute
      minutesAC =
          AnimationController(duration: Duration(minutes: 60), vsync: this)
            ..forward(
              from: ((initMin) / 60).toDouble(),
            );

      minutesAnim = Tween<double>(begin: 0, end: 6).animate(minutesAC)
        ..addListener(() {
          if ((int.parse((minutesAnim.value.floor()).toString()) % 6) !=
              currentNum) {
            _numTransition(6);
          }
          if (minutesAnim.isCompleted) {
            minutesAC.reset();
            minutesAC.forward();
          }
          setState(() {});
        });
    } else { //For the One's position of the minute
      minutesAC = AnimationController(
        duration: Duration(minutes: 10),
        vsync: this,
      )..forward(
          from: ((initMin % 10) / 10).toDouble(),
        );

      minutesAnim = Tween<double>(begin: 0, end: 10).animate(minutesAC)
        ..addListener(() {
          if ((int.parse((minutesAnim.value.floor()).toString()) % 10) !=
              currentNum) {
            _numTransition(10);
          }
          if (minutesAnim.isCompleted) {
            minutesAC.reset();
            minutesAC.forward();
          }
          setState(() {});
        });
    }
    currentNum = int.parse((minutesAnim.value.floor()).toString()) %
        (digitPos == 1 ? 6 : 10);

    minute0s_PC = PageController(initialPage: 1);
  }

  @override
  void dispose() {
    minutesAC.dispose();
    minute0s_PC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageView(
      physics: NeverScrollableScrollPhysics(),
      scrollDirection: Axis.vertical,
      controller: minute0s_PC,
      children: <Widget>[
        Container(),
        Align(
          alignment: Alignment.topCenter,
          child: AnimatedBuilder(
              animation: minutesAnim,
              builder: (context, child) {
                return Padding(
                  padding: EdgeInsets.only(
                    left: 0,
                    top: (minutesAnim.value *
                        (MediaQuery.of(context).size.height -
                            widget.fontSizeMinute) /
                        (digitPos == 1 ? 6 : 10)),
                  ),
                  child: Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.only(
                      left: widget.rightDigit
                          ? 0
                          : MediaQuery.of(context).size.height * 0.013,
                    ),
                    width: MediaQuery.of(context).size.height / 2,
                    height: widget.fontSizeMinute,
                    child: Stack(
                      alignment: Alignment.centerLeft,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(
                            left: MediaQuery.of(context).size.height * 0.053,
                          ),
                          child: Image(
                            image: values.numImages[currentNum],
                            color: widget.colors[widget.currentWeather]
                                [values.Element.shadow],
                            fit: BoxFit.fitHeight,
                            height: widget.fontSizeMinute,
                          ),
                        ),
                        Image(
                          image: values.numImages[currentNum],
                          color: widget.colors[widget.currentWeather]
                              [values.Element.text],
                          fit: BoxFit.fitHeight,
                          height: widget.fontSizeMinute,
                        ),
                        ClipRect(
                          clipper: TimeDisplayClipper(
                            digitPos == 1
                                ? (minutesAnim.value * 10) % 10
                                : (minutesAnim.value * 60) % 60,
                            digitPos == 1 ? 10 : 60,
                          ),
                          child: Image(
                            image: values.numImages[currentNum],
                            color: widget.colors[widget.currentWeather]
                                [values.Element.fill],
                            fit: BoxFit.fill,
                            height: widget.fontSizeMinute,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
        ),
        Container(),
      ],
    );
  }
}
