import 'package:flutter/material.dart';

class AdminsPage extends StatefulWidget {
    const AdminsPage({super.key, required this.title});

    final String title;

    @override
    State<AdminsPage> createState() => _AdminsPageState();
}

class _AdminsPageState extends State<AdminsPage> {
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
                'Ya repruebelos profe',
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