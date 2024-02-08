import 'package:flutter/material.dart';

class AnimateWidget extends StatefulWidget {
  const AnimateWidget({super.key});

  @override
  State<AnimateWidget> createState() => _AnimateWidgetState();
}

class _AnimateWidgetState extends State<AnimateWidget> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                if (_controller.isCompleted) {
                  _controller.reverse();
                } else {
                  _controller.forward();
                }
              },
              child: const Text('Start/Stop'),
            ),
            const SizedBox(
              height: 150,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                AnimatedBuilder(
                  animation: _controller,
                  builder: (context, child) {
                    return SizedBox(
                      width: 80,
                      child: CustomPaint(
                        painter: MyCustomPainter(
                          animateValue: _controller.value,
                          style: PaintingStyle.fill,
                        ),
                      ),
                    );
                  },
                ),
                SizedBox(
                  width: 80,
                  child: AnimatedBuilder(
                    animation: _controller,
                    builder: (context, child) {
                      return CustomPaint(
                        painter: MyCustomPainter(
                          animateValue: _controller.value,
                          style: PaintingStyle.stroke,
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class MyCustomPainter extends CustomPainter {
  MyCustomPainter({required this.animateValue, required this.style});

  final double animateValue; // アニメーションの値
  final PaintingStyle style; // PaintingStyle.fill or PaintingStyle.stroke

  @override
  void paint(Canvas canvas, Size size) {
    const double peakHeight = 30; // 変形する高さの最大値
    final double animatedHeight = peakHeight * animateValue; // 変形する高さ

    const Offset p1 = Offset(20, 0);
    Offset p2 = Offset(20, -animatedHeight);
    Offset p3 = Offset(40, -animatedHeight);
    Offset p4 = Offset(60, -animatedHeight);
    const Offset p5 = Offset(60, 0);
    const Offset p6 = Offset(80, 0);

    final paint = Paint()
      ..color = Colors.blue
      ..style = style
      ..strokeWidth = 2.0; // ペイントのスタイルを設定

    final path = Path();
    path.cubicTo(
      p1.dx,
      p1.dy,
      p2.dx,
      p2.dy,
      p3.dx,
      p3.dy,
    );
    path.cubicTo(
      p4.dx,
      p4.dy,
      p5.dx,
      p5.dy,
      p6.dx,
      p6.dy,
    );

    canvas.drawPath(path, paint); // キャンバスに描画
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

// class MyCustomPainter extends CustomPainter {
//   MyCustomPainter({required this.animateValue});

//   final double animateValue;

//   @override
//   void paint(Canvas canvas, Size size) {
//     const double pointStrength = 20;
//     const double peakHeight = 20;
//     const double height = 80;
//     const double width = 80;

//     final double animatedHeight = peakHeight * animateValue;

//     final Offset p1 = Offset(pointStrength, -height);
//     final Offset p2 = Offset(width / 2 - pointStrength, -height - animatedHeight);
//     final Offset p3 = Offset(width / 2, -height - animatedHeight);
//     final Offset p4 = Offset(width / 2 + pointStrength, -height - animatedHeight);
//     final Offset p5 = Offset(width - pointStrength, -height);
//     final Offset p6 = Offset(width, -height);

//     final paint = Paint()
//       ..color = Colors.blue
//       ..style = PaintingStyle.fill;

//     final path = Path();
//     path.lineTo(0, -height);
//     path.cubicTo(
//       p1.dx,
//       p1.dy,
//       p2.dx,
//       p2.dy,
//       p3.dx,
//       p3.dy,
//     );
//     path.cubicTo(
//       p4.dx,
//       p4.dy,
//       p5.dx,
//       p5.dy,
//       p6.dx,
//       p6.dy,
//     );
//     path.lineTo(width, 0);
//     path.close();

//     canvas.drawPath(path.shift(Offset(-width / 2, 0)), paint);
//   }

//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) {
//     return false;
//   }
// }
