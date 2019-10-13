import 'dart:async';
import 'package:flutter_bloc/src/bloc/todo_event.dart';
import 'package:flutter_bloc/src/bloc/todo_repository.dart';
import 'package:flutter_bloc/src/model/noteModel.dart';

class TodoBloc {
  List<Notes> _todos;

  final _todoRepository = TodoRepository();
  final _todoStateController = StreamController<List<Notes>>();

  StreamSink<List<Notes>> get _inTodoSink => _todoStateController.sink;
  Stream<List<Notes>> get todos => _todoStateController.stream;

  final _todoEventController = StreamController<TodoEvent>();
  Sink<TodoEvent> get todoEventSink => _todoEventController.sink;

  TodoBloc() {
    _todoEventController.stream.listen(_mapEventToState);
    getTodos();
  }

  getTodos() async {
    _todoStateController.sink.add(await _todoRepository.getAllClients());
  }

  updateTodos(Notes notes) async {
    await _todoRepository.updateClient(notes);
  }

  searchTodos(String search) async {
    _todoStateController.sink.add(await _todoRepository.searchClient(search));
  }

  newClient(Notes newClient) async {
    await _todoRepository.newClient(newClient);
    getTodos();
  }

  deleteClient(int id) async {
    await _todoRepository.deleteClient(id);
    getTodos();
  }

  void _mapEventToState(TodoEvent event) {
    if (event is AddTodoEvent) {
      _todos.add(event.todo);
    } else if (event is DeleteTodoEvent) {
      _todos.removeAt(event.index);
    } else if (event is ToggleTodoEvent) {
      _todos.asMap().forEach((index, todo) {
        if (index == event.index) {
          todo.blocked = !todo.blocked;
        }
      });
    }
    _inTodoSink.add(_todos);
    _inTodoSink.addStream(getTodos());
  }

  void dispatch(TodoEvent event) {
    todoEventSink.add(event);
  }

  void dispose() {
    _todoEventController.close();
    _todoStateController.close();
  }
}
