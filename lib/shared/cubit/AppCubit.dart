import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:planning/modules/archived_task/archived_task.dart';
import 'package:planning/modules/done_task/don_task.dart';
import 'package:planning/modules/new_task/new_task.dart';
import 'package:planning/shared/cubit/AppStates.dart';
import 'package:sqflite/sqflite.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(InitialState());
  //Create instance of AppCubit
  static AppCubit getInstance(context) => BlocProvider.of(context);

  //Bottom drawer
  int currentIndex = 0;
  List<Widget> screens = [NewTask(), DoneTask(), ArchivedTask()];
  List<String> screensName = ["New Task", "Done Task", "Archived Task"];
  void changeScreen(index) {
    currentIndex = index;
    emit(ChangeState());
  }

  //bottom Sheet
  bool bottomSheetOpened = false;
  void changeBottomSheet(bool isOpened) {
    bottomSheetOpened = isOpened;
    emit(ChangeState());
  }
  //DataBase Logic
  Database database;
  List<Map> newList=[];
  List<Map> doneList=[];
  List<Map> archivedList=[];
  // Create database
  void createDataBase() async {
    database = await openDatabase("plan.db", version: 1,
        onCreate: (Database db, int version) {
      // When creating the db, create the table
      db
          .execute(
              'CREATE TABLE plan_table (id INTEGER PRIMARY KEY, title TEXT, time TEXT, date TEXT, state TEXT)')
          .then((value) {
        emit(CreateDbState());
        print("Table is Created");
      });
    },
      onOpen: (database){
          getFormDatabase(database);
      }
    );
  }

  // Insert to database
  void insertToDatabase(String title, String date, String time, String state )async {
    await database.transaction((txn){
       txn.rawInsert(
          'INSERT INTO plan_table(title, time, date, state) VALUES("$title", "$time", "$date", "$state")'
      ).then((value) {
        getFormDatabase(database);
        print("Inserted Successfully id= $value");
       }).catchError((onError){
        print("Error in inserted: $onError");
       });
       return null;
    });
  }
  //Get From Database
  void getFormDatabase(Database database){
    newList=[];archivedList=[];doneList=[];
     database.rawQuery('SELECT * FROM plan_table').then((value) {
       value.forEach((element) {
         if(element["state"]=="New"){
           newList.add(element);
         }else if(element["state"]=="Archive"){
           archivedList.add(element);
         }else{
           doneList.add(element);
         }
       });
       print("${newList} /////// archive ${archivedList}//////// done ${doneList}");
       emit(GetFromDbState());
      print(value);
    });
  }
  //Update Raw in Database
  void updateInDatabase(String state, int id){
    database.rawUpdate(
        'UPDATE plan_table SET state = ? WHERE id = ?',
        ['$state', '$id']
    ).then((value) {
      getFormDatabase(database);
      emit(UpdateDbState());
    }
    );
  }
  // Delete from database
  void deleteFromDatabase(int id){
    database
        .rawDelete('DELETE FROM plan_table WHERE id = ?', ['$id']).then((value) {
          emit(DeleteFromDbState());

    });
  }
}
