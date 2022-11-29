//雪を降らせる処理を書いています。

import 'dart:math';

import 'package:flutter/material.dart';

class SnowWidget extends StatefulWidget {
  final int totalSnow;
  final double speed;
  final bool isRunning;

  SnowWidget(
      {Key? key,
      required this.totalSnow,
      required this.speed,
      required this.isRunning})
      : super(key: key);

  _SnowWidgetState createState() => _SnowWidgetState();
}

class _SnowWidgetState extends State<SnowWidget>
    with SingleTickerProviderStateMixin {
  Random _rnd = Random();
  late AnimationController controller = AnimationController(
      lowerBound: 1,
      upperBound: 1,
      vsync: this,
      duration: const Duration(milliseconds: 400000));

  List<Snow> _snows = [];
  double angle = 0;
  double W = 0;
  double H = 0;
  Color snowColor = const Color.fromARGB(255, 28, 28, 29);
  @override
  void initState() {
    super.initState();
    _createSnow();
    init();

    //Future(() async {
    // await Future.delayed(const Duration(seconds: 6));
    snowColor = Colors.white;
    // });
  }

  init() {
    _rnd = Random();
    controller = AnimationController(
        lowerBound: 0,
        upperBound: 1,
        vsync: this,
        duration: const Duration(milliseconds: 2000));
    controller.addListener(() {
      if (mounted) {
        setState(() {
          update();
        });
      }
    });
    if (!widget.isRunning) {
      controller.stop();
    } else {
      controller.repeat();
    }
  }

  @override
  dispose() {
    controller.dispose();
    super.dispose();
  }

  _createSnow() {
    _snows = [];
    for (var i = 0; i < widget.totalSnow; i++) {
      _snows.add(Snow(
          x: _rnd.nextDouble() * W,
          y: _rnd.nextDouble() * H,
          r: _rnd.nextDouble() * 4 + 1,
          d: _rnd.nextDouble() * widget.speed));
    }
  }

  update() {
    angle += 0.01;

    for (var i = 0; i < widget.totalSnow; i++) {
      var snow = _snows[i];
      //We will add 1 to the cos function to prevent negative values which will lead flakes to move upwards
      //Every particle has its own density which can be used to make the downward movement different for each flake
      //Lets make it more random by adding in the radius
      snow.y += (cos(angle + snow.d) + 1 + snow.r / 2) * widget.speed;
      snow.x += sin(angle) * 2 * widget.speed;
      if (snow.x > W + 5 || snow.x < -5 || snow.y > H) {
        if (i % 3 > 0) {
          _snows[i] =
              Snow(x: _rnd.nextDouble() * W, y: -10, r: snow.r, d: snow.d);
        } else {
          if (sin(angle) > 0) {
            _snows[i] = Snow(
                x: -5, y: _rnd.nextDouble().abs() * H, r: snow.r, d: snow.d);
          } else {
            _snows[i] = Snow(
                x: W + 5, y: _rnd.nextDouble().abs() * H, r: snow.r, d: snow.d);
          }
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isRunning && !controller.isAnimating) {
      controller.repeat();
    } else if (!widget.isRunning && controller.isAnimating) {
      controller.stop();
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        W = constraints.maxWidth;
        H = constraints.maxHeight;
        return CustomPaint(
          willChange: widget.isRunning,
          painter: SnowPainter(
              isRunning: widget.isRunning, snows: _snows, snowColor: snowColor),
          size: Size.infinite,
        );
      },
    );
  }
}

class Snow {
  double x;
  double y;
  double r; //radius
  double d; //density
  Snow({required this.x, required this.y, required this.r, required this.d});
}

class SnowPainter extends CustomPainter {
  List<Snow> snows;
  bool isRunning;
  Color snowColor;

  SnowPainter(
      {required this.isRunning, required this.snows, required this.snowColor});

  @override
  void paint(Canvas canvas, Size size) {
    if (!isRunning) return;
    final Paint paint = Paint()
      ..color = snowColor.withOpacity(0.8)
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 10.0;
    for (var i = 0; i < snows.length; i++) {
      var snow = snows[i];
      canvas.drawCircle(Offset(snow.x, snow.y), snow.r, paint);
    }
  }

  @override
  bool shouldRepaint(SnowPainter oldDelegate) => isRunning;
}
