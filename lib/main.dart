import 'package:flutter/material.dart';
import 'package:industrial_safety_management/app.dart';
import 'package:industrial_safety_management/features/equipment/viewmodels/task_viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'features/equipment/models/database/repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();  
  databaseFactory = databaseFactoryFfi;
  await Repository.database;
  runApp(
    ChangeNotifierProvider(
      create: (context) => TaskViewModel(),
      child: const MyApp(),    
    ) as Widget);
} 



