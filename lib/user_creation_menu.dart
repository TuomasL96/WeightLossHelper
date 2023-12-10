// ignore_for_file: prefer_const_constructors
import 'package:flutter/services.dart';

import 'user_profile_form.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter/material.dart';

class UserProfileCreatorMenu extends StatelessWidget {
  UserProfileCreatorMenu({super.key});
  final FormStore formStore = FormStore();
  final List<String> genderList = <String>['Male', 'Female'];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      child: Column(children: [
        InputField(formStore, 'username'),
        InputField(formStore, 'age'),
        InputField(formStore, 'height'),
        CustomDropDownMenu(
            hint: 'Your sex',
            onSelected: (value) {
              formStore.setMale(value);
            },
            dropDownList: genderList),
        ElevatedButton(
            onPressed: formStore.validateAll,
            child: const Text('Create account'))
      ]),
    );
  }
}

class InputField extends StatefulWidget {
  final FormStore formStore;
  final String inputType;

  InputField(
    this.formStore,
    this.inputType, {
    super.key,
  });

  final inputController = TextEditingController();

  void initState() {
    initState();
    formStore.setupValidations();
  }

  void dispose() {
    inputController.dispose();
    formStore.dispose();
    dispose();
  }

  getInputStateClassFromInputType(inputType) {
    switch (inputType) {
      case 'username':
        return _UserNameInputFieldState(formStore);
      case 'age':
        return _UserAgeInputFieldState(formStore);
      case 'height':
        return _UserHeightInputFieldState(formStore);
      case _:
        throw "inputType doesn't match any value!!";
    }
  }

  @override
  State<InputField> createState() => getInputStateClassFromInputType(inputType);
}

class _UserNameInputFieldState extends State<InputField> {
  final FormStore formStore;
  _UserNameInputFieldState(this.formStore);

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: Observer(
            builder: (_) => TextField(
                  onChanged: (value) => formStore.name = value,
                  decoration: InputDecoration(
                      labelText: 'Name',
                      hintText: 'Your name',
                      errorText: formStore.error.name),
                )),
      );
}

class _UserAgeInputFieldState extends State<InputField> {
  final FormStore formStore;
  _UserAgeInputFieldState(this.formStore);

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: Observer(
            builder: (_) => TextField(
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  onChanged: (value) => formStore.setAge(value),
                  decoration: InputDecoration(
                      labelText: 'Age',
                      hintText: 'Your age',
                      errorText: formStore.error.age),
                )),
      );
}

class _UserHeightInputFieldState extends State<InputField> {
  final FormStore formStore;
  _UserHeightInputFieldState(this.formStore);

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: Observer(
            builder: (_) => TextField(
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  onChanged: (value) => formStore.setHeight(value),
                  decoration: InputDecoration(
                      labelText: 'Height',
                      hintText: 'Your height',
                      errorText: formStore.error.height),
                )),
      );
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
