import 'dart:io';

import 'package:todo_app/data_source/todo_data_source.dart';
import 'package:todo_app/data_source/todo_data_source_impl.dart';
import 'package:todo_app/repository/todo_repository.dart';
import 'package:todo_app/repository/todo_repository_impl.dart';

void main() async {
  final TodoDataSource todoDataSource = TodoDataSourceImpl();
  final TodoRepository todoRepository = TodoRepositoryImpl(
    todoDataSource: todoDataSource,
  );
  String? selectedNum;

  do {
    print('''
      === TODO LIST 프로그램 ===
      1. 목록 보기
      2. 할 일 추가
      3. 할 일 수정
      4. 완료 상태 토글
      5. 할 일 삭제
      0. 종료
      --------------------------
    ''');

    selectedNum = stdin.readLineSync();
    print('선택하세요: $selectedNum');
  } while (selectedNum != '0');
}
