import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:industrial_safety_management/core/db/data.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final index = Get.arguments as int;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(data.map((e)=>e.title).toList()[index]),
          actions: const [
            IconButton(
              icon: Icon(Icons.filter_alt),
              tooltip: 'Filter',
              onPressed: null,
            ),
            IconButton(
              icon: Icon(Icons.search),
              tooltip: 'Search',
              onPressed: null,
            ),
          ],
        ),
        body: GestureDetector(
          onTap: () => Get.back(),
          child: Center(
            child: Image(
              image: AssetImage('images/pic$index.png'),
            ),
          ),
        ));
  }
}