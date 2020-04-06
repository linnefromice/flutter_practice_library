import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_practice_library/bloc/DioBloc.dart';
import 'package:flutter_practice_library/model/jsonplaceholder/Album.dart';
import 'package:flutter_practice_library/model/jsonplaceholder/Comment.dart';
import 'package:flutter_practice_library/model/jsonplaceholder/Photo.dart';
import 'package:flutter_practice_library/model/jsonplaceholder/Post.dart';
import 'package:flutter_practice_library/model/jsonplaceholder/Todo.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

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
  final Map<String, String> _dropdownValueMap = {
    'posts':'投稿',
    'comments':'コメント',
    'albums':'アルバム',
    'photos':'写真',
    'todos':'TODO',
    'users':'ユーザ'
  };
  String _dropdownValue = 'posts';

  void _launchUrl(final String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    }
  }

  Widget _buildRequestButton(final DioBloc bloc) {
    return RaisedButton(
      child: Text('REQUEST'),
      onPressed: () => bloc.requestApi.add(_dropdownValue),
    );
  }

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
        items: _dropdownValueMap.keys.toList()
            .map<DropdownMenuItem<String>>((String key) {
        return DropdownMenuItem<String>(
          value: key,
          child: Text(_dropdownValueMap[key]),
        );
      }).toList()
    );
  }

  Widget _buildIdField(final DioBloc bloc) {
    return TextField(
      decoration: InputDecoration(labelText: 'input ID'),
      keyboardType: TextInputType.number,
      inputFormatters: <TextInputFormatter>[
        WhitelistingTextInputFormatter.digitsOnly
      ],
      onChanged: (String value) async {
        bloc.inputId.add(value);
      },
    );
  }

  List<Widget> _buildPostCards(final List<Post> entries) {
    List<Widget> widgets = [];
    widgets.add(
      Text(
        'Post',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontStyle: FontStyle.italic,
        ),
      )
    );
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

  List<Widget> _buildCommentCards(final List<Comment> entries) {
    List<Widget> widgets = [];
    widgets.add(
      Text(
        'Comment',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontStyle: FontStyle.italic,
        ),
      )
    );
    entries.forEach((dto) => widgets.add(
      Card(
        child: ListTile(
          leading: Text(dto.id.toString()),
          title: Text(dto.name),
          subtitle: Column(
            children: <Widget>[
              Text(dto.body),
              Text(dto.email)
            ],
          ),
          trailing: Text(dto.postId.toString()),
        ),
      )
    ));
    return widgets;
  }

  List<Widget> _buildAlbumCards(final List<Album> entries) {
    List<Widget> widgets = [];
    widgets.add(
      Text(
        'Album',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontStyle: FontStyle.italic,
        ),
      )
    );
    entries.forEach((dto) => widgets.add(
      Card(
        child: ListTile(
          leading: Text(dto.id.toString()),
          title: Text(dto.title),
          trailing: Text(dto.userId.toString()),
        ),
      )
    ));
    return widgets;
  }

  List<Widget> _buildPhotoCards(final List<Photo> entries) {
    List<Widget> widgets = [];
    widgets.add(
      Text(
        'Photo',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontStyle: FontStyle.italic,
        ),
      )
    );
    entries.forEach((dto) => widgets.add(
      Card(
        child: ListTile(
          leading: Text(dto.id.toString()),
          title: Text(dto.title),
          trailing: RaisedButton.icon(
            onPressed: () => _launchUrl(dto.url),
            icon: Icon(Icons.link),
            label: Text('Link'),
          ),
        ),
      )
    ));
    return widgets;
  }

  List<Widget> _buildTodoCards(final List<Todo> entries) {
    List<Widget> widgets = [];
    widgets.add(
      Text(
        'Todo',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontStyle: FontStyle.italic,
        ),
      )
    );
    entries.forEach((dto) => widgets.add(
      Card(
        child: ListTile(
          leading: Text(dto.id.toString()),
          title: Text(dto.title),
          subtitle: dto.completed ? Icon(Icons.done) : Icon(Icons.work),
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
                child: _buildRequestButton(bloc),
              ),
              Container(
                padding: EdgeInsets.all(2.0),
                child: _buildDropButton(bloc),
              ),
              Container(
                padding: EdgeInsets.all(2.0),
                child: _buildIdField(bloc),
              ),
              Container(
                padding: EdgeInsets.all(2.0),
                child: StreamBuilder(
                  initialData: null,
                  stream: bloc.responseApi,
                  builder: (context, snapshot) {
                    if (snapshot.data == null) {
                      return Text('NO DATA');
                    } else {
                      List<Widget> widgets = [];
                      List<dynamic> dtos = snapshot.data;
                      if (dtos[0] is Post) {
                        widgets = _buildPostCards(dtos);
                      } else if (dtos[0] is Comment) {
                        widgets = _buildCommentCards(dtos);
                      } else if (dtos[0] is Album) {
                        widgets = _buildAlbumCards(dtos);
                      } else if (dtos[0] is Photo) {
                        widgets = _buildPhotoCards(dtos);
                      } else if (dtos[0] is Todo) {
                        widgets = _buildTodoCards(dtos);
                      } else {
                        dtos.forEach((v) {
                          widgets.add(Text(v.toString()));
                        });
                      }
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
