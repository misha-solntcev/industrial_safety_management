import '../models/task.dart';
import '../models/task_list.dart';


class TaskViewModel {  
  final TaskList _taskList = TaskList(tasks: []);

  TaskList get taskList => _taskList;

  void addTask(String title, String description) {
    final task = Task(title: title, description: description);
    _taskList.addTask(task);
  }

  void toggleTaskCompletion(int index) {
    _taskList.toggleTaskCompletion(index);
  }
}