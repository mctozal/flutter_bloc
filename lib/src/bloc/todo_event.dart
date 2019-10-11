import 'package:flutter_bloc/src/model/noteModel.dart';

abstract class TodoEvent {}

class AddTodoEvent extends TodoEvent {  
  Notes todo;
  AddTodoEvent({this.todo});
}

class DeleteTodoEvent extends TodoEvent {
  int index;
  DeleteTodoEvent({this.index});
}

class ToggleTodoEvent extends TodoEvent {
  int index;
  ToggleTodoEvent({this.index});
}

class SearchTodoEvent extends TodoEvent {
Notes todo;
SearchTodoEvent({this.todo});
}