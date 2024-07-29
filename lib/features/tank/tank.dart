import 'package:flutter/material.dart';
import 'package:industrial_safety_management/core/db/data.dart';

class TankScreen extends StatefulWidget {
  const TankScreen({super.key});

  @override
  State<TankScreen> createState() => _TankScreenState();
}

class _TankScreenState extends State<TankScreen> {    
  final tank = data[0].items;

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
            Row(
              children: [
                CircleAvatar(
                  maxRadius: 130,
                  child: Image.asset('assets/images/pic0.png'),
                ),
                const Padding(
                  padding: EdgeInsets.all(16),
                  child: Text(
                      'Сосуд ППЦЗ 12-01.00 000 СБ \n \n Адрес: \n г. Братск, ул.Курчатова,16 \n'),
                )
              ],
            ),
            // SizedBox(
            //   width: 500,
            //   child: Image.asset('assets/images/pic0.png'),
            // ),
            Expanded(
                child: ListView.separated(
              shrinkWrap: true,
              padding: const EdgeInsets.all(8),
              itemCount: tank.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  leading: const Icon(Icons.info),
                  // title: Text(tank.keys.elementAt(index)),
                  // subtitle: Text(tank.values.elementAt(index)),
                  title: Text(tank[index].title),
                  subtitle: Text(tank[index].subtitle),
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
