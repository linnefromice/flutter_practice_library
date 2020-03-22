import 'dart:async';

import 'package:flutter_practice_library/core/SharedPreferencesWrapper.dart';

class SharedPreferencesBloc {
  String _key;
  String _value;

  final _inputKeyController = StreamController<String>();
  Sink<String> get inputKey => _inputKeyController.sink;

  final _inputValueController = StreamController<String>();
  Sink<String> get inputValue => _inputValueController.sink;

  final _saveController = StreamController<void>();
  Sink<void> get requestSave => _saveController.sink;

  SharedPreferencesBloc() {
    _inputKeyController.stream.listen((val) {
      _key = val;
    });
    _inputValueController.stream.listen((val) {
      _value = val;
    });
    _saveController.stream.listen((_) {
      SharedPreferencesWrapper.setString(_key, _value);
    });
  }

  void dispose() {
    _inputKeyController.close();
    _inputValueController.close();
    _saveController.close();
  }
}