import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

class _Screen extends StatefulWidget {
  @override
  State createState() => _State();
}

class _State extends State<_Screen> {
  String _dropdownValue = 'posts';

  Widget _buildDropButton(final DioBloc bloc) {
    return DropdownButton<String>(
        value: _dropdownValue,
        icon: Icon(Icons.arrow_downward),
        iconSize: 24,
        elevation: 16,
        onChanged: (String newValue) async {
          setState(() {
            _dropdownValue = newValue;
          });
        },
        items: <String>['posts', 'comments', 'albums', 'photos', 'todos', 'users']
            .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList()
    );
  }

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
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(2.0),
                child: RaisedButton(
                  child: Text('REQUEST'),
                  onPressed: () => bloc.requestApi.add(null),
                ),
              ),
              _buildDropButton(bloc),
              Container(
                padding: EdgeInsets.all(2.0),
                child: TextField(
                  decoration: InputDecoration(labelText: 'input ID'),
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    WhitelistingTextInputFormatter.digitsOnly
                  ],
                  onChanged: (String value) async {
                    bloc.inputId.add(value);
                  },
                ),
              ),
              Container(
                child: StreamBuilder(
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
                ),
              ),
            ],
          ),
        )
      ),
    );
  }
}
