import 'dart:async';

class SqfliteBloc {

  final _insertController = StreamController<void>();
  Sink<void> get requestInsert => _insertController.sink;

  final _queryController = StreamController<void>();
  Sink<void> get requestQuery => _queryController.sink;

  final _updateController = StreamController<void>();
  Sink<void> get requestUpdate => _updateController.sink;

  final _deleteController = StreamController<void>();
  Sink<void> get requestDelete => _deleteController.sink;

  SqfliteBloc() {
    // TODO
  }

  void dispose() {
    _insertController.close();
    _queryController.close();
    _updateController.close();
    _deleteController.close();
  }
}