import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

void main() => runApp(const MyApp());

final GoRouter _router = GoRouter(routes: <RouteBase>[
  GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const MyHomePage();
      },
      routes: <RouteBase>[
        GoRoute(
          path: 'sample',
          builder: (BuildContext context, GoRouterState state) {
            final int index = state.extra as int;
            return DetailScreen(index: index);
          },
        ),
        GoRoute(
          path: 'gas_cariers',
          builder: (BuildContext context, GoRouterState state) {
            final int index = state.extra as int;
            return DetailScreen(index: index);
          },
        )
      ])
]);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
        routerConfig: _router,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.green, brightness: Brightness.dark),
        ));
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
                      // onPressed: () => context.go('/sample', extra: index),

                      onPressed: () async {
                        if (await canLaunchUrl(
                            Uri.parse('http://109.194.27.104:8088/main.php'))) {
                          await launchUrl(
                              Uri.parse('http://109.194.27.104:8088/main.php'));
                        } else {
                          // Ссылка недоступна. Покажите сообщение об ошибке.
                          debugPrint('Не удалось открыть ссылку');
                        }
                      },

                      // {
                      //   // Передаем index в качестве аргумента
                      //   Navigator.pushNamed(context, '/second',
                      //       arguments: index);
                      //   // Navigator.push(context,
                      //   //     MaterialPageRoute(builder: (context) {
                      //   //   return DetailScreen(index: index);}));
                      // },
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

List<String> elem = [
  'Сосуды',
  'Арматура',
  'Персонал',
  'Газовозы',
  'Документы',
  'Ростехнадзор'
];

class DetailScreen extends StatelessWidget {
  // Получаем index из extra
  final int index;
  const DetailScreen({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
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
          onTap: () => context.go('/'),
          child: Center(
            child: Image(
              image: AssetImage('images/pic$index.png'),
            ),
          ),
        ));
  }
}
