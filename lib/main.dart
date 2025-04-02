import 'package:todo_app/data_source/todo_data_source.dart';
import 'package:todo_app/data_source/todo_data_source_impl.dart';
import 'package:todo_app/repository/todo_repository.dart';
import 'package:todo_app/repository/todo_repository_impl.dart';

void main() async {
  final TodoDataSource todoDataSource = TodoDataSourceImpl();
  final TodoRepository todoRepository = TodoRepositoryImpl(todoDataSource: todoDataSource);

  await todoRepository.addTodo('Hello');
  final todos = await todoRepository.getTodos();


  print(todos);


}