import 'package:flutter/material.dart';
import 'package:flutter_practice_library/bloc/SqfliteBloc.dart';
import 'package:flutter_practice_library/core/DatabaseHelper.dart';
import 'package:provider/provider.dart';

class SqfliteScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider<SqfliteBloc>(
      create: (context) => SqfliteBloc(),
      dispose: (context, bloc) => bloc.dispose(),
      child: _Screen(),
    );
  }
}

class _Screen extends StatelessWidget {

  final dbHelper = DatabaseHelper.instance;

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

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Practice - sqflite"),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Text('Practice - sqflite"'),
            RaisedButton(
              child: Text(
                'insert',
                style: TextStyle(fontSize: 20),
              ),
              onPressed: _insert,
            ),
            RaisedButton(
              child: Text(
                'query',
                style: TextStyle(fontSize: 20),
              ),
              onPressed: _query,
            ),
            RaisedButton(
              child: Text(
                'update',
                style: TextStyle(fontSize: 20)
              ),
              onPressed: _update,
            ),
            RaisedButton(
              child: Text(
                'delete',
                style: TextStyle(fontSize: 20)
              ),
              onPressed: _delete,
            ),
          ],
        )
      ),
    );
  }
}
