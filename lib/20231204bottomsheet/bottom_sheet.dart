import 'package:flutter/material.dart';

class BottomSheetSample extends StatefulWidget {
  const BottomSheetSample({super.key});

  @override
  State<BottomSheetSample> createState() => _BottomSheetSampleState();
}

class _BottomSheetSampleState extends State<BottomSheetSample> {
  final TextEditingController _textEditingController = TextEditingController();
  String? text1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                decoration: BoxDecoration(
                  color: Colors.blue[200],
                  border: Border.all(
                    color: Colors.black,
                    width: 1,
                  ),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(10.0),
                  ),
                ),
                width: 200,
                padding: const EdgeInsets.all(16.0),
                margin: const EdgeInsets.only(bottom: 16.0),
                child: Text(text1 ?? ' ')),
            ElevatedButton(
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) {
                      return Container(
                        height: 250 + MediaQuery.of(context).viewInsets.bottom,
                        decoration: BoxDecoration(
                          color: Colors.blue[200],
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(20.0),
                            topRight: Radius.circular(20.0),
                          ),
                        ),
                        child: Center(
                            child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Column(
                            children: [
                              const SizedBox(height: 32.0),
                              TextField(
                                controller: _textEditingController,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'テキスト',
                                ),
                              ),
                              ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      text1 = _textEditingController.text;
                                    });
                                    _textEditingController.clear();
                                    Navigator.pop(context);
                                  },
                                  child: const Text('OK')),
                            ],
                          ),
                        )),
                      );
                    },
                  );
                },
                child: const Text('Show Bottom Sheet')),
          ],
        ),
      ),
    );
  }
}
