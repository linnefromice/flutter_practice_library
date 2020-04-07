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
  String _dropdownValue;
  User _user;
  final _inputIdController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _dropdownValue = 'posts';
  }

  @override
  void dispose() {
    _inputIdController.dispose();
    super.dispose();
  }

  void _requestUser() async {
    if (_inputIdController.text == '') {
      return;
    }
    User dto = await JsonplaceholderService.findUserbyId(int.parse(_inputIdController.text));
    setState(() {
      _user = dto;
    });
  }

  Widget _buildIdField() {
    return TextField(
      controller: _inputIdController,
      decoration: InputDecoration(labelText: 'input ID'),
      keyboardType: TextInputType.number,
      inputFormatters: <TextInputFormatter>[
        WhitelistingTextInputFormatter.digitsOnly
      ],
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
      onPressed: _requestUser
    );
  }

  Widget _buildDisplayResponseWidget() {
    if (_user == null) {
      return Text('NO DATA');
    }
    return Column(
      children: <Widget>[
        ListTile(
          leading: Icon(Icons.person),
          title: Text(_user.name),
        ),
        ListTile(
          leading: Icon(Icons.email),
          title: Text(_user.email),
        ),
        ListTile(
          leading: Icon(Icons.home),
          title: Text('${_user.address.city} / ${_user.address.suite} / ${_user.address.street}'),
          subtitle: Text('${_user.address.zipcode}'),
        ),
        ListTile(
          leading: Icon(Icons.phone),
          title: Text(_user.phone),
        ),
        ListTile(
          leading: Icon(Icons.web),
          title: Text(_user.website),
        ),
        ListTile(
          leading: Icon(Icons.work),
          title: Text(_user.company.name),
          subtitle: Text(_user.company.bs),
        ),
      ],
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
                child: _buildRequestButton(),
              ),
              Container(
                padding: EdgeInsets.all(2.0),
                child: _buildDisplayResponseWidget(),
              )
            ],
          ),
        ),
      ),
    );
  }
}