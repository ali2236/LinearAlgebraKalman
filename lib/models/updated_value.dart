import 'package:flutter/material.dart';

class UpdatedValue<T> extends ValueNotifier<T> {
  UpdatedValue(value) : super(value);

  @override
  set value(T newValue) {
    if(value==newValue){
      notifyListeners();
    }
    super.value = newValue;
  }
}