abstract interface class TodoDataSource {
  Future<List<Map<String, dynamic>>> readTodos();
  Future<bool> writeTodos(Map<String, dynamic> todo);
}