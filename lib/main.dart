import 'package:flutter/material.dart';
import 'package:flutter_bloc/src/ui/homepage.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Yapılacaklar Listesi',
        theme: ThemeData(
          brightness: Brightness.light,
          primarySwatch: Colors.blue,
        ),
        debugShowCheckedModeBanner: false,
        home: Homepage());

  }
}
