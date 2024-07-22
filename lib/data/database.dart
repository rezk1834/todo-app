import 'package:hive/hive.dart';

class ToDo {

  List toDoList=[];
  final box = Hive.box('ToDoList');

  void createInitialData(){
    toDoList = [['ادعي لإخوانا في غزة',false],];
  }
  void loadData(){
    toDoList=box.get("ToDoList");
  }
  void updateData(){
    box.put("ToDoList",toDoList);
  }
}