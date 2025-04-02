import 'package:todo_app/data_source/log_data_source.dart';
import 'package:todo_app/data_source/log_data_source_impl.dart';
import 'package:todo_app/data_source/todo_data_source.dart';
import 'package:todo_app/data_source/todo_data_source_impl.dart';
import 'package:todo_app/manage/log_operator.dart';
import 'package:todo_app/repository/log_repository.dart';
import 'package:todo_app/repository/log_repository_impl.dart';
import 'package:todo_app/repository/todo_repository.dart';
import 'package:todo_app/cli/todo_cli.dart';
import 'package:todo_app/repository/todo_repository_impl.dart';

void main() async {
  final TodoDataSource todoDataSource = TodoDataSourceImpl();
  final TodoRepository todoRepository = TodoRepositoryImpl(
    todoDataSource: todoDataSource,
  );
  final LogDataSource logDataSource = LogDataSourceImpl();
  final LogRepository logRepository = LogRepositoryImpl(
    logDataSource: logDataSource,
  );
  final logOperator = LogOperator(logRepository);

  final todoCli = TodoCLI(
    todoRepository: todoRepository,
    logOperator: logOperator,
  );

  todoCli.run();
}