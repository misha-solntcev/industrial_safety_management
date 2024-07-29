import 'task.dart';

class TaskList {
  final List<Task> tasks;

  TaskList({required this.tasks});

  void addTask(Task task) {
    tasks.add(task);
  }

  void toggleTaskCompletion(int index) {
    tasks[index].isCompleted = !tasks[index].isCompleted;
  }
}
