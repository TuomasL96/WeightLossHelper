import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class WeightInMenu extends StatelessWidget {
  const WeightInMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class WeightPicker extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Card(
      elevation: 2.0,
      child: ListTile(
        leading: Icon(
          Icons.monitor_weight,
        ),
        title: Column(children: [DatePickerTheme(data: data, child: child)]),
      ),
    );
  }
}
