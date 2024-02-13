import 'package:flutter/material.dart';


class ModificacionesPage extends StatefulWidget {
    const ModificacionesPage({super.key, required this.title});

    final String title;

    @override
    State<ModificacionesPage> createState() => _ModificacionesPageState();
}

class _ModificacionesPageState extends State<ModificacionesPage> {
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
        child: ListView(
            padding: const EdgeInsets.all(8),
            children: <Widget>[
                
            ]
        ),
        ),
    );
    }
}