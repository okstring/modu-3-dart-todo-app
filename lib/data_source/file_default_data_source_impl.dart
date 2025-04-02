import 'dart:io';

import 'package:todo_app/data_source/file_default_data_source.dart';

class FileDefaultDataSourceImpl implements FileDefaultDataSource {
  @override
  Future<void> createFileIfNotExists(String path) async {
    final File newFile = File(path);
    bool isExist = await newFile.exists();
    if (!isExist) {
      await newFile.create(recursive: true);
    }
  }

  @override
  Future<String> getFile(String path) async {
    await createFileIfNotExists(path);
    return File(path).readAsString();
  }

  @override
  Future<void> writeFile(String path, String contents) async {
    await createFileIfNotExists(path);
    await File(path).writeAsString(contents);
  }
}
