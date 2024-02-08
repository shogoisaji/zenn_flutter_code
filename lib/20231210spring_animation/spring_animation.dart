import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';

class SpringAnimation extends StatefulWidget {
  const SpringAnimation({super.key});

  @override
  State<SpringAnimation> createState() => _SpringAnimationState();
}

class _SpringAnimationState extends State<SpringAnimation> with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
      upperBound: 1.2, // animation value limit 120%
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _animationForward() {
    const springDescription = SpringDescription(
      mass: 0.9, //質量
      stiffness: 190.0, //バネの硬さ
      damping: 15.0, //減衰
    );
    final simulation =
        SpringSimulation(springDescription, _animationController.value, 1, _animationController.velocity);
    _animationController.animateWith(simulation);
  }

  @override
  Widget build(BuildContext context) {
    const double size = 50.0;
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 300,
                    height: 200,
                    color: Colors.red[100],
                    child: Center(
                      child: AnimatedBuilder(
                        animation: _animationController,
                        builder: (context, child) {
                          double t = _animationController.drive(Tween(begin: 0.0, end: 80.0)).value;
                          return Transform.translate(
                            offset: Offset(t, 0),
                            child: Container(
                              width: size * 2,
                              height: size,
                              decoration:
                                  BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(size / 2)),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  Container(
                    width: 300,
                    height: 200,
                    color: Colors.green[100],
                    child: Center(
                      child: AnimatedBuilder(
                        animation: _animationController,
                        builder: (context, child) {
                          double r = _animationController.drive(Tween(begin: 0.0, end: 3.14 / 2)).value;
                          return Transform.rotate(
                            angle: r,
                            child: Container(
                              width: size * 2,
                              height: size,
                              decoration:
                                  BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(size / 2)),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  Container(
                    width: 300,
                    height: 200,
                    color: Colors.orange[100],
                    child: Center(
                      child: AnimatedBuilder(
                        animation: _animationController,
                        builder: (context, child) {
                          double s = _animationController
                              .drive(Tween(begin: size, end: size * 1.5))
                              .value; // s : size -> size * 1.5
                          return Container(
                            width: s * 2,
                            height: s,
                            decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(s / 2)),
                          );
                        },
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _animationForward();
                    },
                    child: const Text('start'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _animationController.reverse();
                    },
                    child: const Text('reset'),
                  ),
                ],
              ),
              AnimatedBuilder(
                animation: _animationController,
                builder: (context, child) {
                  double s = _animationController.drive(Tween(begin: -100.0, end: 0.0)).value;
                  return Transform.translate(
                      offset: Offset(0, -s),
                      child: Container(
                        width: 200,
                        height: 100,
                        margin: const EdgeInsets.only(top: 32.0),
                        decoration: BoxDecoration(
                          color:
                              Colors.red.withOpacity(_animationController.value > 1 ? 1 : _animationController.value),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(10.0),
                          ),
                        ),
                        child: Center(
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Attention!',
                              style: TextStyle(
                                  fontSize: 24.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white
                                      .withOpacity(_animationController.value > 1 ? 1 : _animationController.value)),
                            ),
                            Text(
                              'validation error',
                              style: TextStyle(
                                  fontSize: 20.0,
                                  color: Colors.white
                                      .withOpacity(_animationController.value > 1 ? 1 : _animationController.value)),
                            ),
                          ],
                        )),
                      ));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
