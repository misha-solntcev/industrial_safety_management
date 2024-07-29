import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:industrial_safety_management/core/theme/theme.dart';
import 'package:industrial_safety_management/features/home/home.dart';
import 'package:industrial_safety_management/features/tank/tank.dart';
import 'package:industrial_safety_management/features/staff/staff.dart';
import 'package:industrial_safety_management/features/gas_carriers/gas_carriers.dart';
import 'package:industrial_safety_management/features/documents/documents.dart';
import 'package:industrial_safety_management/features/rtn/rtn.dart';
import 'package:industrial_safety_management/features/equipment/views/task_list_screen.dart';


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
      ],
      theme: theme,
      debugShowCheckedModeBanner: false,
    );
  }
}
