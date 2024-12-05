import 'package:flutter/material.dart';

void main() async {
  runApp(MaterialApp(home: CounterApp()));
}

class CounterProvider extends InheritedWidget {
  final int counter;
  final VoidCallback increment;

  const CounterProvider({super.key,
    required this.counter,
    required this.increment,
    required super.child,
  });

  @override
  bool updateShouldNotify(covariant CounterProvider oldWidget) {
    return oldWidget.counter != counter;
  }

  static CounterProvider? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<CounterProvider>();
  }
}

class CounterApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CounterAppState();
}

class _CounterAppState extends State<CounterApp> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return CounterProvider(
      counter: _counter,
      increment: _incrementCounter,
      child: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = CounterProvider.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text("Counter App")),
      body: Center(
        child: Text("Counter: ${provider?.counter}"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: provider?.increment,
        child: const Icon(Icons.add),
      ),
    );
  }
}
