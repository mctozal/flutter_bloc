import 'package:flutter/material.dart';

class AboutMe extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Hakkında',
          style: TextStyle(
            fontFamily: 'Gilroy-ExtraBold',
            fontSize: 16,
          ),
        ),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Row(
          children: <Widget>[
            Column(
              children: <Widget>[
                Text('Developed by'),
                Text('Mücahit Tozal'),
              ],
            ),
            Column(children: <Widget>[
                Text('Developed by'),
                Text('Mücahit Tozal'),

            ],)
          ],
        ),
      ),
    );
  }
}
