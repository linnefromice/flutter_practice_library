import 'package:flutter/material.dart';
import 'package:flutter_practice_library/bloc/practice/PracticeBlocOne.dart';
import 'package:provider/provider.dart';

class PracticeBlocAndStatefulWidgetScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider<PracticeOneBloc>(
      create: (context) => PracticeOneBloc(),
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

  Widget _buildDropdownButton(BuildContext context, PracticeOneBloc bloc) {
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
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of<PracticeOneBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('PracticeBlocAndStatefulWidgetScreen'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Text('PracticeBlocAndStatefulWidgetScreen'),
            _buildDropdownButton(context, bloc),
          ],
        ),
      ),
    );
  }
}
