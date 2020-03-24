import 'package:flutter/material.dart';
import 'package:flutter_practice_library/bloc/SharedPreferencesBloc.dart';
import 'package:flutter_practice_library/core/SharedPreferencesWrapper.dart';
import 'package:provider/provider.dart';

class SharedPreferencesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider<SharedPreferencesBloc>(
      create: (context) => SharedPreferencesBloc(),
      dispose: (context, bloc) => bloc.dispose(),
      child: _Screen(),
    );
  }
}

class _Screen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of<SharedPreferencesBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Practice - shared_preferences"),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(8.0),
              child: TextField(
                decoration: InputDecoration(labelText: 'input KEY'),
                onChanged: (String value) async {
                  bloc.inputKey.add(value);
                },
              ),
            ),
            Container(
              padding: EdgeInsets.all(8.0),
              child: TextField(
                decoration: InputDecoration(labelText: 'input VALUE'),
                onChanged: (String value) async {
                  bloc.inputValue.add(value);
                },
              ),
            ),
            Container(
              padding: EdgeInsets.all(8.0),
              child: RaisedButton(
                child: Text('SAVE'),
                onPressed: () => bloc.requestSave.add(null),
              ),
            ),
            Container(
              padding: EdgeInsets.all(8.0),
              child: RaisedButton(
                child: Text('PRINT'),
                onPressed: () => bloc.requestPrint.add(null),
              ),
            ),
            StreamBuilder(
              initialData: '',
              stream: bloc.listenSelectedValue,
              builder: (context, snapshot) {
                return Container(
                  padding: EdgeInsets.all(8.0),
                  child: Text(snapshot.data),
                );
              },
            )
          ],
        )
      ),
    );
  }
}