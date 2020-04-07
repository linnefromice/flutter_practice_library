import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_practice_library/bloc/DioBloc.dart';
import 'package:flutter_practice_library/model/jsonplaceholder/Album.dart';
import 'package:flutter_practice_library/model/jsonplaceholder/Comment.dart';
import 'package:flutter_practice_library/model/jsonplaceholder/Photo.dart';
import 'package:flutter_practice_library/model/jsonplaceholder/Post.dart';
import 'package:flutter_practice_library/model/jsonplaceholder/Todo.dart';
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
  String _requestedDropdownValue;
  Post _post;
  Comment _comment;
  Album _album;
  Photo _photo;
  Todo _todo;
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

  void _request(final String selectedDropdownValue) async {
    if (_inputIdController.text == '') {
      return;
    }
    switch(selectedDropdownValue) {
      case 'posts': {
        setState(() {
          _requestedDropdownValue = _dropdownValue;
        });
      }
      break;

      case 'comments': {
        setState(() {
          _requestedDropdownValue = _dropdownValue;
        });
      }
      break;

      case 'albums': {
        setState(() {
          _requestedDropdownValue = _dropdownValue;
        });
      }
      break;

      case 'photos': {
        setState(() {
          _requestedDropdownValue = _dropdownValue;
        });
      }
      break;

      case 'todos': {
        setState(() {
          _requestedDropdownValue = _dropdownValue;
        });
      }
      break;

      case 'users': {
        _requestUser();
      }
      break;
    }
  }

  void _requestPost() async {}
  void _requestComment() async {}
  void _requestAlbum() async {}
  void _requestPhoto() async {}
  void _requestTodo() async {}

  void _requestUser() async {
    if (_inputIdController.text == '') {
      return;
    }
    User dto = await JsonplaceholderService.findUserbyId(int.parse(_inputIdController.text));
    setState(() {
      _user = dto;
      _requestedDropdownValue = _dropdownValue;
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

  Widget _buildDisplayResponseWidget(final User dto) {
    if (dto == null) {
      return Text('NO DATA');
    }
    return Column(
      children: <Widget>[
        ListTile(
          leading: Icon(Icons.person),
          title: Text(dto.name),
        ),
        ListTile(
          leading: Icon(Icons.email),
          title: Text(dto.email),
        ),
        ListTile(
          leading: Icon(Icons.home),
          title: Text('${dto.address.city} / ${dto.address.suite} / ${dto.address.street}'),
          subtitle: Text('${dto.address.zipcode}'),
        ),
        ListTile(
          leading: Icon(Icons.phone),
          title: Text(dto.phone),
        ),
        ListTile(
          leading: Icon(Icons.web),
          title: Text(dto.website),
        ),
        ListTile(
          leading: Icon(Icons.work),
          title: Text(dto.company.name),
          subtitle: Text(dto.company.bs),
        ),
      ],
    );
  }

  Widget _buildResponseDataWidget(final String requestedValue) {
    Widget widget;
    switch(requestedValue) {
      case 'posts': {
        widget = Column(
          children: <Widget>[
            Text('POSTS'),
          ],
        );
      }
      break;

      case 'comments': {
        widget = Column(
          children: <Widget>[
            Text('COMMENTS'),
          ],
        );
      }
      break;

      case 'albums': {
        widget = Column(
          children: <Widget>[
            Text('ALBUMS'),
          ],
        );
      }
      break;

      case 'photos': {
        widget = Column(
          children: <Widget>[
            Text('PHOTOS'),
          ],
        );
      }
      break;

      case 'todos': {
        widget = Column(
          children: <Widget>[
            Text('TODOS'),
          ],
        );
      }
      break;

      case 'users': {
        widget = _buildDisplayResponseWidget(_user);
      }
      break;

      default: {
        widget = Text('NODATA');
      }
      break;
    }
    return widget;
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
              Container(
                padding: EdgeInsets.all(2.0),
                child: _buildRequestButton(),
              ),
              Container(
                padding: EdgeInsets.all(2.0),
                child: _buildResponseDataWidget(_requestedDropdownValue),
              )
            ],
          ),
        ),
      ),
    );
  }
}