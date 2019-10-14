import 'package:flutter/material.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool _onChange = false;

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Ayarlar',
          style: TextStyle(
            fontFamily: 'Gilroy-ExtraBold',
            fontSize: 16,
          ),
        ),
        backgroundColor: Colors.blue,
      ),
      body: ListView(children: <Widget>[
        Card(
          child: ListTile(
            leading: Icon(Icons.change_history),
            title: Text('Dark mode'),
            trailing: Switch(
              value: _onChange,
              onChanged: (bool newValue) {
                onChanged(newValue);
              },
            ),
          ),
        ),
      ]),
    );
  }

  void onChanged(bool newValue) {}
}
