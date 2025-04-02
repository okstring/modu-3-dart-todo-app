import 'dart:io';

enum dataType{
  todo,
  log,
}

abstract class FileDefaultDataSource {
  Future<void> createFileIfNotExists(String path) async {
    final File newFile = File(path);
    bool isExist = await newFile.exists();
    if (!isExist) {
      await newFile.create(recursive: true);
    }
  }

  Future<String> getFile(String path) async {
    final fileName = path.split('/').last == 'todo.json';
    await createFileIfNotExists(path);
    return File(path).readAsString();
  }

  Future<void> writeFile(String path, String contents) async {
    await createFileIfNotExists(path);
    await File(path).writeAsString(contents);
  }
}
