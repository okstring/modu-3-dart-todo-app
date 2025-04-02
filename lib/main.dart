import 'dart:io';

import 'package:intl/intl.dart';
import 'package:todo_app/data_source/log_data_source_impl.dart';
import 'package:todo_app/data_source/todo_data_source.dart';
import 'package:todo_app/data_source/todo_data_source_impl.dart';
import 'package:todo_app/enum/todo_condition.dart';
import 'package:todo_app/model/todo.dart';
import 'package:todo_app/repository/log_repository.dart';
import 'package:todo_app/repository/log_repository_impl.dart';
import 'package:todo_app/repository/todo_repository.dart';
import 'package:todo_app/repository/todo_repository_impl.dart';

void main() async {
  final TodoDataSource todoDataSource = TodoDataSourceImpl();
  final TodoRepository todoRepository = TodoRepositoryImpl(
    todoDataSource: todoDataSource,
  );
  final LogRepository logRepository = LogRepositoryImpl(
    logDataSource: LogDataSourceImpl(),
  );
  String? selectedNum;
  String now = DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());
  await logRepository.saveLog('[$now] 앱 시작됨.\n');
  do {
    print('''\n
=== TODO LIST 프로그램 ===
1. 목록 보기
2. 할 일 추가
3. 할 일 수정
4. 완료 상태 토글
5. 할 일 삭제
0. 종료
--------------------------
선택하세요: ''');
    stdout.flush();
    selectedNum = stdin.readLineSync();
    switch (selectedNum) {
      case '1':
        print('''
=== 옵션 선택 ===
0: 기본
1: 오름차순
2: 내림차순
3: 완료만
4: 미완료만
------------------
선택하세요: ''');
        String? conditionNum = stdin.readLineSync();
        List<Todo> todos = await todoRepository.getTodos();
        print('\n[할 일 목록]');
        if (conditionNum == '1') {
          todos = await todoRepository.getTodos(
            condition: TodoCondition.isAscending,
          );
        } else if (conditionNum == '2') {
          todos = await todoRepository.getTodos(
            condition: TodoCondition.isDecending,
          );
        } else if (conditionNum == '3') {
          todos = await todoRepository.getTodos(
            condition: TodoCondition.isCompleted,
          );
        } else if (conditionNum == '4') {
          todos = await todoRepository.getTodos(
            condition: TodoCondition.isNotCompleted,
          );
        }

        for (int i = 0; i < todos.length; i++) {
          print('${i + 1}. ${todos[i].toString()}\n');
        }
        break;
      case '2':
        print('할 일 제목을 입력하세요:');
        String? title = stdin.readLineSync();
        if (title == null) {
          print('할 일을 입력해주세요.');
          break;
        }
        await todoRepository.addTodo(title);
        int id = await todoRepository.getLastIndex();
        print('[할 일 추가됨]');
        await logRepository.saveLog(
          '[$now] 할 일 추가됨 - ID: $id, 제목: \'$title\'\n',
        );
        break;
      case '3':
        print('수정할 할 일 ID를 입력하세요: ');
        String? id = stdin.readLineSync();
        print('새 제목을 입력하세요: ');
        String? title = stdin.readLineSync();
        if (id == null || title == null) {
          print('값을 입력해주세요.');
          break;
        }
        await todoRepository.updateTodo(int.parse(id), title);
        print('[할 일 제목이 수정되었습니다]');
        await logRepository.saveLog(
          '[$now] 할 일 제목 수정 - ID: $id, 제목: \'$title\'\n',
        );
        break;
      case '4':
        print('완료 상태를 토글할 할 일 ID를 입력하세요: ');
        String? id = stdin.readLineSync();
        if (id == null) {
          print('할 일 ID를 입력해주세요.');
          break;
        }
        bool isCompleted = await todoRepository.toggleTodo(int.parse(id));
        print('[할 일 완료 상태가 변경되었습니다]');
        await logRepository.saveLog(
          '[$now] 할 일 완료 토글 - ID: $id, 상태: ${isCompleted ? '완료됨' : '미완료됨'}\n',
        );
        break;
      case '5':
        print('삭제할 할 일 ID를 입력하세요: ');
        String? id = stdin.readLineSync();
        if (id == null) {
          print('삭제할 일 ID를 입력해주세요.');
          break;
        }
        await todoRepository.deleteTodo(int.parse(id));
        print('[할 일이 삭제되었습니다]');
        await logRepository.saveLog('[$now] 할 일 삭제됨 - ID: $id\n');
        break;
      case '0':
        print('[프로그램을 종료합니다. 데이터가 저장되었습니다.]');
        await logRepository.saveLog('[$now] 앱 종료됨\n');
        break;
      default:
        print('정학한 값을 입력해주세요.');
    }
  } while (selectedNum != '0');
}
