import 'package:flutter/material.dart';
import '../models/task.dart';
import '../models/task_list.dart';
import '../models/database/repository.dart';


class TaskViewModel extends ChangeNotifier {
  final TaskList _taskList = TaskList(tasks: []);

  TaskList get taskList => _taskList;

  Future<void> addTask(String title, String description) async {
    final task = Task(title: title, description: description);
    await Repository.insertTask(task);
    notifyListeners();
  }

  Future<void> toggleTaskCompletion(int index) async {
    final task = _taskList.tasks[index];
    task.isCompleted = !task.isCompleted;
    await Repository.updateTask(task); 
    notifyListeners();
  }

  Future<void> loadTasks() async {
    _taskList.tasks = await Repository.getTasks(); 
    notifyListeners();
  }
}



// import '../models/task.dart';
// import '../models/task_list.dart';


// class TaskViewModel {  
//   final TaskList _taskList = TaskList(tasks: []);

//   TaskList get taskList => _taskList;

//   void addTask(String title, String description) {
//     final task = Task(title: title, description: description);
//     _taskList.tasks.add(task);
//   }

//   void toggleTaskCompletion(int index) {
//     _taskList.tasks[index].isCompleted = !_taskList.tasks[index].isCompleted;
//   }
// }