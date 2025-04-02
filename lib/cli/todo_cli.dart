import 'dart:io';
import 'package:todo_app/enum/log_condition.dart';
import 'package:todo_app/manage/log_operator.dart';
import 'package:todo_app/model/todo.dart';
import 'package:todo_app/repository/todo_repository.dart';

class TodoCLI {

  final TodoRepository todoRepository;
  final LogOperator logOperator;

  TodoCLI({
    required this.todoRepository,
    required this.logOperator,
  });

  Future<void> run() async {
    String selectedNum;
    await logOperator.log('앱 시작됨.');

    do {
      showMenu();
      selectedNum = stdin.readLineSync() ?? '0';

      switch (LogCondition.convertLogCondition(selectedNum)) {
        case LogCondition.show:
          final todos = await todoRepository.getTodos();
          showTodos(todos);
          break;
        case LogCondition.add:
          String title = getUserInput('할 일 제목을 입력하세요:');
          await todoRepository.addTodo(title);
          int id = await todoRepository.getLastIndex();
          print('[할 일 추가됨]');
          await logOperator.log('할 일 추가됨 - ID: $id, 제목: \'$title\'');
          break;
        case LogCondition.update:
          String id = getUserInput('수정할 할 일 ID를 입력하세요:');
          String title = getUserInput('새 제목을 입력하세요:');
          await todoRepository.updateTodo(int.parse(id), title);
          print('[할 일 제목이 수정되었습니다]');
          await logOperator.log('할 일 수정 - ID: $id, 제목: \'$title\'');
          break;
        case LogCondition.toggle:
          String id = getUserInput('완료 상태를 토글할 할 일 ID를 입력하세요:');
          bool isCompleted = await todoRepository.toggleTodo(int.parse(id));
          print('[할 일 완료 상태가 변경되었습니다]');
          await logOperator.log(
            '할 일 완료 토글 - ID: $id, 상태: ${isCompleted ? '완료됨' : '미완료됨'}',
          );
          break;
        case LogCondition.delete:
          String id = getUserInput('삭제할 할 일 ID를 입력하세요:');
          await todoRepository.deleteTodo(int.parse(id));
          print('[할 일이 삭제되었습니다]');
          await logOperator.log('할 일 삭제됨 - ID: $id');
          break;
        case LogCondition.end:
          print('[프로그램을 종료합니다. 데이터가 저장되었습니다.]');
          await logOperator.log('앱 종료됨');
          break;
      }
    } while (selectedNum != '0');
  }

  void showMenu() {
    print('''
=== TODO LIST 프로그램 ===
1. 목록 보기
2. 할 일 추가
3. 할 일 수정
4. 완료 상태 토글
5. 할 일 삭제
0. 종료
--------------------------
선택하세요: 
''');
  }

  void showTodos(List<Todo> todos) {
    print('[할 일 목록]');
    for (int i = 0; i < todos.length; i++) {
      print('${i + 1}. ${todos[i].toString()}');
    }
  }

  String getUserInput(String message) {
    print(message);
    return stdin.readLineSync() ?? '';
  }
}
