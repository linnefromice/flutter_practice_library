import 'package:flutter/material.dart';
import 'package:flutter_practice_library/bloc/DioBloc.dart';
import 'package:provider/provider.dart';

class DioScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider<DioBloc>(
      create: (context) => DioBloc(),
      dispose: (context, bloc) => bloc.dispose(),
      child: _Screen(),
    );
  }
}

class _Screen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of<DioBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Practice - dio')
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            RaisedButton(
              child: Text('REQUEST'),
              onPressed: () => bloc.requestApi.add(null),
            ),
            StreamBuilder(
              initialData: null,
              stream: bloc.responseApi,
              builder: (context, snapshot) {
                if (snapshot.data == null) {
                  return Text('NO DATA');
                } else {
                  return ListTile(
                    leading: Text(snapshot.data['id'].toString()),
                    title: Text(snapshot.data['title']),
                    subtitle: Text(snapshot.data['body']),
                    trailing: Text(snapshot.data['userId'].toString()),
                  );
                }
              },
            )
          ],
        )
      ),
    );
  }
}