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
        GetPage(name: '/equipment', page: () => const CustomDrawer3D()),
        GetPage(name: '/staff', page: () => const StaffScreen()),
        GetPage(
            name: '/gas_carriers',
            page: () => const AnimatedPositionedExampleApp()),
        GetPage(name: '/documents', page: () => const DocumentsScreen()),
        GetPage(name: '/rtn', page: () => const RostechNadzorScreen()),
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
        title: const Text("Sample"),
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
          Image.asset('assets/icons/icons8-flutter-240.png'),
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
                        style:
                            const TextStyle(color: Colors.black, fontSize: 20),
                      ),
                    ],
                  )
                : const Text(
                    "Press button to download",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                    ),
                  ),
          ),
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

class DocumentsScreen extends StatelessWidget {
  const DocumentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const Text("DOCUMENTS"),
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
        body: Container(
          decoration: BoxDecoration(
            color: Colors.indigo[100],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(20),
                  color: Colors.red,
                  child: const Text('1'),
                ),
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(20),
                  color: Colors.green,
                  child: const Text('2'),
                ),
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(20),
                  color: Colors.blue,
                  child: const Text('3'),
                ),
              ),
            ],
          ),
        ));
  }
}

class StaffScreen extends StatefulWidget {
  const StaffScreen({super.key});

  @override
  State<StaffScreen> createState() => _StaffScreenState();
}

class _StaffScreenState extends State<StaffScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Staff"),
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
        child: Stack(
          children: [
            AnimatedBuilder(
                animation: _animationController,
                child: const MyImage(),
                builder: (context, child) => Transform.rotate(
                      angle: _animationController.value * math.pi,
                      child: child,
                    )),
          ],
        ),
      ),
      floatingActionButton: const FloatingActionButton(
        tooltip: 'Пример анимации',
        onPressed: null,
        child: Icon(Icons.add),
      ),
    );
  }
}

class MyImage extends StatelessWidget {
  const MyImage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Image(
        image: AssetImage('assets/images/pic2.png'),
      ),
    );
  }
}

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({super.key});

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late bool _canBeDragged;
  final double maxSlide = 225.0;
  final double minDragStartEdge = 50.0; // Пример значения
  final double maxDragStartEdge = 200.0; // Пример значения

  @override
  void initState() {
    super.initState();
    _canBeDragged = false; // Инициализируем _canBeDragged
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
  }

  void _onDragStart(DragStartDetails details) {
    bool isDragOpenFromLeft = animationController.isDismissed &&
        details.globalPosition.dx < minDragStartEdge;
    bool isDragCloseFromRight = animationController.isCompleted &&
        details.globalPosition.dx > maxDragStartEdge;

    _canBeDragged = isDragOpenFromLeft || isDragCloseFromRight;
  }

  void _onDragUpdate(DragUpdateDetails details) {
    if (_canBeDragged) {
      double delta = details.primaryDelta! / maxSlide;
      animationController.value += delta;
    }
  }

  void _onDragEnd(DragEndDetails details) {
    if (animationController.isDismissed || animationController.isCompleted) {
      return;
    }
    if (details.velocity.pixelsPerSecond.dx.abs() >= 365.0) {
      double visualVelocity = details.velocity.pixelsPerSecond.dx /
          MediaQuery.of(context).size.width;

      animationController.fling(velocity: visualVelocity);
    } else if (animationController.value < 0.5) {
      animationController.reverse();
    } else {
      animationController.forward();
    }
  }

  void toggleDrawer() {
    animationController.isDismissed
        ? animationController.forward()
        : animationController.reverse();
  }

  @override
  Widget build(BuildContext context) {
    var myDrawer = Image.asset('assets/images/pic0.png');
    var myChild = Image.asset('assets/images/pic3.png');
    return GestureDetector(
        onHorizontalDragStart: _onDragStart,
        onHorizontalDragUpdate: _onDragUpdate,
        onHorizontalDragEnd: _onDragEnd,
        onTap: toggleDrawer,
        child: AnimatedBuilder(
            animation: animationController,
            builder: (context, _) {
              double slide = maxSlide * animationController.value;
              double scale = 1 - (animationController.value * 0.3);
              return Stack(
                children: [
                  myDrawer,
                  Transform(
                    transform: Matrix4.identity()
                      ..translate(slide)
                      ..scale(scale),
                    alignment: Alignment.centerLeft,
                    child: myChild,
                  )
                ],
              );
            }));
  }
}

class CustomDrawer3D extends StatefulWidget {
  const CustomDrawer3D({super.key});

  @override
  State<CustomDrawer3D> createState() => _CustomDrawer3DState();
}

