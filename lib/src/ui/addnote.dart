import "package:flutter/material.dart";
import 'package:flutter_bloc/src/bloc/todo_bloc.dart';
import 'package:flutter_bloc/src/bloc/todo_event.dart';
import 'package:flutter_bloc/src/model/noteModel.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:async';

class SaveNote extends StatefulWidget {
  @override
  _SaveNoteState createState() => _SaveNoteState();
}

class _SaveNoteState extends State<SaveNote> {
  final _bloc = TodoBloc();
  TextEditingController _textController = TextEditingController();

  String noteText = '';
  String noteDate = '';
  String category = '';
  String noteHour = DateTime.now().toString();
  DateTime picked;
  TimeOfDay pickedHour;
  String dropdownValue = '';
  DateTime _date = new DateTime.now();
  TimeOfDay _time = new TimeOfDay.now();

  Future<Null> _selectDate(BuildContext context) async {
    picked = await showDatePicker(
        context: context,
        initialDate: _date,
        firstDate: new DateTime(2016),
        lastDate: new DateTime(2022));

    if (picked != null && picked != _date) {
      print('Date selected: ${_date.toString()}');
      setState(() {
        _date = picked;
        noteDate = picked.toString();
      });
    }
  }

  Future<Null> _selectTime(BuildContext context) async {
    pickedHour = await showTimePicker(
      context: context,
      initialTime: _time,
    );
    if (pickedHour != null && pickedHour != _time) {
      print('Time selected: ${_time.toString()}');
      setState(() {
        _time = pickedHour;
        noteHour = pickedHour.toString();
      });
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Yeni Not'), actions: <Widget>[
        IconButton(
            icon: const Icon(Icons.done),
            tooltip: 'Tamam',
            onPressed: () async {
              if (_textController.text.isNotEmpty) {
                Notes add = Notes(
                    noteText: _textController.text,
                    noteDate: noteDate,
                    noteHour: noteHour,
                    category: dropdownValue,
                    blocked: false);
                await _bloc.newClient(add);
                await _bloc.getTodos();
                _bloc.dispatch(
                  AddTodoEvent(
                    todo: Notes(
                        noteText: _textController.text,
                        noteDate: noteDate,
                        noteHour: noteHour,
                        category: dropdownValue),
                  ),
                );

                Navigator.pop(context);
              } else if (_textController.text.isEmpty) {
                Fluttertoast.showToast(
                  msg: 'Lütfen not girin',
                  textColor: Colors.indigo[900],
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIos: 1,
                  backgroundColor: Colors.lightBlue[900],
                  fontSize: 14.0,
                );
              } else {
                Fluttertoast.showToast(
                  msg: 'Lütfen not girin',
                  textColor: Colors.indigo[900],
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIos: 1,
                  backgroundColor: Colors.lightBlue[900],
                  fontSize: 14.0,
                );
              }
              setState(() {});
            }),
      ]),
      body: Padding(
        padding: EdgeInsets.fromLTRB(30.0, 30.0, 30.0, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Yeni Not',
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: 14,
                fontFamily: 'Gilroy-ExtraBold',
              ),
            ),
            TextField(
              controller: _textController,
              onChanged: (text) {
                noteText = text;
              },
            ),
            SizedBox(
              height: 20,
            ),
            Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Tarih ',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 14,
                      fontFamily: 'Gilroy-ExtraBold',
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.date_range),
                    tooltip: 'Tarihi seçin.',
                    onPressed: () async {
                      await _selectDate(context);
                    },
                  ),
                  buildDate(),
                ]),
            SizedBox(
              height: 20,
            ),
            Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Saat',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 14,
                      fontFamily: 'Gilroy-ExtraBold',
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.access_time),
                    tooltip: 'Saati seçin.',
                    onPressed: () async {
                      await _selectTime(context);
                    },
                  ),
                  buildHour(),
                ]),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }

  Text buildDate() {
    noteDate =
        ' ${_date.day.toString()} : ${_date.month.toString()} : ${_date.year.toString()}';
    return Text(
        ' ${_date.day.toString()} : ${_date.month.toString()} : ${_date.year.toString()}');
  }

  Text buildHour() {
    noteHour = '${_time.hour.toString()} : ${_time.minute.toString()}';
    return Text('${_time.hour.toString()} : ${_time.minute.toString()}');
  }
}
