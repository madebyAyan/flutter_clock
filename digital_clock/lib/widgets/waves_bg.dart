import 'package:flutter/material.dart';
import 'package:digital_clock/helpers/clippers.dart';

//Setting up and animating the wave in the background
class WavesBG extends StatefulWidget {
  WavesBG({
    this.alignment,
    this.color,
    this.speed,
    this.minSize,
    this.bgFraction,
  });

  int alignment;
  Color color;
  double speed;
  double minSize;
  double bgFraction;

  @override
  _WavesBGState createState() => _WavesBGState();
}

class _WavesBGState extends State<WavesBG> with TickerProviderStateMixin {
  Animation<double> flowAnim;
  AnimationController flowAC;

  @override
  void dispose() {
    flowAC.dispose();
    super.dispose();
  }

  @override
  void initState() {
    flowAC = AnimationController(
      duration: Duration(
        seconds: 60,
      ),
      vsync: this,
    )..forward();

    flowAnim = Tween<double>(begin: widget.minSize, end: 180).animate(flowAC)
      ..addListener(() {
        if (flowAnim.isDismissed) {
          flowAC.forward();
        }
        if (flowAnim.isCompleted) {
          flowAC.reverse();
        }
      });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: (widget.alignment == 0)
          ? Alignment.topCenter
          : ((widget.alignment == 1)
              ? Alignment.center
              : Alignment.bottomCenter),
      child: AnimatedBuilder(
          animation: flowAC,
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: widget.color,
          ),
          builder: (context, child) {
            return ClipPath(
              clipper: BGClipper(flowAnim.value * (widget.speed)),
              child: FractionallySizedBox(
                widthFactor: 1,
                heightFactor: flowAnim.value /
                    (MediaQuery.of(context).size.height / widget.bgFraction),
                child: child,
              ),
            );
          }),
    );
  }
}
