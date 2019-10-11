import 'package:flutter/material.dart';
import 'package:flutter_bloc/src/bloc/todo_bloc.dart';
import 'package:flutter_bloc/src/bloc/todo_database.dart';
import 'package:flutter_bloc/src/bloc/todo_event.dart';
import 'package:flutter_bloc/src/model/constants.dart';
import 'package:flutter_bloc/src/model/noteModel.dart';

import 'addnote.dart';

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final _bloc = TodoBloc();
  final _database = TodoDao();
  Icon iconSearch = Icon(Icons.search);

  Widget cusSearchBar = Text(
    "Yapılacaklar listesi",
    style: TextStyle(
      fontFamily: 'Gilroy-ExtraBold',
      fontSize: 16,
    ),
  );

  choiceAction(String choice) {
    return choice;
  }

  _searchBar(String searchText) {}

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // get all notes first by getTodos
    _bloc.getTodos();
    return Scaffold(
      appBar: AppBar(
        title: cusSearchBar,
        actions: <Widget>[
          new IconButton(
              icon: iconSearch,
              tooltip: 'Search',
              onPressed: () {
                setState(() {
                  if (this.iconSearch.icon == Icons.search) {
                    this.iconSearch = Icon(Icons.cancel);
                    this.cusSearchBar = TextField(
                      textInputAction: TextInputAction.go,
                      decoration: InputDecoration(
                          border: InputBorder.none, hintText: "Arama Yapın"),
                      style: TextStyle(
                          fontFamily: 'Gilroy-ExtraBold',
                          fontSize: 16,
                          color: Colors.white),
                    );
                  } else {
                    this.iconSearch = Icon(Icons.search);

                    this.cusSearchBar = Text(
                      "Yapılacaklar listesi",
                      style: TextStyle(
                        fontFamily: 'Gilroy-ExtraBold',
                        fontSize: 16,
                      ),
                    );
                  }
                });
              }),
          PopupMenuButton<String>(
            onSelected: choiceAction,
            itemBuilder: (BuildContext context) {
              return Constants.choices.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(
                    choice,
                    style: TextStyle(
                      fontFamily: 'Gilroy-ExtraBold',
                      fontSize: 14,
                    ),
                  ),
                );
              }).toList();
            },
            icon: const Icon(Icons.more_vert),
            tooltip: 'Next page',
          ),
        ],
        backgroundColor: Colors.lightBlue[800],
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SaveNote()),
            );
          }),
      body: StreamBuilder(
        stream: _bloc.todos,
        builder: (BuildContext context, AsyncSnapshot<List<Notes>> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                Notes item = snapshot.data[index];
                return Dismissible(
                  key: UniqueKey(),
                  background: Container(color: Colors.lightBlue[900]),
                  onDismissed: (direction) {
                    _database.deleteClient(item.id);
                  },
                  child: ListTile(
                    title: Text(
                      item.noteText,
                      style: TextStyle(
                        fontFamily: 'Gilroy-ExtraBold',
                      ),
                    ),
                    subtitle: Text(
                      item.noteDate,
                      style: TextStyle(
                        fontFamily: 'Gilroy-ExtraBold',
                        fontSize: 12.0,
                      ),
                    ),
                    leading: Icon(Icons.keyboard_arrow_right),
                    trailing: Checkbox(
                      onChanged: (bool value) {
                        _database.blockOrUnblock(item);
                        setState(() {});
                      },
                      value: item.blocked,
                    ),
                  ),
                );
              },
            );
          } else if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: CircularProgressIndicator());
          } else {
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  onDoubleTap: () =>
                      _bloc.dispatch(ToggleTodoEvent(index: index)),
                  onLongPress: () =>
                      _bloc.dispatch(DeleteTodoEvent(index: index)),
                  child: ListTile(
                      title: Text(
                    snapshot.data[index].noteText,
                  )),
                );
              },
            );
          }
        },
      ),
    );
  }
}
