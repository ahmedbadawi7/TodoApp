import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:todoapp/db/db_helper.dart';

import '../models/task.dart';
class TaskController extends GetxController {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController noteController = TextEditingController();
  final tasklist = <Task>[].obs;

  addTask(Task task)async{
    await DBHelper.instance.insert(task);
    print(DBHelper.instance.insert(task));
  }

 Future<void> getTask()async{
  final List<Map<String, dynamic>> tasks = await DBHelper.query();

 tasklist.assignAll(tasks.map((data) =>
     Task.fromJson(data)).toList());
 // print(tasklist);
 }

 void deleteTask(Task task)async{
   await DBHelper.delete(task);
 getTask();
 }
 void deleteAllTasks() async{
   await DBHelper.deleteAll();
   getTask();

 }


  void makeTaskCompleted(int id)async{
  await DBHelper.update(id);
 getTask();
 }

}
