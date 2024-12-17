import 'package:flutter/material.dart';
import 'package:flutter_application_1/modules/todo_app/archived_tasks/archived_screen.dart';
import 'package:flutter_application_1/modules/todo_app/done_tasks/done_screen.dart';
import 'package:flutter_application_1/modules/todo_app/new_tasks/new_screen.dart';
import 'package:flutter_application_1/shared/cubit/states.dart';
import 'package:flutter_application_1/shared/network/local/chashed_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<Widget> screens = [
    NewTasks(),
    DoneTasks(),
    ArchivedTasks(),
  ];
  List<String> titles = [
    'New Tasks',
    'Done Tasks',
    'Archived Tasks',
  ];

  void changeIndex(int index) {
    currentIndex = index;
    emit(AppChangeBottomNavBarState());
  }

  late Database database;
  List<Map> newTasks = [];
  List<Map> doneTasks = [];
  List<Map> archivedTasks = [];

  void createDatabase() {
    openDatabase(
      'todo.db',
      version: 1,
      onCreate: (database, version) {
        print('Database created');
        database
            .execute('CREATE TABLE tasks '
                '(id INTEGER PRIMARY KEY, title TEXT, time TEXT, date TEXT, status TEXT)')
            .then((value) {
          print('Table created');
        }).catchError((error) {
          print('Error when creating database ${error.toString()}');
        });
      },
      onOpen: (database) {
        getDataFromDatabase(database);
        print('Database is opened');
      },
    ).then((value) {
      database = value;
      emit(AppCreateDatabaseState());
    });
  }

  Future<void> insertToDatabase({
    required String title,
    required String time,
    required String date,
  }) async {
    await database.transaction((txn) async {
      txn
          .rawInsert(
              'INSERT INTO tasks (title, time, date, status) VALUES (?, ?, ?, ?)',
              [title, time, date, 'new'])
          .then((value) {
        print('$value inserted successfully!');
        emit(AppInsertDatabaseState());
        getDataFromDatabase(database);
      }).catchError((error) {
        print('Error when inserting to database ${error.toString()}');
      });
    });
  }

  void getDataFromDatabase(Database database) {
    newTasks = [];
    doneTasks = [];
    archivedTasks = [];

    emit(AppGetDatabaseLoadingState());
    database.rawQuery('SELECT * FROM tasks').then((value) {
      for (var element in value) {
        if (element['status'] == 'new') {
          newTasks.add(element);
        } else if (element['status'] == 'done') {
          doneTasks.add(element);
        } else {
          archivedTasks.add(element);
        }
      }
      emit(AppGetDatabaseState());
    });
  }

  void updateData({
    required String status,
    required int id,
  }) async {
    database.rawUpdate(
      'UPDATE tasks SET status = ? WHERE id = ?',
      [status, id],
    ).then((value) {
      getDataFromDatabase(database);
      emit(AppUpdateDatabaseState());
    });
  }

  void deleteData({
    required int id,
  }) async {
    database.rawDelete(
      'DELETE FROM tasks WHERE id = ?',
      [id],
    ).then((value) {
      getDataFromDatabase(database);
      emit(AppDeleteDatabaseState());
    });
  }

  bool isBottomSheetShown = false;
  IconData fabIcon = Icons.edit;

  void changeBottomSheetState({
    required bool isShow,
    required IconData icon,
  }) {
    isBottomSheetShown = isShow;
    fabIcon = icon;
    emit(AppChangeBottomSheetState());
  }

  bool isDark = false;

  void changeAppMode({bool? fromShared}) {
    throw UnimplementedError();
    // if (fromShared != null) {
    //   isDark = fromShared;
    //   emit(AppChangeModeState());
    // } else {
    //   isDark = !isDark;
    //   CashHelper.putBoolean(key: 'isDark', value: isDark).then((value) {
    //     emit(AppChangeModeState());
    //   });
    // }
  }
}
