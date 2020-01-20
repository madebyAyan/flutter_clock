import 'package:flutter/material.dart';
import 'dart:math';

//Clipper for creating the wave in the background
class BGClipper extends CustomClipper<Path> {
  BGClipper(
    this.height1,
  );

  double height1;

  @override
  Path getClip(Size size) {
    var path = Path();

    path.lineTo(
      0,
      15 + sin(-height1) * (15),
    );
    path.quadraticBezierTo(
      size.width / 2,
      15 + sin(height1 - 45) * (-15) * 2,
      size.width,
      15 + sin(height1) * (15),
    );
    path.lineTo(
      size.width,
      size.height - 15 + sin(-height1) * (15),
    );
    path.quadraticBezierTo(
      size.width / 2,
      size.height - 15 + sin(height1 - 45) * (-15) * 2,
      0,
      size.height - 15 + sin(height1) * (15),
    );

    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}

//Clipper used for filling the up the digits
class TimeDisplayClipper extends CustomClipper<Rect> {
  TimeDisplayClipper(this.time, this.segments);

  double time;
  int segments;

  @override
  Rect getClip(Size size) {
    var rect = Rect.fromLTRB(
      0,
      size.height - ((size.height / segments) * time),
      size.width,
      size.height,
    );

    return rect;
  }

  @override
  bool shouldReclip(CustomClipper<Rect> oldClipper) {
    return true;
  }
}
