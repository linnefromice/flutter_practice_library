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
        _requestPost();
      }
      break;

      case 'comments': {
        _requestComment();
      }
      break;

      case 'albums': {
        _requestAlbum();
      }
      break;

      case 'photos': {
        _requestPhoto();
      }
      break;

      case 'todos': {
        _requestTodo();
      }
      break;

      case 'users': {
        _requestUser();
      }
      break;
    }
  }

  void _requestPost() async {
    if (_inputIdController.text == '') {
      return;
    }
    Post dto = await JsonplaceholderService.findPostbyId(int.parse(_inputIdController.text));
    setState(() {
      _post = dto;
      _requestedDropdownValue = _dropdownValue;
    });
  }

  void _requestComment() async {
    if (_inputIdController.text == '') {
      return;
    }
    Comment dto = await JsonplaceholderService.findCommentbyId(int.parse(_inputIdController.text));
    setState(() {
      _comment = dto;
      _requestedDropdownValue = _dropdownValue;
    });
  }

  void _requestAlbum() async {
    if (_inputIdController.text == '') {
      return;
    }
    Album dto = await JsonplaceholderService.findAlbumbyId(int.parse(_inputIdController.text));
    setState(() {
      _album = dto;
      _requestedDropdownValue = _dropdownValue;
    });
  }

  void _requestPhoto() async {
    if (_inputIdController.text == '') {
      return;
    }
    Photo dto = await JsonplaceholderService.findPhotobyId(int.parse(_inputIdController.text));
    setState(() {
      _photo = dto;
      _requestedDropdownValue = _dropdownValue;
    });
  }

  void _requestTodo() async {
    if (_inputIdController.text == '') {
      return;
    }
    Todo dto = await JsonplaceholderService.findTodobyId(int.parse(_inputIdController.text));
    setState(() {
      _todo = dto;
      _requestedDropdownValue = _dropdownValue;
    });
  }

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
        if (_post == null) {
          widget = Text('NODATA');
        } else {
          widget = Column(
            children: <Widget>[
              Text('POSTS'),
              Text(_post.toRawJson())
            ],
          );
        }
      }
      break;

      case 'comments': {
        if (_comment == null) {
          widget = Text('NODATA');
        } else {
          widget = Column(
            children: <Widget>[
              Text('COMMENTS'),
              Text(_comment.toRawJson())
            ],
          );
        }
      }
      break;

      case 'albums': {
        if (_album == null) {
          widget = Text('NODATA');
        } else {
          widget = Column(
            children: <Widget>[
              Text('ALBUMS'),
              Text(_album.toRawJson())
            ],
          );
        }
      }
      break;

      case 'photos': {
        if (_photo == null) {
          widget = Text('NODATA');
        } else {
          widget = Column(
            children: <Widget>[
              Text('PHOTOS'),
              Text(_photo.toRawJson())
            ],
          );
        }
      }
      break;

      case 'todos': {
        if (_todo == null) {
          widget = Text('NODATA');
        } else {
          widget = Column(
            children: <Widget>[
              Text('TODOS'),
              Text(_todo.toRawJson())
            ],
          );
        }
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