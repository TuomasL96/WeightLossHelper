import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'weigh_in_form.dart';
import 'package:flutter/services.dart';

class WeightInForm extends StatefulWidget {
  const WeightInForm({super.key});

  @override
  State<WeightInForm> createState() => _WeightInFormState();
}

class _WeightInFormState extends State<WeightInForm> {
  final WeightFormStore store = WeightFormStore();

  @override
  void initState() {
    super.initState();
    store.setupValidations();
  }

  @override
  void dispose() {
    store.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: Observer(builder: (_) => DatePickerButton(store)),
            ),
            Expanded(
              child: Observer(builder: (_) => UserWeightInputField(store)),
            )
          ],
        ),
        ElevatedButton(onPressed: store.validateAll, child: const Text('Save'))
      ],
    );
  }
}

class DatePickerButton extends StatefulWidget {
  final WeightFormStore store;
  const DatePickerButton(this.store, {super.key});

  @override
  State<DatePickerButton> createState() => _DatePickerButtonState();
}

class _DatePickerButtonState extends State<DatePickerButton> {
  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? date = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(
            selectedDate.year - 1, selectedDate.month, selectedDate.day),
        lastDate: DateTime(
            selectedDate.year + 1, selectedDate.month, selectedDate.day));
    if (date != null && date != selectedDate) {
      setState(() {
        selectedDate = date;
        widget.store.date = selectedDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text("${selectedDate.toLocal()}".split(' ')[0]),
        Padding(
            padding: const EdgeInsets.all(10),
            child: ElevatedButton(
                onPressed: () => _selectDate(context),
                child: const Text('Select date'))),
      ],
    );
  }
}

class UserWeightInputField extends StatefulWidget {
  final WeightFormStore store;
  const UserWeightInputField(this.store, {super.key});

  @override
  State<UserWeightInputField> createState() => _UserWeightInputFieldState();
}

class _UserWeightInputFieldState extends State<UserWeightInputField> {
  @override
  Widget build(BuildContext context) {
    return TextField(
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp('[0-9.]')),
        ],
        onChanged: (value) => widget.store.weight = double.parse(value),
        decoration: const InputDecoration(
          labelText: 'Weight',
          hintText: 'Your Weight',
        ));
  }
}

/* class WeightPicker extends StatelessWidget {
  late DateTime date;
  late Float weight;

  WeightPicker({super.key});
  @override
  Widget build(BuildContext context) {
    return const Card(
      elevation: 2.0,
      child: ListTile(
        title: Column(children: [DatePickerButton()]),
      ),
    );
  }
} */