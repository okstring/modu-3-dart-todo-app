import 'package:todo_app/data_source/todo_data_source.dart';
import 'package:todo_app/model/todo.dart';
import 'package:todo_app/repository/todo_repository.dart';

class TodoRepositoryImpl implements TodoRepository {
  final TodoDataSource _todoDataSource;

  TodoRepositoryImpl({required TodoDataSource todoDataSource})
    : _todoDataSource = todoDataSource;

  @override
  Future<void> addTodo(String title) async {
    final lastId = await getLastIndex();
    final newTodo = Todo(
      userId: 1,
      id: lastId + 1,
      title: title,
      completed: false,
      createdAt: DateTime.now(),
    );

    final todos = await getTodos();
    todos.add(newTodo);
    _todoDataSource.writeTodos(todos.map((e) => e.toJson()).toList());
  }

  @override
  Future<void> deleteTodo(int id) async {
    final todos = await getTodos();
    todos.removeWhere((e) => e.id == id);
    _todoDataSource.writeTodos(todos.map((e) => e.toJson()).toList());
  }

  @override
  Future<int> getLastIndex() async {
    final todos = await getTodos();
    return todos.last.id;
  }

  @override
  Future<List<Todo>> getTodos({bool? isAscending, bool? isCompleted}) async {
    final todos = await _todoDataSource.readTodos();
    return List<Todo>.from(todos);
  }

  @override
  Future<void> toggleTodo(int id) async {
    final todos = await getTodos();
    final result =
        todos
            .map((e) => e.id == id ? e.copyWith(completed: !e.completed) : e)
            .toList();
    _todoDataSource.writeTodos(result.map((e) => e.toJson()).toList());
  }

  @override
  Future<Todo> updateTodo(int id, String newTitle) {
    // TODO: implement updateTodo
    throw UnimplementedError();
  }
}
