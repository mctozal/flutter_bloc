import 'package:flutter_bloc/src/bloc/todo_database.dart';
import 'package:flutter_bloc/src/model/noteModel.dart';

class TodoRepository {

  final todoDao = TodoDao();

  newClient(Notes newClient) => todoDao.newClient(newClient);

  blockOrUnblock(Notes client) => todoDao.blockOrUnblock(client);

  updateClient(Notes newClient) => todoDao.updateClient(newClient);

  getClient(int id) => todoDao.getClient(id);

  Future<List<Notes>> searchClient(String search) => todoDao.searchClient(search);

  Future<List<Notes>> getBlockedClients() => todoDao.getBlockedClients();

  Future<List<Notes>> getAllClients() => todoDao.getAllClients();

  deleteClient(int id) => todoDao.deleteClient(id);

  deleteAll() => todoDao.deleteAll();
  
}
