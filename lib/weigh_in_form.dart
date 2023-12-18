import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:open_weight_tracker/main.dart';
part 'weigh_in_form.g.dart';

class WeightFormStore = _WeightFormStore with _$WeightFormStore;

abstract class _WeightFormStore with Store {
  final WeighInFormErrorState error = WeighInFormErrorState();

  @observable
  DateTime date = DateTime.now();

  @observable
  double weight = 0.0;

  @computed
  bool get canSubmit => !error.hasErrors;

  late List<ReactionDisposer> _disposers;

  void setupValidations() {
    _disposers = [
      reaction((_) => date, validateDate),
      reaction((_) => weight, validateWeight),
    ];
  }

  @action
  void validateDate(DateTime value) {
    if (value == DateTime.now()) {
      throw ErrorDescription('no date given');
    }
  }

  @action
  void validateWeight(double value) {
    if (value == 0.0) {
      throw ErrorDescription('Weight cant be 0');
    }
  }

  void dispose() {
    for (final d in _disposers) {
      d();
    }
  }

  void validateAll() {
    validateDate(date);
    validateWeight(weight);
    if (canSubmit) {
      userRepository.saveWeighIn(date, weight);
    } else {
      throw ErrorDescription('validation fail');
    }
  }
}

class WeighInFormErrorState = _WeighInFormErrorState
    with _$WeighInFormErrorState;

abstract class _WeighInFormErrorState with Store {
  @observable
  DateTime? selectedDate;

  @observable
  double? selectedWeight;

  @computed
  bool get hasErrors => selectedDate != null || selectedWeight != null;
}
