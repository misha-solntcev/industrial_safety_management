import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/task_viewmodel.dart';
import 'task_detail_screen.dart';

class TaskListScreen extends StatefulWidget {
  const TaskListScreen({super.key});

  @override
  State<TaskListScreen> createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  final _formKey = GlobalKey<FormState>();
  String _title = "";
  String _description = "";

  @override
  void initState() {
    super.initState();
    context.read<TaskViewModel>().loadTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Task List"),
      ),
      body: Consumer<TaskViewModel>(
        builder: (context, viewModel, child) {
          return ListView.builder(
              itemCount: viewModel.taskList.tasks.length,
              itemBuilder: (context, index) {
                final task = viewModel.taskList.tasks[index];
                return ListTile(
                  title: Text(task.title),
                  subtitle: Text(task.description),
                  trailing: Wrap(                    
                    children: [
                      Checkbox(
                        value: task.isCompleted,
                        onChanged: (value) {
                          setState(() {
                            viewModel.toggleTaskCompletion(index);
                          });
                        },
                      ),
                      IconButton(
                          onPressed: () {
                            context
                              .read<TaskViewModel>()
                              .deleteTasks(index);
                          }, icon: const Icon(Icons.delete))
                    ],
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                TaskDetailScreen(task: task)));
                  },
                );
              });
        },
      ),
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
                          onSaved: (value) => _title = value!,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please enter a title";
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          decoration: const InputDecoration(
                            labelText: 'Description',
                          ),
                          onSaved: (value) => _description = value!,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please enter a description";
                            }
                            return null;
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
                          context
                              .read<TaskViewModel>()
                              .addTask(_title, _description);
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
