import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter/services.dart';
import 'package:mobx/mobx.dart';
import 'user_profile_form.dart';

final FormStore formStore = FormStore();

CustomDropDownMenu genderDropDownMenu = CustomDropDownMenu(
    hint: 'Your sex',
    onSelected: (value) {
      formStore.setMale(value);
    },
    dropDownList: const <String>['Male', 'Female']);

CustomInputField nameInputField = CustomInputField(
  'Name',
  'Enter your name',
  formStore.error.name,
  TextInputType.name,
  FilteringTextInputFormatter.deny(''),
  onChanged: (value) {
    formStore.setUsername(value);
  },
);

CustomInputField heightInputField = CustomInputField(
  'Height',
  'Enter your height (cm)',
  formStore.error.height,
  TextInputType.number,
  FilteringTextInputFormatter.digitsOnly,
  onChanged: (value) {
    formStore.setHeight(value);
  },
);

CustomInputField ageInputField = CustomInputField(
  'Age',
  'Enter your age (years)',
  formStore.error.age,
  TextInputType.number,
  FilteringTextInputFormatter.digitsOnly,
  onChanged: (value) {
    formStore.setAge(value);
  },
);

ElevatedButton createAccountButton = ElevatedButton(
    onPressed: formStore.validateAll, child: const Text('Create account'));

class CustomInputField extends StatefulWidget {
  final String labelText;
  final String hintText;
  final String? errorText;
  final void Function(String) onChanged;
  final TextInputType? keyboardType;
  final TextInputFormatter textInputFormatter;

  const CustomInputField(
    this.labelText,
    this.hintText,
    this.errorText,
    this.keyboardType,
    this.textInputFormatter, {
    required this.onChanged,
    super.key,
  });

  //final inputController = TextEditingController();
  @override
  State<CustomInputField> createState() => _CustomInputFieldState();
}

class _CustomInputFieldState extends State<CustomInputField> {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: Observer(
          builder: (_) => TextField(
              keyboardType: widget.keyboardType,
              inputFormatters: <TextInputFormatter>[widget.textInputFormatter],
              onChanged: widget.onChanged,
              decoration: InputDecoration(
                labelText: widget.labelText,
                hintText: widget.hintText,
                errorText: formStore.error.name,
              )),
        ));
  }
}

class CustomDropDownMenu extends StatelessWidget {
  final double? height;
  final double? width;
  final String hint;
  final List<String> dropDownList;
  final ValueSetter onSelected;

  const CustomDropDownMenu(
      {super.key,
      this.height,
      this.width,
      required this.hint,
      required this.onSelected,
      required this.dropDownList});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? 70,
      width: width ?? double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Observer(
          builder: (_) => DropdownMenu(
                initialSelection: dropDownList.first,
                onSelected: onSelected,
                dropdownMenuEntries:
                    dropDownList.map<DropdownMenuEntry<String>>((String value) {
                  return DropdownMenuEntry<String>(value: value, label: value);
                }).toList(),
              )),
    );
  }
}
