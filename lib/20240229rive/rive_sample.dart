import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class RiveSample extends StatefulWidget {
  const RiveSample({super.key});

  @override
  State<RiveSample> createState() => _RiveSampleState();
}

class _RiveSampleState extends State<RiveSample> {
  SMIInput<bool>? _isDarkModeInput;
  SMIInput<bool>? _isMoveInput;
  SMIInput<double>? _count;

  String _currentAnimationState = '';

  /// アニメーションの状態が変わった時の処理
  void _onStateChange(
    String stateMachineName,
    String stateName,
  ) =>
      setState(
        () => _currentAnimationState = stateName,
      );

  void _onRiveInit(Artboard artboard) {
    final controller = StateMachineController.fromArtboard(
      artboard,
      'State Machine 1',
      onStateChange: _onStateChange,
    );
    artboard.addController(controller!);

    _isDarkModeInput = controller.findInput<bool>('isDark') as SMIBool;
    _isMoveInput = controller.findInput<bool>('isMove') as SMIBool;
    _count = controller.findInput<double>('count') as SMINumber;

    /// 初期値の入力
    _count?.value = 0;
    _isDarkModeInput?.value = false;
    _isMoveInput?.value = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /// RiveAnimationのisDarkを監視して、BGを変更
      backgroundColor: _isDarkModeInput != null
          ? _isDarkModeInput!.value
              ? Colors.grey
              : Colors.white
          : Colors.white,
      body: Center(
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              height: 300,
              child: RiveAnimation.asset(
                'assets/rive/sample.riv',
                onInit: _onRiveInit,
                fit: BoxFit.contain,
              ),
            ),
            Text(
              "count : ${_count != null ? _count!.value : ""}",
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(
              "animation state : $_currentAnimationState",
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Dark Mode"),
                Switch(
                  onChanged: (value) => setState(() {
                    _isDarkModeInput!.value = !_isDarkModeInput!.value;
                  }),
                  value: _isDarkModeInput != null ? _isDarkModeInput!.value : false,
                ),
              ],
            ),
            ElevatedButton(
              onPressed: () {
                _isMoveInput!.value = !_isMoveInput!.value;
              },
              child: Text(_isMoveInput != null
                  ? _isMoveInput!.value
                      ? "Reset"
                      : "Move"
                  : "Move"),
            ),
          ],
        ),
      ),
    );
  }
}
