import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_practice_library/bloc/DioBloc.dart';
import 'package:flutter_practice_library/model/jsonplaceholder/User.dart';
import 'package:flutter_practice_library/service/JsonplaceholderService.dart';
import 'package:provider/provider.dart';

class PracticeDioAndFutureScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider<DioBloc>(
      create: (context) => DioBloc(), // not use (dummy setting)
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
  final Map<String, String> _dropdownValueMap = {
    'posts':'投稿',
    'comments':'コメント',
    'albums':'アルバム',
    'photos':'写真',
    'todos':'TODO',
    'users':'ユーザ'
  };
  String _dropdownValue = 'posts';
  String _inputId = '';

  Widget _buildIdField() {
    return TextField(
      decoration: InputDecoration(labelText: 'input ID'),
      keyboardType: TextInputType.number,
      inputFormatters: <TextInputFormatter>[
        WhitelistingTextInputFormatter.digitsOnly
      ],
      onChanged: (String value) async {
        setState(() {
          _inputId = value;
        });
      },
    );
  }

  Widget _buildDropButton() {
    return DropdownButton<String>(
        value: _dropdownValue,
        icon: Icon(Icons.arrow_downward),
        iconSize: 24,
        elevation: 16,
        onChanged: (String value) async {
          setState(() {
            _dropdownValue = value;
          });
        },
        items: _dropdownValueMap.keys.toList()
            .map<DropdownMenuItem<String>>((String key) {
          return DropdownMenuItem<String>(
            value: key,
            child: Text(_dropdownValueMap[key]),
          );
        }).toList()
    );
  }

  Widget _buildRequestButton() {
    return RaisedButton(
      child: Text('REQUEST'),
      onPressed: () async {
        List<User> dtos = await JsonplaceholderService.findUsers();
        print(dtos);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Practice - dio and FutureBuilder'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(2.0),
                child: _buildIdField(),
              ),
              Container(
                padding: EdgeInsets.all(2.0),
                child: _buildDropButton(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}