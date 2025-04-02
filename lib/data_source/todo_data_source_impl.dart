import 'dart:convert';

import 'package:todo_app/data_source/file_default_data_source_impl.dart';
import 'package:todo_app/data_source/todo_data_source.dart';

class TodoDataSourceImpl extends FileDefaultDataSource
    implements TodoDataSource {
  static const String _todoPath = 'data/todos.json';
  static const String _tempPath = 'data/backup.dat';

  @override
  Future<List<Map<String, dynamic>>> readTodos() async {
    String jsonString = '';
    if (await isFileExist(_todoPath)) {
      jsonString = await getFile(_todoPath);
      return List<Map<String, dynamic>>.from(jsonDecode(jsonString));
    } else {
      jsonString = await getFile(_tempPath);
      return List<Map<String, dynamic>>.from(jsonDecode(jsonString));
    }
  }

  @override
  Future<void> writeTodos(Map<String, dynamic> todo) async {
    if (!(await isFileExist(_todoPath))) {
      await createFile(_todoPath);
    }
    await writeTodos(todo);
  }
}
