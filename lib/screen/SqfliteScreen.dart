import 'package:flutter/material.dart';
import 'package:flutter_practice_library/bloc/SqfliteBloc.dart';
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

  Widget build(BuildContext context) {
    final bloc = Provider.of<SqfliteBloc>(context);

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
              onPressed: () => bloc.requestInsert.add(null),
            ),
            RaisedButton(
              child: Text(
                'update',
                style: TextStyle(fontSize: 20)
              ),
              onPressed: () => bloc.requestUpdate.add(null),
            ),
            RaisedButton(
              child: Text(
                'delete',
                style: TextStyle(fontSize: 20)
              ),
              onPressed: () => bloc.requestDelete.add(null),
            ),
            StreamBuilder(
              initialData: [],
              stream: bloc.listenQuery,
              builder: (context, snapshot) {
                return Text(snapshot.data.toString());
              },
            )
          ],
        )
      ),
    );
  }
}
