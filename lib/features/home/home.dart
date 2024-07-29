
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:industrial_safety_management/core/db/data.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Home"),
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
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 15,
          mainAxisSpacing: 15,
          children: List.generate(data.length, (index) {
            return Center(
              child: Stack(
                alignment: const Alignment(-0.8, -0.9),
                children: [
                  Image(image: AssetImage('images/pic$index.png')),
                  ElevatedButton(
                      onPressed: () =>
                          Get.toNamed(data.map((e)=>e.url).toList()[index], arguments: index),
                      child: Text(data.map((e)=>e.title).toList()[index])),
                ],
              ),
            );
          }),
        ),
      ),
      floatingActionButton: const FloatingActionButton(
        tooltip: 'Я пока ничего не делаю)',
        onPressed: null,
        child: Icon(Icons.add),
      ),
    );
  }
}