import 'package:flutter/material.dart';
import 'package:industrial_safety_management/app.dart';
import 'features/todo/viewmodels/todo_viewmodel.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:provider/provider.dart';
import 'features/equipment/models/database/repository.dart';
import 'features/equipment/viewmodels/task_viewmodel.dart';

void main() async {
  databaseFactory = databaseFactoryFfi;
  await Repository.database;
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => TaskViewModel()),
    ChangeNotifierProvider(create: (context) => TodoViewmodel()),
  ], child: const MyApp()));
}
