import 'dart:async';

class PracticeOneBloc {
  String _inputedType;

  final _inputedTypeController = StreamController<String>();
  Sink<String> get inputType => _inputedTypeController.sink;
  Stream<String> get getType => _inputedTypeController.stream;

  PracticeOneBloc() {
    _inputedTypeController.stream.listen((val) {
      _inputedType = val;
      _inputedTypeController.sink.add(_inputedType);
    });
  }

  void dispose() {
    _inputedTypeController.close();
  }
}