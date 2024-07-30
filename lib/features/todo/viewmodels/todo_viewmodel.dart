import 'package:flutter/material.dart';
import '../models/todo_model.dart';

class TodoViewmodel extends ChangeNotifier {
  List<ToDo> tasks = [];

  String? taskName;
  final dateCont = TextEditingController();
  final timeCont = TextEditingController();

  setTaskName(String? value) {
    taskName = value;
    debugPrint(value.toString());
    notifyListeners();
  }

  setDate(DateTime? date) {
    if (date == null) {
      return;
    }
    debugPrint(date.toString());
    DateTime currentDate = DateTime.now();
    DateTime now = DateTime(
      currentDate.year,
      currentDate.month,
      currentDate.day,
    );
    int diff = date.difference(now).inDays;
    if (diff == 0) {
      dateCont.text = 'Today';
    } else if (diff == 1) {
      dateCont.text = 'Tomorrow';
    } else {
      dateCont.text = '${date.day}-${date.month}-${date.year}';
    }
    notifyListeners();
  }

  setTime(TimeOfDay? time) {
    debugPrint(time.toString());
    if (time == null) {
      return;
    }
    if (time.hour == 0) {
      timeCont.text = '12:${time.minute} AM';
    } else if (time.hour < 12) {
      timeCont.text = '${time.hour}:${time.minute} AM';
    } else if (time.hashCode == 12) {
      timeCont.text = '${time.hour}:${time.minute} PM';
    } else {
      timeCont.text = '${time.hour - 12}:${time.minute} PM';
    }
    notifyListeners();
  }

  bool get isValid =>
      taskName != null && dateCont.text.isNotEmpty && timeCont.text.isNotEmpty;

  addTask() {
    if (!isValid) {
      return;
    }
    debugPrint(tasks.length.toString());
    final task = ToDo(taskName!, dateCont.text, timeCont.text);
    tasks.add(task);
    timeCont.clear();
    dateCont.clear();
    notifyListeners();
  }
}
