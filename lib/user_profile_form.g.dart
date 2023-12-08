// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_profile_form.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$FormStore on _FormStore, Store {
  late final _$nameAtom = Atom(name: '_FormStore.name', context: context);

  @override
  String get name {
    _$nameAtom.reportRead();
    return super.name;
  }

  @override
  set name(String value) {
    _$nameAtom.reportWrite(value, super.name, () {
      super.name = value;
    });
  }

  late final _$ageAtom = Atom(name: '_FormStore.age', context: context);

  @override
  String get age {
    _$ageAtom.reportRead();
    return super.age;
  }

  @override
  set age(String value) {
    _$ageAtom.reportWrite(value, super.age, () {
      super.age = value;
    });
  }

  late final _$heightAtom = Atom(name: '_FormStore.height', context: context);

  @override
  String get height {
    _$heightAtom.reportRead();
    return super.height;
  }

  @override
  set height(String value) {
    _$heightAtom.reportWrite(value, super.height, () {
      super.height = value;
    });
  }

  late final _$isMaleAtom = Atom(name: '_FormStore.isMale', context: context);

  @override
  bool? get isMale {
    _$isMaleAtom.reportRead();
    return super.isMale;
  }

  @override
  set isMale(bool? value) {
    _$isMaleAtom.reportWrite(value, super.isMale, () {
      super.isMale = value;
    });
  }

  late final _$_FormStoreActionController =
      ActionController(name: '_FormStore', context: context);

  @override
  void setUsername(String value) {
    final _$actionInfo = _$_FormStoreActionController.startAction(
        name: '_FormStore.setUsername');
    try {
      return super.setUsername(value);
    } finally {
      _$_FormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setAge(String value) {
    final _$actionInfo =
        _$_FormStoreActionController.startAction(name: '_FormStore.setAge');
    try {
      return super.setAge(value);
    } finally {
      _$_FormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setHeight(String value) {
    final _$actionInfo =
        _$_FormStoreActionController.startAction(name: '_FormStore.setHeight');
    try {
      return super.setHeight(value);
    } finally {
      _$_FormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setMale(String value) {
    final _$actionInfo =
        _$_FormStoreActionController.startAction(name: '_FormStore.setMale');
    try {
      return super.setMale(value);
    } finally {
      _$_FormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void validateUsername(String value) {
    final _$actionInfo = _$_FormStoreActionController.startAction(
        name: '_FormStore.validateUsername');
    try {
      return super.validateUsername(value);
    } finally {
      _$_FormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void validateAge(String value) {
    final _$actionInfo = _$_FormStoreActionController.startAction(
        name: '_FormStore.validateAge');
    try {
      return super.validateAge(value);
    } finally {
      _$_FormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void validateHeight(String value) {
    final _$actionInfo = _$_FormStoreActionController.startAction(
        name: '_FormStore.validateHeight');
    try {
      return super.validateHeight(value);
    } finally {
      _$_FormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
name: ${name},
age: ${age},
height: ${height},
isMale: ${isMale}
    ''';
  }
}

mixin _$FormErrorState on _FormErrorState, Store {
  Computed<bool>? _$hasErrorsComputed;

  @override
  bool get hasErrors =>
      (_$hasErrorsComputed ??= Computed<bool>(() => super.hasErrors,
              name: '_FormErrorState.hasErrors'))
          .value;

  late final _$nameAtom = Atom(name: '_FormErrorState.name', context: context);

  @override
  String? get name {
    _$nameAtom.reportRead();
    return super.name;
  }

  @override
  set name(String? value) {
    _$nameAtom.reportWrite(value, super.name, () {
      super.name = value;
    });
  }

  late final _$ageAtom = Atom(name: '_FormErrorState.age', context: context);

  @override
  String? get age {
    _$ageAtom.reportRead();
    return super.age;
  }

  @override
  set age(String? value) {
    _$ageAtom.reportWrite(value, super.age, () {
      super.age = value;
    });
  }

  late final _$heightAtom =
      Atom(name: '_FormErrorState.height', context: context);

  @override
  String? get height {
    _$heightAtom.reportRead();
    return super.height;
  }

  @override
  set height(String? value) {
    _$heightAtom.reportWrite(value, super.height, () {
      super.height = value;
    });
  }

  late final _$genderAtom =
      Atom(name: '_FormErrorState.gender', context: context);

  @override
  bool? get gender {
    _$genderAtom.reportRead();
    return super.gender;
  }

  @override
  set gender(bool? value) {
    _$genderAtom.reportWrite(value, super.gender, () {
      super.gender = value;
    });
  }

  @override
  String toString() {
    return '''
name: ${name},
age: ${age},
height: ${height},
gender: ${gender},
hasErrors: ${hasErrors}
    ''';
  }
}
