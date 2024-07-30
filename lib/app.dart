import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'core/theme/theme.dart';
import 'features/home/home.dart';
import 'features/tank/tank.dart';
import 'features/staff/staff.dart';
import 'features/gas_carriers/gas_carriers.dart';
import 'features/documents/documents.dart';
import 'features/rtn/rtn.dart';
import 'features/equipment/views/task_list_screen.dart';
import 'features/todo/views/todo_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => const MyHomePage()),
        GetPage(name: '/tank', page: () => const TankScreen()),
        GetPage(name: '/equipment', page: () => const DetailScreen()),
        GetPage(name: '/staff', page: () => const TankScreen3()),
        GetPage(name: '/gas_carriers', page: () => const TaskListScreen()),
        GetPage(name: '/documents', page: () => const Sample()),
        GetPage(name: '/rtn', page: () => const Example()),
        GetPage(name: '/todo', page: () => const ToDoScreen()),
      ],
      theme: theme,
      debugShowCheckedModeBanner: false,
    );
  }
}
