import 'package:flutter/material.dart';
import 'package:flutter_practice_library/bloc/DioBloc.dart';
import 'package:flutter_practice_library/model/jsonplaceholder/Post.dart';
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
  List<Widget> _buildPostCards(final List<Post> entries) {
    List<Widget> widgets = [];
    entries.forEach((dto) => widgets.add(
      Card(
        child: ListTile(
          leading: Text(dto.id.toString()),
          title: Text(dto.title),
          subtitle: Text(dto.body),
          trailing: Text(dto.userId.toString()),
        ),
      )
    ));
    return widgets;
  }

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
                  List<Widget> widgets = _buildPostCards(snapshot.data);
                  return Column(
                    children: widgets,
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