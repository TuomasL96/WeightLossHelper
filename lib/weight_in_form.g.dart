// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weigh_in_form.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$WeightFormStore on _WeightFormStore, Store {
  Computed<bool>? _$canSubmitComputed;

  @override
  bool get canSubmit =>
      (_$canSubmitComputed ??= Computed<bool>(() => super.canSubmit,
              name: '_WeightFormStore.canSubmit'))
          .value;

  late final _$dateAtom = Atom(name: '_WeightFormStore.date', context: context);

  @override
  DateTime get date {
    _$dateAtom.reportRead();
    return super.date;
  }

  @override
  set date(DateTime value) {
    _$dateAtom.reportWrite(value, super.date, () {
      super.date = value;
    });
  }

  late final _$weightAtom =
      Atom(name: '_WeightFormStore.weight', context: context);

  @override
  double get weight {
    _$weightAtom.reportRead();
    return super.weight;
  }

  @override
  set weight(double value) {
    _$weightAtom.reportWrite(value, super.weight, () {
      super.weight = value;
    });
  }

  late final _$_WeightFormStoreActionController =
      ActionController(name: '_WeightFormStore', context: context);

  @override
  void validateDate(DateTime value) {
    final _$actionInfo = _$_WeightFormStoreActionController.startAction(
        name: '_WeightFormStore.validateDate');
    try {
      return super.validateDate(value);
    } finally {
      _$_WeightFormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void validateWeight(double value) {
    final _$actionInfo = _$_WeightFormStoreActionController.startAction(
        name: '_WeightFormStore.validateWeight');
    try {
      return super.validateWeight(value);
    } finally {
      _$_WeightFormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
date: ${date},
weight: ${weight},
canSubmit: ${canSubmit}
    ''';
  }
}

mixin _$WeightInFormErrorState on _WeightInFormErrorState, Store {
  Computed<bool>? _$hasErrorsComputed;

  @override
  bool get hasErrors =>
      (_$hasErrorsComputed ??= Computed<bool>(() => super.hasErrors,
              name: '_WeightInFormErrorState.hasErrors'))
          .value;

  late final _$selectedDateAtom =
      Atom(name: '_WeightInFormErrorState.selectedDate', context: context);

  @override
  DateTime? get selectedDate {
    _$selectedDateAtom.reportRead();
    return super.selectedDate;
  }

  @override
  set selectedDate(DateTime? value) {
    _$selectedDateAtom.reportWrite(value, super.selectedDate, () {
      super.selectedDate = value;
    });
  }

  late final _$selectedWeightAtom =
      Atom(name: '_WeightInFormErrorState.selectedWeight', context: context);

  @override
  double? get selectedWeight {
    _$selectedWeightAtom.reportRead();
    return super.selectedWeight;
  }

  @override
  set selectedWeight(double? value) {
    _$selectedWeightAtom.reportWrite(value, super.selectedWeight, () {
      super.selectedWeight = value;
    });
  }

  @override
  String toString() {
    return '''
selectedDate: ${selectedDate},
selectedWeight: ${selectedWeight},
hasErrors: ${hasErrors}
    ''';
  }
}
