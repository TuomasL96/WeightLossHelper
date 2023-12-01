// ignore_for_file: prefer_const_constructors
import 'user_profile_form.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter/material.dart';

class UserProfileCreatorMenu extends StatelessWidget {
  const UserProfileCreatorMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      child: UserProfileInputField('test'),
      //   Column(crossAxisAlignment: CrossAxisAlignment.start, children: const [
      // UserProfileInputField('Name'),
      // UserProfileInputField('Height'),
      // UserProfileInputField('Age'),
      //]),
    );
  }
}

class UserProfileInputField extends StatefulWidget {
  final String inputText;
  const UserProfileInputField(this.inputText, {super.key});

  State<StatefulWidget> createState() => _MyInputState(inputText);
}

class _MyInputState extends State<UserProfileInputField> {
  final String measurement;
  final FormStore store = FormStore();

  _MyInputState(this.measurement);
  final inputController = TextEditingController();

  @override
  void initState() {
    super.initState();
    store.setupValidations();
  }

  void dispose() {
    //inputController.dispose();
    store.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
        title: const Text('Login Form'),
      ),
      body: Form(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: <Widget>[
              Observer(
                builder: (_) => TextField(
                  onChanged: (value) => store.setUsername(value),
                  decoration: InputDecoration(
                      labelText: 'Username',
                      hintText: 'Pick a username',
                      errorText: store.error.username),
                ),
              ),
              Observer(
                  builder: (_) => AnimatedOpacity(
                      duration: const Duration(milliseconds: 300),
                      //opacity: store.isUserCheckPending ? 1 : 0,
                      opacity: 0.1,
                      child: const LinearProgressIndicator())),
              Observer(
                builder: (_) => TextField(
                  keyboardType: TextInputType.number,
                  onChanged: (value) => store.setAge(value),
                  decoration: InputDecoration(
                      labelText: 'Age',
                      hintText: 'Enter your age',
                      errorText: store.error.age),
                ),
              ),
              Observer(
                builder: (_) => TextField(
                  keyboardType: TextInputType.number,
                  onChanged: (value) => store.setHeight(value),
                  decoration: InputDecoration(
                      labelText: 'Height',
                      hintText: 'Enter your height',
                      errorText: store.error.height),
                ),
              ),
              ElevatedButton(
                onPressed: store.validateAll,
                child: const Text('Create account'),
              )
            ],
          ),
        ),
      ));
/*   Widget build(BuildContext context) {
    final value = inputController.text;
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: TextField(
          controller: inputController,
          decoration: InputDecoration(
              border: OutlineInputBorder(), hintText: 'Enter $measurement'),
        ));
  } */
}
