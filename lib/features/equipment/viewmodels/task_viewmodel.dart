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
    await loadTasks();
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

  Future<void> deleteTasks(int index) async {
    final task = _taskList.tasks[index];
    await Repository.deleteTask(task);
    await loadTasks();
    notifyListeners();
  }
}
