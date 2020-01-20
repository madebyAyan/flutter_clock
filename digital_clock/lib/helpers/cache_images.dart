import 'package:flutter/material.dart';
import 'package:digital_clock/digital_clock.dart';
import 'package:flutter_clock_helper/model.dart';

//A StatelessWidget for pre caching the images which are used as digits
class ImageCacheArea extends StatelessWidget {
  const ImageCacheArea(
    this.model,
  );

  final ClockModel model;

  @override
  Widget build(BuildContext context) {
    precacheImage(
      AssetImage("assets/graphics/num_0.png"),
      context,
    );
    precacheImage(
      AssetImage("assets/graphics/num_1.png"),
      context,
    );
    precacheImage(
      AssetImage("assets/graphics/num_2.png"),
      context,
    );
    precacheImage(
      AssetImage("assets/graphics/num_3.png"),
      context,
    );
    precacheImage(
      AssetImage("assets/graphics/num_4.png"),
      context,
    );
    precacheImage(
      AssetImage("assets/graphics/num_5.png"),
      context,
    );
    precacheImage(
      AssetImage("assets/graphics/num_6.png"),
      context,
    );
    precacheImage(
      AssetImage("assets/graphics/num_7.png"),
      context,
    );
    precacheImage(
      AssetImage("assets/graphics/num_8.png"),
      context,
    );
    precacheImage(
      AssetImage("assets/graphics/num_9.png"),
      context,
    );
    return DigitalClock(model);
  }
}
