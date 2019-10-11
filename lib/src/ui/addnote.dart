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
  @override
  final _bloc = TodoBloc();
  String noteText;
  String noteDate = '';
  String category = '';
  String noteHour = '';
  String dropdownValue = 'önemli';
  DateTime _date = new DateTime.now();
  TimeOfDay _time = new TimeOfDay.now();

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: _date,
        firstDate: new DateTime(2016),
        lastDate: new DateTime(2022));

    if (picked != null && picked != _date) {
      print('Date selected: ${_date.toString()}');
      setState(() {
        _date = picked;
      });
    }
  }

  Future<Null> _selectTime(BuildContext context) async {
    final TimeOfDay picked = await showTimePicker(
      context: context,
      initialTime: _time,
    );
    if (picked != null && picked != _time) {
      print('Time selected: ${_time.toString()}');
      setState(() {
        _time = picked;
      });
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Yeni Not'), actions: <Widget>[
        IconButton(
            icon: const Icon(Icons.done),
            tooltip: 'Search',
            onPressed: () async {
              if (noteText.isNotEmpty) {
                Notes add = Notes(
                    noteText: noteText,
                    noteDate: noteDate,
                    noteHour: noteHour,
                    category: category,
                    blocked: false);
                await _bloc.newClient(add);
                await _bloc.getTodos();
                _bloc.dispatch(
                  AddTodoEvent(
                    todo: Notes(
                        noteText: noteText,
                        noteDate: noteDate,
                        noteHour: noteHour,
                        category: category),
                  ),
                );

                Navigator.pop(context);
              }
              else if (noteText.isEmpty) {
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
              else {
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
                      noteDate =
                          ' ${_date.day.toString()} : ${_date.month.toString()} : ${_date.year.toString()}';
                    },
                  ),
                  Text(
                      ' ${_date.day.toString()} : ${_date.month.toString()} : ${_date.year.toString()}'),
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
                      noteHour =
                          ' ${_time.hour.toString()} : ${_time.minute.toString()} ';
                    },
                  ),
                  Text(
                      ' ${_time.hour.toString()} : ${_time.minute.toString()} '),
                ]),
            SizedBox(
              height: 20,
            ),
            Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Kategori ',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 14,
                      fontFamily: 'Gilroy-ExtraBold',
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  DropdownButton<String>(
                    value: dropdownValue,
                    icon: Icon(Icons.arrow_drop_down),
                    iconSize: 24,
                    elevation: 16,
                    style: TextStyle(
                      color: Colors.blue[800],
                    ),
                    underline: Container(
                      height: 2,
                      color: Colors.blue[800],
                    ),
                    onChanged: (String newValue) {
                      setState(() {
                        dropdownValue = newValue;
                      });
                    },
                    items: <String>[
                      'önemli',
                      'önemsiz',
                    ].map<DropdownMenuItem<String>>((String value) {
                      category = value;
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ]),
          ],
        ),
      ),
    );
  }
}
