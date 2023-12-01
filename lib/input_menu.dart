// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class InputMenu extends StatelessWidget {
  const InputMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      InputField('Height'),
      InputField('Weight'),
      InputField('Age')
    ]);
  }
}

class InputField extends StatefulWidget {
  final String measurement;
  const InputField(this.measurement, {super.key});

  @override
  State<StatefulWidget> createState() => _MyInputState(measurement);
}

class _MyInputState extends State<InputField> {
  final String measurement;
  _MyInputState(this.measurement);
  final inputController = TextEditingController();

  @override
  void dispose() {
    inputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final value = inputController.text;
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: TextField(
          controller: inputController,
          decoration: InputDecoration(
              border: OutlineInputBorder(), hintText: 'Enter $measurement'),
        ));
  }
}
