import 'package:flutter/material.dart';
import 'package:industrial_safety_management/features/todo/models/todo_model.dart';
import 'package:industrial_safety_management/features/todo/viewmodels/todo_viewmodel.dart';
import 'package:provider/provider.dart';

class ToDoScreen extends StatelessWidget {
  const ToDoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("To Do List"),
      ),
      body: Consumer<TodoViewmodel>(builder: (context, todoProvider, _) {
        return CustomScrollView(slivers: [
          SliverToBoxAdapter(
            child: Image.asset('assets/images/pic0.png'),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                final task = todoProvider.tasks[index];
                return ToDoWidget(
                  task: task,
                );
              },
              childCount: todoProvider.tasks.length,
            ),
          ),
        ]);
      }),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Я пока ничего не делаю)',
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) {
                return const CustomDialog();
              });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class ToDoWidget extends StatelessWidget {
  const ToDoWidget({
    super.key,
    required this.task,
  });
  final ToDo task;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(task.taskName),
      subtitle: Text('${task.date}, ${task.time}'),
      onTap: () {},
    );
  }
}

class CustomDialog extends StatelessWidget {
  const CustomDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    double sh = MediaQuery.sizeOf(context).height;
    double sw = MediaQuery.sizeOf(context).width;
    final todoProvider = Provider.of<TodoViewmodel>(context, listen: false);
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25),
      ),
      child: SizedBox(
        height: sh * 0.45,
        width: sw * 0.8,
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: sw * 0.05, vertical: sh * 0.02),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Align(
                alignment: Alignment.center,
                child: Text(
                  'New Task',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text('What has to be done?'),
              CustomTextField(
                hint: "Enter a Task",
                onChanged: (value) {
                  todoProvider.setTaskName(value);
                },
              ),
              const SizedBox(height: 50),
              const Text('Due Date'),
              CustomTextField(
                hint: "Enter Date",
                readOnly: true,
                icon: Icons.calendar_month_outlined,
                controller: todoProvider.dateCont,
                onTap: () async {
                  DateTime? date = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2020),
                    lastDate: DateTime(2030),
                  );
                  todoProvider.setDate(date);
                },
              ),
              const SizedBox(height: 10),
              CustomTextField(
                hint: "Enter Time",
                readOnly: true,
                icon: Icons.timer,
                controller: todoProvider.timeCont,
                onTap: () async {
                  TimeOfDay? time = await showTimePicker(
                      context: context, initialTime: TimeOfDay.now());
                  todoProvider.setTime(time);
                },
              ),
              const SizedBox(height: 30),
              Align(
                alignment: Alignment.center,
                child: ElevatedButton(
                    onPressed: () async {
                      await todoProvider.addTask();
                      if (context.mounted) {
                        Navigator.pop(context);
                      }
                    },
                    child: const Text('Create')),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.hint,
    this.icon,
    this.onTap,
    this.readOnly = false,
    this.onChanged,
    this.controller,
  });
  final String hint;
  final IconData? icon;
  final void Function()? onTap;
  final bool readOnly;
  final void Function(String)? onChanged;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      width: double.infinity,
      child: TextField(
        readOnly: readOnly,
        controller: controller,
        onChanged: onChanged,
        decoration: InputDecoration(
          suffixIcon: InkWell(
            onTap: onTap,
            child: Icon(icon),
          ),
          hintText: hint,
        ),
      ),
    );
  }
}
