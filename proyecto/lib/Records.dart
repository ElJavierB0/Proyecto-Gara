import 'package:flutter/material.dart';

class RecordsPage extends StatefulWidget {
    const RecordsPage({super.key, required this.title});

    final String title;

    @override
    State<RecordsPage> createState() => _RecordsPageState();
}

class _RecordsPageState extends State<RecordsPage> {
    int _counter = 0;

    void _incrementCounter() {
    setState(() {
        _counter++;
    });
    }

    @override
    Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        backgroundColor: Colors.blueGrey.shade900, // Color del fondo
        title: Text(
          widget.title,
          style: TextStyle(color: Colors.yellow.shade800), // Color del texto
        ),
        ),
        body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
            const Text(
                'You have pushed the button this many times:',
            ),
            Text(
                '$_counter',
                style: Theme.of(context).textTheme.headlineMedium,
            ),
            ],
        ),
        ),
        floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
        ),
    );
    }
}