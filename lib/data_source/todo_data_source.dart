abstract interface class TodoDataSource {
  Future<List<Map<String, dynamic>>> readTodos();
  Future<void> writeTodos(Map<String, dynamic> todo);
}