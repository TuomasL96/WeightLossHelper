// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';

import 'input_widgets.dart';

class UserProfileCreatorMenu extends StatelessWidget {
  const UserProfileCreatorMenu({super.key});

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
