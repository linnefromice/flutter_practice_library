import 'dart:async';

import 'package:dio/dio.dart';

class PracticeOneBloc {
  String _inputedType;

  final _inputedTypeController = StreamController<String>();
  Sink<String> get inputType => _inputedTypeController.sink;
  Stream<String> get getType => _inputedTypeController.stream;

  final _requestApiController = StreamController<String>();
  Sink<String> get requestApi => _requestApiController.sink;

  final _responseApiController = StreamController<String>();
  Stream<String> get responseApi => _responseApiController.stream;

  PracticeOneBloc() {
    _inputedTypeController.stream.listen((val) {
      _inputedType = val;
      _inputedTypeController.sink.add(_inputedType);
    });
    _requestApiController.stream.listen((val) {
      _request(val);
    });
  }

  void _request(final String value) async {
    final Response response = await Dio().get('https://jsonplaceholder.typicode.com/' + value + '/1');
    _responseApiController.sink.add(response.data.toString());
  }

  void dispose() {
    _inputedTypeController.close();
    _requestApiController.close();
    _responseApiController.close();
  }
}