class _CustomDrawer3DState extends State<CustomDrawer3D>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late bool _canBeDragged;
  final double maxSlide = 225.0;
  final double minDragStartEdge = 50.0; // Пример значения
  final double maxDragStartEdge = 200.0; // Пример значения

  @override
  void initState() {
    super.initState();
    _canBeDragged = false; // Инициализируем _canBeDragged
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
  }

  void _onDragStart(DragStartDetails details) {
    bool isDragOpenFromLeft = _animationController.isDismissed &&
        details.globalPosition.dx < minDragStartEdge;
    bool isDragCloseFromRight = _animationController.isCompleted &&
        details.globalPosition.dx > maxDragStartEdge;

    _canBeDragged = isDragOpenFromLeft || isDragCloseFromRight;
  }

  void _onDragUpdate(DragUpdateDetails details) {
    if (_canBeDragged) {
      double delta = details.primaryDelta! / maxSlide;
      _animationController.value += delta;
    }
  }

  void _onDragEnd(DragEndDetails details) {
    if (_animationController.isDismissed || _animationController.isCompleted) {
      return;
    }
    if (details.velocity.pixelsPerSecond.dx.abs() >= 365.0) {
      double visualVelocity = details.velocity.pixelsPerSecond.dx /
          MediaQuery.of(context).size.width;

      _animationController.fling(velocity: visualVelocity);
    } else if (_animationController.value < 0.5) {
      _animationController.reverse();
    } else {
      _animationController.forward();
    }
  }

  void toggleDrawer() {
    _animationController.isDismissed
        ? _animationController.forward()
        : _animationController.reverse();
  }

  @override
  Widget build(BuildContext context) {
    var myDrawer = Image.asset('assets/images/pic0.png');
    var myChild = Image.asset('assets/images/pic3.png');
    return GestureDetector(
        onHorizontalDragStart: _onDragStart,
        onHorizontalDragUpdate: _onDragUpdate,
        onHorizontalDragEnd: _onDragEnd,
        onTap: toggleDrawer,
        child: AnimatedBuilder(
            animation: _animationController,
            builder: (context, _) {
              // double slide = maxSlide * _animationController.value;
              // double scale = 1 - (_animationController.value * 0.3);
              return Stack(
                children: [
                  myDrawer,
                  Transform.translate(
                      offset: Offset(
                          maxSlide * (_animationController.value - 1), 0),
                      child: Transform(
                        transform: Matrix4.identity()
                          ..setEntry(3, 2, 0.001)
                          ..rotateY(
                              math.pi / 2 * (1 - _animationController.value)),
                        alignment: Alignment.centerRight,
                        child: myChild,
                      ))
                ],
              );
            }));
  }
}

/// Flutter code sample for [AnimatedAlign].

class AnimatedAlignExampleApp extends StatelessWidget {
  const AnimatedAlignExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('AnimatedAlign Sample')),
        body: const AnimatedAlignExample(),
      ),
    );
  }
}

class AnimatedAlignExample extends StatefulWidget {
  const AnimatedAlignExample({super.key});

  @override
  State<AnimatedAlignExample> createState() => _AnimatedAlignExampleState();
}

class _AnimatedAlignExampleState extends State<AnimatedAlignExample> {
  bool selected = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selected = !selected;
        });
      },
      child: Center(
        child: Container(
          width: 250.0,
          height: 250.0,
          color: Colors.red,
          child: AnimatedAlign(
            alignment: selected ? Alignment.topRight : Alignment.topLeft,
            duration: const Duration(seconds: 1),
            curve: Curves.fastOutSlowIn,
            child: const FlutterLogo(size: 50.0),
          ),
        ),
      ),
    );
  }
}

class AnimatedPositionedExampleApp extends StatelessWidget {
  const AnimatedPositionedExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('AnimatedPositioned Sample')),
        body: const Center(
          child: AnimatedPositionedExample(),
        ),
      ),
    );
  }
}

class AnimatedPositionedExample extends StatefulWidget {
  const AnimatedPositionedExample({super.key});

  @override
  State<AnimatedPositionedExample> createState() =>
      _AnimatedPositionedExampleState();
}

class _AnimatedPositionedExampleState extends State<AnimatedPositionedExample> {
  bool selected = false;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 400,
      height: 600,
      child: Stack(
        children: <Widget>[
          Image.asset('assets/images/pic0.png'),
          AnimatedPositioned(
            width: selected ? 400.0 : 50.0,
            height: selected ? 50.0 : 400.0,
            top: selected ? 0.0 : 0.0,
            duration: const Duration(seconds: 2),
            curve: Curves.fastOutSlowIn,
            child: GestureDetector(
              onTap: () {
                setState(() {
                  selected = !selected;
                });
              },
              child: const ColoredBox(
                color: Colors.blue,
                child: Center(child: Text('Tap me')),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
