// Copyright 2019 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter_clock_helper/model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:digital_clock/helpers/values.dart' as values;
import 'package:digital_clock/widgets/minutes_disp.dart';
import 'package:digital_clock/widgets/waves_bg.dart';

class DigitalClock extends StatefulWidget {
  const DigitalClock(
    this.model,
  );

  final ClockModel model;

  @override
  _DigitalClockState createState() => _DigitalClockState();
}

class _DigitalClockState extends State<DigitalClock>
    with SingleTickerProviderStateMixin {
  DateTime _dateTime = DateTime.now();
  Timer _timer;

  Animation<double> hoursAnim;
  AnimationController hoursAC;

  int currentHour1s;
  int currentHour0s;
  int currentWeather;
  double bgFraction;

  @override
  void initState() {
    super.initState();
    currentWeather = 0;
    bgFraction = 180;
    widget.model.addListener(_updateModel);
    _dateTime = DateTime.now();
    _updateModel();

    //Start the AnimationController from the current real world time
    hoursAC = AnimationController(
      duration: Duration(hours: 24),
      vsync: this,
    )..forward(
        from: (_dateTime.hour + _dateTime.minute / 60 + _dateTime.second / 3600)
                .toDouble() /
            24,
      );

    hoursAnim = Tween<double>(begin: 0, end: 24).animate(hoursAC)
      ..addListener(() {
        if (hoursAnim.isCompleted) {
          hoursAC.reset();
          hoursAC.forward();
        }
        setState(() {});
      });

    currentHour1s = int.parse((((widget.model.is24HourFormat
                    ? hoursAnim.value
                    : (hoursAnim.value % 12)))
                .floor())
            .toString()) %
        24;
  }

  @override
  void didUpdateWidget(DigitalClock oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.model != oldWidget.model) {
      oldWidget.model.removeListener(_updateModel);
      widget.model.addListener(_updateModel);
    }
  }

  @override
  void dispose() {
    hoursAC.dispose();
    _timer?.cancel();
    widget.model.removeListener(_updateModel);
    widget.model.dispose();
    super.dispose();
  }

  void _updateModel() {
    setState(() {
      // Cause the clock to rebuild when the model changes.
    });
  }

  @override
  Widget build(BuildContext context) {
    //Lock rotation to either landscapeLeft or landscapeRight
    SystemChrome.setPreferredOrientations(
      [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight],
    );
    SystemChrome.setEnabledSystemUIOverlays([]);

    var colors = Theme.of(context).brightness == Brightness.light
        ? values.lightThemes
        : values.darkThemes;

    //switch the weatherString and change the theme and wave accordingly
    switch (widget.model.weatherString) {
      case "cloudy":
        currentWeather = 0;
        bgFraction = 0.9;
        break;
      case "foggy":
        currentWeather = 1;
        bgFraction = 0.5;
        break;
      case "rainy":
        currentWeather = 2;
        bgFraction = 2;
        break;
      case "snowy":
        currentWeather = 3;
        bgFraction = 0.35;
        break;
      case "sunny":
        currentWeather = 4;
        bgFraction = 2.35;
        break;
      case "thunderstorm":
        currentWeather = 5;
        bgFraction = 1.5;
        break;
      case "windy":
        currentWeather = 6;
        bgFraction = 0.75;
        break;
    }

    double hour = (widget.model.is24HourFormat
        ? hoursAnim.value
        : (hoursAnim.value % 12));
    final fontSizeHour = MediaQuery.of(context).size.height / 2.7;
    final fontSizeMinute = MediaQuery.of(context).size.height / 1.8;

    return Container(
      color: colors[currentWeather][values.Element.emptySpace],
      child: Center(
        child: Stack(
          children: <Widget>[
            //Bottom most background wave
            WavesBG(
              alignment: 2,
              color: colors[currentWeather][values.Element.background],
              speed: widget.model.temperature.abs() /
                  (widget.model.temperatureString.endsWith("C") ? 10 : 18),
              minSize: MediaQuery.of(context).size.height * 0.375,
              bgFraction: bgFraction,
            ),

            //Middle background wave
            WavesBG(
              alignment: 1,
              color: colors[currentWeather][values.Element.background],
              speed: widget.model.temperature.abs() /
                  (widget.model.temperatureString.endsWith("C") ? 10 : 18),
              minSize: MediaQuery.of(context).size.height * 0.429,
              bgFraction: bgFraction,
            ),

            //Top most background wave
            WavesBG(
              alignment: 0,
              color: colors[currentWeather][values.Element.background],
              speed: widget.model.temperature.abs() /
                  (widget.model.temperatureString.endsWith("C") ? 10 : 18),
              minSize: MediaQuery.of(context).size.height * 0.321,
              bgFraction: bgFraction,
            ),

            AnimatedBuilder(
                animation: hoursAnim,
                builder: (context, child) {
                  int hour1s; //Ten's digit of the hour
                  int hour0s; //One's digit of the hour

                  //Conversion between 24 Hour and 12 Hour formats
                  if (!widget.model.is24HourFormat &&
                      (int.parse(((hour / 10).floor()).toString())) == 0 &&
                      (int.parse((hour.floor()).toString()) % 10) == 0) {
                    hour1s = 1;
                    hour0s = 2;
                  } else {
                    hour1s = int.parse(((hour / 10).floor()).toString());
                    hour0s = int.parse((hour.floor()).toString()) % 10;
                  }

                  //Animate the digits by varying their top padding
                  //Area for displaying the hours
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        child: Stack(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(
                                right:
                                    MediaQuery.of(context).size.height * 0.01,
                                top: ((hour) *
                                    (MediaQuery.of(context).size.height -
                                        fontSizeHour) /
                                    (widget.model.is24HourFormat ? 24 : 12)),
                              ),
                              child: Container(
                                height: fontSizeHour,
                                alignment: Alignment.centerRight,
                                child: Stack(
                                  alignment: Alignment.centerRight,
                                  children: <Widget>[
                                    Padding(
                                      padding: EdgeInsets.only(
                                        right:
                                            MediaQuery.of(context).size.height *
                                                0.04,
                                      ),
                                      child: Image(
                                        image: values.numImages[hour1s],
                                        color: colors[currentWeather]
                                            [values.Element.shadow],
                                        fit: BoxFit.fitHeight,
                                        height: fontSizeHour,
                                      ),
                                    ),
                                    Image(
                                      image: values.numImages[hour1s],
                                      alignment: Alignment.center,
                                      color: colors[currentWeather]
                                          [values.Element.text],
                                      fit: BoxFit.fitHeight,
                                      height: fontSizeHour,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(
                            top: (hour *
                                (MediaQuery.of(context).size.height -
                                    fontSizeHour) /
                                (widget.model.is24HourFormat ? 24 : 12)),
                          ),
                          child: Container(
                            height: fontSizeHour,
                            alignment: Alignment.center,
                            child: Stack(
                              alignment: Alignment.centerRight,
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.only(
                                    right: MediaQuery.of(context).size.height *
                                        0.04,
                                  ),
                                  child: Image(
                                    image: values.numImages[hour0s],
                                    color: colors[currentWeather]
                                        [values.Element.shadow],
                                    fit: BoxFit.fitHeight,
                                    height: fontSizeHour,
                                  ),
                                ),
                                Image(
                                  image: values.numImages[hour0s],
                                  alignment: Alignment.centerLeft,
                                  color: colors[currentWeather]
                                      [values.Element.text],
                                  fit: BoxFit.fitHeight,
                                  height: fontSizeHour,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),

                      //Right side space required for displaying the minutes
                      Container(
                        width: MediaQuery.of(context).size.height,
                      ),
                    ],
                  );
                }),

            //Area for displaying the minutes
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.height / 2,
                  height: MediaQuery.of(context).size.height,
                  alignment: Alignment.topCenter,
                  child: MinutesAnimated(
                    hoursAnim.value,
                    fontSizeMinute,
                    false,
                    colors,
                    currentWeather,
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.height / 2,
                  height: MediaQuery.of(context).size.height,
                  alignment: Alignment.topCenter,
                  child: MinutesAnimated(
                    hoursAnim.value,
                    fontSizeMinute,
                    true,
                    colors,
                    currentWeather,
                  ),
                ),
              ],
            ),

            //Top most foreground wave visible only in "foggy" weather
            Visibility(
              visible: currentWeather == 1,
              child: WavesBG(
                alignment: 0,
                color: colors[currentWeather][values.Element.background],
                speed: widget.model.temperature.abs() /
                    (widget.model.temperatureString.endsWith("C") ? 10 : 18),
                minSize: MediaQuery.of(context).size.height * 0.321,
                bgFraction: 1.2,
              ),
            ),

            //Bottom most foreground wave visible only in "foggy" weather
            Visibility(
              visible: currentWeather == 1,
              child: WavesBG(
                alignment: 2,
                color: colors[currentWeather][values.Element.background],
                speed: widget.model.temperature.abs() /
                    (widget.model.temperatureString.endsWith("C") ? 10 : 18),
                minSize: MediaQuery.of(context).size.height * 0.321,
                bgFraction: 1.2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
