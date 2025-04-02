import 'dart:io';

import 'package:todo_app/model/todo.dart';

class LogText {
  static const startText = '''
=== TODO LIST 프로그램 ===
1. 목록 보기
2. 할 일 추가
3. 할 일 수정
4. 완료 상태 토글
5. 할 일 삭제
0. 종료
--------------------------
선택하세요: 
''';

  static void show(List<Todo> todos) {
    print('[할 일 목록]');
    for(int i =0; i<todos.length; i++){
      print('${i+1}. ${todos[i].toString()}\n');
    }
  }

  static String? add(List<Todo> todos) {
    print('할 일 제목을 입력하세요:');
    String? title = stdin.readLineSync();
    print('[할 일 추가됨]');
    return title;
  }

  static void update(List<Todo> todos) {
    print('수정할 할 일 ID를 입력하세요: ');
    String? id = stdin.readLineSync();
    print('새 제목을 입력하세요: ');
    String? title = stdin.readLineSync();
    print('[할 일 제목이 수정되었습니다]');
  }
}
