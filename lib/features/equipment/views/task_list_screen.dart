import 'package:flutter/material.dart';
import '../viewmodels/task_viewmodel.dart';
import 'task_detail_screen.dart';

class TaskListScreen extends StatefulWidget {
  const TaskListScreen({super.key});

  @override
  State<TaskListScreen> createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  final _viewModel = TaskViewModel();
  final _formKey = GlobalKey<FormState>();
  String _title = "";
  String _description = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Task List"),
      ),
      body: ListView.builder(
          itemCount: _viewModel.taskList.tasks.length,
          itemBuilder: (context, index) {
            final task = _viewModel.taskList.tasks[index];
            return ListTile(
              title: Text(task.title),
              subtitle: Text(task.description),
              trailing: Checkbox(
                value: task.isCompleted,
                onChanged: (value) {
                  setState(() {
                    _viewModel.toggleTaskCompletion(index);
                  });
                },
              ),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => TaskDetailScreen(task: task)));
              },
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text("Add Task"),
                  content: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        TextFormField(
                          decoration: const InputDecoration(
                            labelText: 'Title',
                          ),
                          onSaved: (value) {
                            // _viewModel.addTask(value!, '');
                            _title = value!;
                          },
                        ),
                        TextFormField(
                          decoration: const InputDecoration(
                            labelText: 'Description',
                          ),
                          onSaved: (value) {
                            // _viewModel.addTask('', value!);
                            _description = value!;
                          },
                        )
                      ],
                    ),
                  ),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          _viewModel.addTask(_title, _description);
                          setState(() {});
                        }
                        Navigator.of(context).pop();
                      },
                      child: const Text('Save'),
                    )
                  ],
                );
              });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
