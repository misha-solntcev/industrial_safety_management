import 'package:flutter/material.dart';

class Example extends StatelessWidget {
  const Example({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: DataOwnerStatefull(),
      ),
    );
  }
}

class DataOwnerStatefull extends StatefulWidget {
  const DataOwnerStatefull({super.key});

  @override
  State<DataOwnerStatefull> createState() => _DataOwnerStatefullState();
}

class _DataOwnerStatefullState extends State<DataOwnerStatefull> {
  var _valueOne = 0;
  var _valueTwo = 0;

  void _incrementOne() {
    _valueOne += 1;
    setState(() {});
  }

  void _incrementTwo() {
    _valueTwo += 1;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: _incrementOne,
          child: const Text('Жми раз'),
        ),
        ElevatedButton(
          onPressed: _incrementTwo,
          child: const Text('Жми два'),
        ),
        DataProviderInherit(
            valueOne: _valueOne,
            valueTwo: _valueTwo,
            child: const DataConsumerStateless()),
      ],
    );
  }
}

class DataConsumerStateless extends StatelessWidget {
  const DataConsumerStateless({super.key});

  @override
  Widget build(BuildContext context) {
    final value = context
            .dependOnInheritedWidgetOfExactType<DataProviderInherit>(
                aspect: 'one')
            ?.valueOne ??
        0;
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('$value'),
          const DataConsumerStatefull(),
        ],
      ),
    );
  }
}

class DataConsumerStatefull extends StatefulWidget {
  const DataConsumerStatefull({super.key});

  @override
  State<DataConsumerStatefull> createState() => _DataConsumerStatefullState();
}

class _DataConsumerStatefullState extends State<DataConsumerStatefull> {
  @override
  Widget build(BuildContext context) {
    final value = context
            .dependOnInheritedWidgetOfExactType<DataProviderInherit>(
                aspect: 'two')
            ?.valueTwo ??
        0;
    return Text('$value');
  }
}

class DataProviderInherit extends InheritedModel<String> {
  final int valueOne;
  final int valueTwo;
  const DataProviderInherit(
      {super.key,
      required this.valueOne,
      required this.valueTwo,
      required super.child});

  @override
  bool updateShouldNotify(DataProviderInherit oldWidget) {
    return valueOne != oldWidget.valueOne || valueTwo != oldWidget.valueTwo;
  }

  @override
  bool updateShouldNotifyDependent(
      covariant DataProviderInherit oldWidget, Set<String> dependencies) {
    final isValueOneUpdated =
        valueOne != oldWidget.valueOne && dependencies.contains('one');
    final isValueTwoUpdated =
        valueTwo != oldWidget.valueTwo && dependencies.contains('two');
    return isValueOneUpdated || isValueTwoUpdated;
  }
}
