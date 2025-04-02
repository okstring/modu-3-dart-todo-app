import 'package:todo_app/model/todo.dart';

abstract interface class TodoRepository {
  Future<List<Todo>> getTodos({bool? isAscending, bool? isCompleted});
  Future<void> addTodo(String title);
  Future<Todo> updateTodo(int id, String newTitle);
  Future<void> toggleTodo(int id);
  Future<void> deleteTodo(int id);
  Future<int> getLastIndex();
}
