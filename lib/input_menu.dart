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
        SizedBox(height: 10),
        InputField(formStore, 'age'),
        SizedBox(height: 10),
        InputField(formStore, 'height'),
        UserDropdownMenu(formStore, genderList),
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

  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      );

  @override
  State<InputField> createState() => getInputStateClassFromInputType(inputType);
}

class _UserNameInputFieldState extends State<InputField> {
  final FormStore formStore;
  _UserNameInputFieldState(this.formStore);

  @override
  Widget build(BuildContext context) => Observer(
      builder: (_) => TextField(
            onChanged: (value) => formStore.setUsername(value),
            decoration: InputDecoration(
                labelText: 'Name',
                hintText: 'Your name',
                errorText: formStore.error.name),
          ));
}

class _UserAgeInputFieldState extends State<InputField> {
  final FormStore formStore;
  _UserAgeInputFieldState(this.formStore);

  @override
  Widget build(BuildContext context) => Observer(
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
          ));
}

class _UserHeightInputFieldState extends State<InputField> {
  final FormStore formStore;
  _UserHeightInputFieldState(this.formStore);

  @override
  Widget build(BuildContext context) => Observer(
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
          ));
}

class UserDropdownMenu extends StatefulWidget {
  final FormStore formStore;
  final List<String> selectionList;
  UserDropdownMenu(this.formStore, this.selectionList, {super.key});

  void initState() {
    initState();
    formStore.setupValidations();
  }

  void dispose() {
    formStore.dispose();
    dispose();
  }

  @override
  State<UserDropdownMenu> createState() =>
      _UserDropdownMenuState(formStore, selectionList);
}

class _UserDropdownMenuState extends State<UserDropdownMenu> {
  final FormStore formStore;
  final List<String> selectionList;
  _UserDropdownMenuState(this.formStore, this.selectionList);

  void setGenderAsBool(String value) {
    if (value == 'Male') {
      formStore.setMale(true);
    } else {
      formStore.setMale(false);
    }
  }

  @override
  Widget build(BuildContext context) => Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      child: Observer(
          builder: (_) => DropdownMenu(
                initialSelection: selectionList.first,
                onSelected: (value) {
                  setGenderAsBool(value!);
                },
                dropdownMenuEntries: selectionList
                    .map<DropdownMenuEntry<String>>((String value) {
                  return DropdownMenuEntry<String>(value: value, label: value);
                }).toList(),
              )));
}
