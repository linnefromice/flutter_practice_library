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

  final _printController = StreamController<void>();
  Sink<void> get getPrint => _printController.sink;

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
    _printController.stream.listen((_) {
      _printValue();
    });
  }

  void _printValue() async {
    print('KEY: $_key');
    final printedValue = await SharedPreferencesWrapper.getValue(_key);
    print('VALUE: $printedValue');
  }

  void dispose() {
    _inputKeyController.close();
    _inputValueController.close();
    _saveController.close();
    _printController.close();
  }
}