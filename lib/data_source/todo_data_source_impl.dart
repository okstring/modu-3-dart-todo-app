import 'package:todo_app/data_source/file_default_data_source_impl.dart';
import 'package:todo_app/data_source/todo_data_source.dart';

class TodoDataSourceImpl extends FileDefaultDataSource implements TodoDataSource {
  @override
  Future<List<Map<String, dynamic>>> readTodos() async {
    return [];
  }

  @override
  Future<bool> writeTodos(Map<String, dynamic> todo) {
    // TODO: implement writeTodos
    throw UnimplementedError();
  }
}