import 'dart:ffi';
import 'package:mobx/mobx.dart';
import 'package:open_weight_tracker/main.dart';
import 'package:open_weight_tracker/models.dart';
import 'package:validators2/validators2.dart';
import 'user_repository.dart';

part 'user_profile_form.g.dart';

UserRepository userRepository = UserRepository();

class FormStore = _FormStore with _$FormStore;

abstract class _FormStore with Store {
  @observable
  String name = '';

  @observable
  String age = '';

  @observable
  String height = '';

  @observable
  bool isMale = true;

  late List<ReactionDisposer> _disposers;

  void setupValidations() {
    _disposers = [
      reaction((_) => name, validateUsername),
      reaction((_) => age, validateAge),
      reaction((_) => height, validateHeight),
    ];
  }

  void validateAll() {
    validateAge(age);
    validateHeight(height);
    validateUsername(name);
    if (!error.hasErrors) {
      userRepository.save(User(name, age, height, isMale));
    }
  }

  @action
  void setUsername(String value) {
    name = value;
  }

  @action
  void setAge(String value) {
    age = value;
  }

  @action
  void setHeight(String value) {
    height = value;
  }

  @action
  void setMale(String value) {
    if (value.toLowerCase() == 'male') {
      isMale = true;
    } else {
      isMale = false;
    }
  }

  final FormErrorState error = FormErrorState();

  @action
  void validateUsername(String value) {
    if (isNull(value) || value.isEmpty) {
      error.name = 'Username cannot be blank';
      return;
    }

    error.name = null;
  }

  @action
  void validateAge(String value) {
    if (isNull(value) || value.isEmpty) {
      error.age = 'Cannot be blank';
      return;
    }

    error.age = null;
  }

  @action
  void validateHeight(String value) {
    if (isNull(value) || value.isEmpty) {
      error.height = 'Cannot be blank';
      return;
    }

    error.height = null;
  }

  void dispose() {
    for (final d in _disposers) {
      d();
    }
  }
}

class FormErrorState = _FormErrorState with _$FormErrorState;

abstract class _FormErrorState with Store {
  @observable
  String? name;

  @observable
  String? age;

  @observable
  String? height;

  @observable
  bool? gender;

  @computed
  bool get hasErrors =>
      name != null || age != null || height != null; // || gender != null;
}
