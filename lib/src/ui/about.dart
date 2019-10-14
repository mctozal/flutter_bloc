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
        body: ListView(
          children: const <Widget>[
            SizedBox(
              height: 10,
            ),
            Card(
              child: ListTile(
                leading: Icon(Icons.verified_user),
                title: Text('Yazılım:  Mücahit Tozal'),
              ),
            ),
            Card(
              child: ListTile(
                leading: Icon(Icons.developer_mode),
                title: Text('sürüm:  1.0'),
              ),
            ),
            Card(
              child: ListTile(
                title: Text('İletişim'),
                dense: true,
              ),
            ),
            Card(
              child: ListTile(
                leading: Icon(Icons.web),
                title: Text('www.mtozal.com'),
              ),
            ),
            SizedBox(
              height: 100,
            ),
            Card(
              child: ListTile(
                leading: FlutterLogo(size: 110.0),
                title: Text('Daha Fazla Uygulama'),
                trailing: Icon(Icons.more_vert),
              ),
            ),
          ],
        ));
  }
}
