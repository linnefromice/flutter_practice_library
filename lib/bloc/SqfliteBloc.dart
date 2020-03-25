import 'dart:async';

import 'package:flutter_practice_library/core/DatabaseHelper.dart';

class SqfliteBloc {
  final dbHelper = DatabaseHelper.instance;

  final _insertController = StreamController<void>();
  Sink<void> get requestInsert => _insertController.sink;

  final _queryController = StreamController<List<Map<String, dynamic>>>();
  Stream<List<Map<String, dynamic>>> get listenQuery => _queryController.stream;

  final _updateController = StreamController<void>();
  Sink<void> get requestUpdate => _updateController.sink;

  final _deleteController = StreamController<void>();
  Sink<void> get requestDelete => _deleteController.sink;

  SqfliteBloc() {
    _insertController.stream.listen((_) {
      _insert();
      _query();
    });
    _updateController.stream.listen((_) {
      _update();
      _query();
    });
    _deleteController.stream.listen((_) {
      _delete();
      _query();
    });
  }

  void _insert() async {
    Map<String, dynamic> row = {
      DatabaseHelper.columnName: 'Mike',
      DatabaseHelper.columnAge: 23
    };
    final id = await dbHelper.insert(row);
    print('insert row id: $id');
  }
  void _query() async {
    final allRows = await dbHelper.queryAllRows();
    print('query all rows:');
    allRows.forEach((row) => print(row));
    _queryController.sink.add(allRows);
  }
  void _update() async {
    Map<String, dynamic> row = {
      DatabaseHelper.columnId: 1,
      DatabaseHelper.columnName: 'harvey',
      DatabaseHelper.columnAge: 30
    };
    final rowsAffected = await dbHelper.update(row);
    print('update $rowsAffected row(s)');
  }
  void _delete() async {
    final id = await dbHelper.queryRowCount();
    final rowsDeleted = await dbHelper.delete(id);
    print('deleted $rowsDeleted row(s): row $id');
  }

  void dispose() {
    _insertController.close();
    _queryController.close();
    _updateController.close();
    _deleteController.close();
  }
}