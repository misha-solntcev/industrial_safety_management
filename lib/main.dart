import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:industrial_safety_management/theme/theme.dart';
import 'dart:math' as math;

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
        GetPage(name: '/tank', page: () => const TankScreen()),
        GetPage(name: '/equipment', page: () => const DetailScreen()),
        GetPage(name: '/staff', page: () => const DetailScreen()),
        GetPage(name: '/gas_carriers', page: () => const DetailScreen()),
        GetPage(name: '/documents', page: () => const DetailScreen()),
        GetPage(name: '/rtn', page: () => const DetailScreen()),
      ],
      theme: theme,
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

class TankScreen extends StatefulWidget {
  const TankScreen({super.key});

  @override
  State<TankScreen> createState() => _TankScreenState();
}

class _TankScreenState extends State<TankScreen> {
  final tank = {
    'Наименование': 'Сосуд ППЦЗ 12-01.00 000 СБ',
    'Заводской номер': '0000134',
    'Регистрационый номер': '11885',
    'Рабочее давление': '1,6 Мпа (16 кгс/см2)',
    'Вместимость геометрическая': '13,17 м3',
    'Вместимость полезная': '11,19 м3',
    'Расчетный срок службы': '20 лет',
    'Дата изготовления': '24 марта 2005 года',
    'Дата регистрации': '25 апреля 2016 года',
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const Text("Сосуд"),
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
        body: Column(
          children: [
            SizedBox(
              width: 400,
              child: Image.asset('assets/images/38103.jpg'),
            ),
            Expanded(
                child: ListView.separated(
              shrinkWrap: true,
              padding: const EdgeInsets.all(8),
              itemCount: tank.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  leading: const Icon(Icons.push_pin),
                  title: Text(tank.keys.elementAt(index)),
                  subtitle: Text(tank.values.elementAt(index)),
                  trailing: IconButton(
                    icon: const Icon(
                      Icons.more_vert,
                    ),
                    onPressed: () => debugPrint('Нажали трейлинг $index'),
                  ),
                  onTap: () => debugPrint('Нажали ListTile $index'),
                );
              },
              separatorBuilder: (BuildContext context, int index) =>
                  const Divider(),
            ))
          ],
        ));
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
