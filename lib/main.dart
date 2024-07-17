import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() => runApp(const MyApp());

List<String> elem = [
  'Сосуды',
  'Арматура',
  'Персонал',
  'Газовозы',
  'Документы',
  'Ростехнадзор'
];
List<String> url = [
  '/tank',
  '/equipment',
  '/staff',
  '/gas_carriers',
  '/documents',
  'rtn'
];

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => const MyHomePage()),
        GetPage(name: '/tank', page: () => const DetailScreen()),
        GetPage(name: '/equipment', page: () => const DetailScreen()),
        GetPage(name: '/staff', page: () => const DetailScreen()),
        GetPage(name: '/gas_carriers', page: () => const DetailScreen()),
        GetPage(name: '/documents', page: () => const DetailScreen()),
        GetPage(name: '/rtn', page: () => const RostechNadzorScreen()),
      ],
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.green, brightness: Brightness.dark),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

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
          children: List.generate(elem.length, (index) {
            return Center(
              child: Stack(
                alignment: const Alignment(-0.8, -0.9),
                children: [
                  Image(image: AssetImage('images/pic$index.png')),
                  ElevatedButton(
                      onPressed: () =>
                          Get.toNamed(url[index], arguments: index),
                      child: Text(elem[index])),
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

class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final index = Get.arguments as int;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(elem[index]),
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

class RostechNadzorScreen extends StatefulWidget {
  const RostechNadzorScreen({super.key});

  @override
  State<RostechNadzorScreen> createState() => _RostechNadzorScreen();
}

class _RostechNadzorScreen extends State<RostechNadzorScreen> {
  late bool _loading;
  late double _progressValue;

  @override
  void initState() {
    _loading = false;
    _progressValue = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Пример"),
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
      body: Center(
          child: Stack(
            fit: StackFit.expand,
        children: [
          const Image(image: AssetImage('assets/images/bg.jpg')),
          Image.asset('assets/icons/flutter.png'),
          Container(
              padding: const EdgeInsets.all(16),
              child: _loading
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        LinearProgressIndicator(
                          value: _progressValue,
                        ),
                        Text(
                          '${(_progressValue * 100).round()}%',
                          style: const TextStyle(
                              color: Colors.white, fontSize: 20),
                        ),
                      ],
                    )
                  : const Text(
                      "Press button to download",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    )),
        ],
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: () => setState(() {
          _loading = !_loading;
          _updateProgress();
        }),
        child: const Icon(Icons.cloud),
      ),
    );
  }

  void _updateProgress() {
    const oneSec = Duration(milliseconds: 1);
    Timer.periodic(oneSec, (Timer t) {
      setState(() {
        _progressValue += 0.01;
        if (_progressValue.toStringAsFixed(1) == '1.0') {
          _loading = false;
          t.cancel();
          _progressValue = 0.0;
          return;
        }
      });
    });
  }
}
