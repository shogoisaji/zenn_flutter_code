import 'package:flutter/material.dart';

class RenderingSample extends StatefulWidget {
  const RenderingSample({
    super.key,
  });
  @override
  State<RenderingSample> createState() => _RenderingSampleState();
}

class _RenderingSampleState extends State<RenderingSample> {
  final GlobalKey _containerKey = GlobalKey();
  Size containerSize = Size.zero;

  void getContainerSize() {
    final RenderBox? renderBox = _containerKey.currentContext?.findRenderObject() as RenderBox?;
    Offset? position = renderBox?.localToGlobal(Offset.zero);
    print(position);

    setState(() {
      containerSize = renderBox?.size ?? Size.zero;
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => getContainerSize());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            color: Colors.blue,
            height: 100,
            width: double.infinity,
            child: const Center(
              child: Text(
                'Height: 100',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              key: _containerKey,
              color: Colors.red,
              child: Center(
                child: Text(
                  'ContainerSize: ${containerSize.width} x ${containerSize.height}\nMediaQuery   :${MediaQuery.of(context).size.width} x ${MediaQuery.of(context).size.height}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
