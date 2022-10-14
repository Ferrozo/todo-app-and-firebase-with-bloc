// ignore: depend_on_referenced_packages
import 'package:todos_api/todos_api.dart';

class TodosRepository {
  const TodosRepository({
    required TodosApi todosApi,
  }) : _todosApi = todosApi;

  final TodosApi _todosApi;

  Stream<List<Todo>> getTodos() => _todosApi.getTodos();

  Future<void> saveTodo(Todo todo) => _todosApi.saveTodo(todo);

  Future<void> deleteTodo(String id) => _todosApi.deleteTodo(id);

  Future<int> clearCompletedTodo() => _todosApi.clearCompletedTodo();

  Future<int> completeAllTodo({required bool isCompleted}) =>
      _todosApi.completeAllTodo(isCompleted: isCompleted);
}
