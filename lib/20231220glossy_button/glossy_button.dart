import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InteractiveButton extends StatefulWidget {
  const InteractiveButton({Key? key}) : super(key: key);

  @override
  _InteractiveButtonState createState() => _InteractiveButtonState();
}

class _InteractiveButtonState extends State<InteractiveButton> {
  final GlobalKey containerKey = GlobalKey();
  Offset mousePosition = const Offset(0, 0);
  Offset buttonCenter = const Offset(0, 0);
  Alignment mouseHoverAlignment = Alignment.topLeft;
  Size renderBoxSize = const Size(0, 0);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      RenderBox renderBox = containerKey.currentContext!.findRenderObject() as RenderBox;
      Offset buttonPosition = renderBox.localToGlobal(Offset.zero);
      setState(() {
        // レンダリングされたボタンの中心座標を計算
        buttonCenter =
            Offset(buttonPosition.dx + renderBox.size.width / 2, buttonPosition.dy + renderBox.size.height / 2);
        renderBoxSize = renderBox.size;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    const double buttonWidth = 300.0;
    const double buttonHeight = buttonWidth / 2.5;
    const double borderWidth = 3;

    return Scaffold(
      backgroundColor: Colors.blue[200],
      body: Center(
        child: MouseRegion(
          onHover: (PointerHoverEvent event) {
            setState(() {
              mousePosition = event.position;
              // カーソルからボタン中心までの距離をAlignmentで表現
              mouseHoverAlignment = Alignment((mousePosition.dx - buttonCenter.dx) / renderBoxSize.width * 2,
                  (mousePosition.dy - buttonCenter.dy) / renderBoxSize.height * 2);
            });
          },
          child: Container(
            padding: const EdgeInsets.all(100), // カーソル反応開始範囲
            decoration: const BoxDecoration(
              border: Border.fromBorderSide(BorderSide(color: Colors.grey, width: 1)),
            ),
            child: GestureDetector(
              onTap: () => print('Tapped'),
              // outer Button
              child: Container(
                key: containerKey, // ボタン座標を取得するためのKey
                width: buttonWidth,
                height: buttonHeight,
                padding: const EdgeInsets.all(borderWidth),
                decoration: BoxDecoration(
                  // borderのグラデーション
                  gradient: const LinearGradient(
                    begin: Alignment(0.9, -1.5),
                    end: Alignment.bottomRight,
                    colors: [Color.fromARGB(255, 255, 234, 234), Color.fromARGB(255, 120, 22, 22)],
                  ),
                  borderRadius: const BorderRadius.all(Radius.circular(buttonHeight / 3)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.5),
                      blurRadius: 10,
                      offset: const Offset(5, 5),
                    ),
                  ],
                ),
                // inner Button
                child: Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(buttonHeight / 3)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.red,
                          spreadRadius: -5,
                          blurRadius: 10,
                          offset: Offset(0, 0),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(buttonHeight / 3)),
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: RadialGradient(
                            center: mouseHoverAlignment, // グラデーションの中心をカーソルの位置にする
                            radius: 1.5,
                            colors: const [
                              Colors.white70,
                              Colors.white70,
                              Colors.white60,
                              Colors.white38,
                              Colors.white12
                            ],
                          ),
                        ),
                        child: const Center(
                          child: Text(
                            'Button',
                            style: TextStyle(
                              fontSize: 50,
                              fontWeight: FontWeight.bold,
                              color: Colors.black54,
                            ),
                          ),
                        ),
                      ),
                    )),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
