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
선택하세요: 
''');
    selectedNum = stdin.readLineSync();
    switch (selectedNum) {
      case '1':
        print('[할 일 목록]');
        final todos = await todoRepository.getTodos();
        for (int i = 0; i < todos.length; i++) {
          print('${i + 1}. ${todos[i].toString()}\n');
        }
        break;
      case '2':
        print('할 일 제목을 입력하세요:');
        String? title = stdin.readLineSync();
        if(title == null){
          print('할 일을 입력해주세요.');
          break;
        }
        await todoRepository.addTodo(title);
        print('[할 일 추가됨]');
        break;
      case '3':
        print('수정할 할 일 ID를 입력하세요: ');
        String? id = stdin.readLineSync();
        print('새 제목을 입력하세요: ');
        String? title = stdin.readLineSync();
        if(id == null || title == null){
          print('값을 입력해주세요.');
          break;
        }
        await todoRepository.updateTodo(int.parse(id), title);
        print('[할 일 제목이 수정되었습니다]');
        break;
      case '4':
        print('완료 상태를 토글할 할 일 ID를 입력하세요: ');
        String? id = stdin.readLineSync();
        if(id == null){
          print('할 일 ID를 입력해주세요.');
          break;
        }
        await todoRepository.toggleTodo(int.parse(id));
        print('[할 일 완료 상태가 변경되었습니다]');
        break;
      case '5':
        print('삭제할 할 일 ID를 입력하세요: ');
        String? id = stdin.readLineSync();
        if(id == null){
          print('삭제할 일 ID를 입력해주세요.');
          break;
        }
        await todoRepository.deleteTodo(int.parse(id));
        print('[할 일이 삭제되었습니다]');
        break;
      case '0':
        print('[프로그램을 종료합니다. 데이터가 저장되었습니다.]');
        break;
      default:
        print('정학한 값을 입력해주세요.');
    }
  } while (selectedNum != '0');
}
