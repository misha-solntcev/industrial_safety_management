import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TankScreen3 extends StatefulWidget {
  const TankScreen3({super.key});

  @override
  State<TankScreen3> createState() => _TankScreen3State();
}

class _TankScreen3State extends State<TankScreen3> {
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

  DateTime? _selectedDate; // Переменная для хранения выбранной даты
  final _formKey = GlobalKey<FormState>(); // Ключ для формы

  // Функция для отображения диалогового окна выбора даты
  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    ).then((pickedDate) {
      if (pickedDate == null) return;
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

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
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Image.asset('assets/images/pic0.png'),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return ListTile(
                  leading: const Icon(Icons.info),
                  title: Text(tank.keys.elementAt(index)),
                  subtitle: Text(tank.values.elementAt(index)),
                  trailing: IconButton(
                    icon: const Icon(Icons.more_vert),
                    onPressed: () => debugPrint('Нажали трейлинг $index'),
                  ),
                  onTap: () => debugPrint('Нажали ListTile $index'),
                );
              },
              childCount: tank.length,
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Наружный осмотр:',
                      style: TextStyle(fontSize: 16),
                    ),
                    const Text(
                      'Внутренний осмотр:',
                      style: TextStyle(fontSize: 16),
                    ),
                    const Text(
                      'Гидравлические испытания:',
                      style: TextStyle(fontSize: 16),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Выберите дату',
                            ),
                            readOnly: true,
                            controller: TextEditingController(
                              text: _selectedDate != null
                                  ? DateFormat('dd.MM.yyyy')
                                      .format(_selectedDate!)
                                  : '',
                            ),
                            onTap: _presentDatePicker,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Пожалуйста, выберите дату';
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              // Сохраняем дату в базу данных
                              // ...
                            }
                          },
                          child: const Text('Сохранить'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}