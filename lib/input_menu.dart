// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'input_widgets.dart';
import 'user_profile_form.dart';

class UserProfileCreatorMenu extends StatefulWidget {
  const UserProfileCreatorMenu({super.key});

  @override
  State<UserProfileCreatorMenu> createState() => _UserProfileCreatorMenuState();
}

class _UserProfileCreatorMenuState extends State<UserProfileCreatorMenu> {
  final FormStore formStore = FormStore();
  @override
  void initState() {
    super.initState();
    formStore.setupValidations();
  }

  @override
  void dispose() {
    //inputController.dispose();
    formStore.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      child: Column(children: [
        nameInputField,
        heightInputField,
        ageInputField,
        genderDropDownMenu,
        createAccountButton,
      ]),
    );
  }
}
