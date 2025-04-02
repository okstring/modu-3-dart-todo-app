abstract interface class LogDataSource {
  Future<bool> writeLog();
  Future<String> readLog();
}
