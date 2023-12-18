import 'package:mobx/mobx.dart';
import 'package:open_weight_tracker/main.dart';
import 'package:open_weight_tracker/models.dart';
import 'package:validators2/validators2.dart';
part 'user_profile_form.g.dart';

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

  @observable
  ObservableFuture<bool> usernameCheck = ObservableFuture.value(true);

  @computed
  bool get isUserCheckPending => usernameCheck.status == FutureStatus.pending;

  @computed
  bool get canLogin => !error.hasErrors;

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
    if (canLogin) {
      User newUser = User(name, age, height, isMale, false);
      userRepository.saveUser(newUser);
      userRepository.setCurrentUser(newUser);
    } else {
      return;
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
  Future validateUsername(String value) async {
    if (isNull(value) || value.isEmpty) {
      error.name = 'Cannot be blank';
      return;
    }

    try {
      usernameCheck = ObservableFuture(checkValidUsername(value));
      error.name = null;
      final isValid = await usernameCheck;
      if (!isValid) {
        error.name = 'Username taken';
        return;
      }
    } on Object catch (_) {
      error.name = null;
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

  Future<bool> checkValidUsername(String value) async {
    await Future.delayed(const Duration(seconds: 1));

    return userRepository.isValidUserName(value);
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
