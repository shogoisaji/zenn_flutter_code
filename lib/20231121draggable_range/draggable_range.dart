import 'package:flutter/material.dart';

class DraggableRange extends StatefulWidget {
  const DraggableRange({
    super.key,
  });
  @override
  State<DraggableRange> createState() => _DraggableRangeState();
}

class _DraggableRangeState extends State<DraggableRange> {
  final double _moveBlockSize = 100;
  final Size _moveRange = const Size(500, 500);
  Offset _moveBlockOffset = Offset.zero;

  void clampMoveBlockOffset() {
    double clampedX = _moveBlockOffset.dx.clamp(0, _moveRange.width - _moveBlockSize);
    double clampedY = _moveBlockOffset.dy.clamp(0, _moveRange.height - _moveBlockSize);
    _moveBlockOffset = Offset(clampedX, clampedY);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: _moveRange.width,
        height: _moveRange.height,
        color: Colors.green,
        margin: const EdgeInsets.only(top: 100, left: 100),
        child: Stack(
          children: [
            Positioned(
              left: _moveBlockOffset.dx,
              top: _moveBlockOffset.dy,
              child: Container(
                color: Colors.red,
                height: _moveBlockSize,
                width: _moveBlockSize,
              ),
            ),
            Positioned(
              left: _moveBlockOffset.dx,
              top: _moveBlockOffset.dy,
              child: Draggable(
                onDragUpdate: (details) {
                  setState(() {
                    _moveBlockOffset = Offset(
                      _moveBlockOffset.dx + details.delta.dx,
                      _moveBlockOffset.dy + details.delta.dy,
                    );
                    clampMoveBlockOffset();
                  });
                },
                childWhenDragging: Container(),
                feedback: Container(),
                child: Container(
                  color: Colors.transparent,
                  height: _moveBlockSize,
                  width: _moveBlockSize,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
