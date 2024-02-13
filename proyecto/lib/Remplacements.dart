import 'package:flutter/material.dart';

class RemplacementsPage extends StatefulWidget {
    const RemplacementsPage({super.key, required this.title});

    final String title;

    @override
    State<RemplacementsPage> createState() => _RemplacementsPageState();
}

class _RemplacementsPageState extends State<RemplacementsPage> {
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
            InkWell(
                child: Container(
                height: 150, 
                color: Colors.yellow.shade800,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                    Image.asset(
                        'Taller.jpeg',
                        width: MediaQuery.of(context).size.width, 
                        height: 115, 
                        fit: BoxFit.cover, 
                    ),
                    SizedBox(height: 8),
                    Text(
                        'Servicios Precio:1500',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                        ),
                        ),
                    ],
                    ),
                ),
                ),
                InkWell(
                child: Container(
                height: 150, 
                color: Colors.yellow.shade800,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                    Image.asset(
                        'Marcas.png',
                        width: MediaQuery.of(context).size.width, 
                        height: 115, 
                        fit: BoxFit.cover, 
                    ),
                    SizedBox(height: 8),
                    Text(
                        'Reparaciones',
                        style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        ),
                    ),
                    ],
                ),
                ),
                ),
                InkWell(
                child: Container(
                height: 150, 
                color: Colors.yellow.shade800,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                    Image.asset(
                        'Taller.jpeg',
                        width: MediaQuery.of(context).size.width, 
                        height: 115, 
                        fit: BoxFit.cover, 
                    ),
                    SizedBox(height: 8),
                    Text(
                        'Modificaciones',
                        style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        ),
                    ),
                    ],
                ),
                ),
                ),
                InkWell(
                child: Container(
                height: 150, 
                color: Colors.yellow.shade800,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                    Image.asset(
                        'Marcas.png',
                        width: MediaQuery.of(context).size.width, 
                        height: 115, 
                        fit: BoxFit.cover, 
                    ),
                    SizedBox(height: 8),
                    Text(
                        'Carros',
                        style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        ),
                    ),
                    ],
                ),
                ),
                ),
                InkWell(
                child: Container(
                height: 150, 
                color: Colors.yellow.shade800,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                    Image.asset(
                        'Taller.jpeg',
                        width: MediaQuery.of(context).size.width, 
                        height: 115, 
                        fit: BoxFit.cover, 
                    ),
                    SizedBox(height: 8),
                    Text(
                        'Motos',
                        style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        ),
                    ),
                    ],
                ),
                ),
                ),
                InkWell(
                child: Container(
                height: 150, 
                color: Colors.yellow.shade800,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                    Image.asset(
                        'Marcas.png',
                        width: MediaQuery.of(context).size.width, 
                        height: 115, 
                        fit: BoxFit.cover, 
                    ),
                    SizedBox(height: 8),
                    Text(
                        'Patinetas',
                        style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        ),
                    ),
                    ],
                ),
                ),
                ),
                InkWell(
                child: Container(
                height: 150, 
                color: Colors.yellow.shade800,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                    Image.asset(
                        'Taller.jpeg',
                        width: MediaQuery.of(context).size.width, 
                        height: 115, 
                        fit: BoxFit.cover, 
                    ),
                    SizedBox(height: 8),
                    Text(
                        'Skoter',
                        style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        ),
                    ),
                    ],
                ),
                ),
                ),
                InkWell(
                child: Container(
                height: 150, 
                color: Colors.yellow.shade800,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                    Image.asset(
                        'Marcas.png',
                        width: MediaQuery.of(context).size.width, 
                        height: 115, 
                        fit: BoxFit.cover, 
                    ),
                    SizedBox(height: 8),
                    Text(
                        'Compact',
                        style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        ),
                    ),
                    ],
                ),
                ),
                ),
                InkWell(
                child: Container(
                height: 150, 
                color: Colors.yellow.shade800,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                    Image.asset(
                        'Taller.jpeg',
                        width: MediaQuery.of(context).size.width, 
                        height: 115, 
                        fit: BoxFit.cover, 
                    ),
                    SizedBox(height: 8),
                    Text(
                        'Suburban',
                        style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        ),
                    ),
                    ],
                ),
                ),
                ),
                InkWell(
                child: Container(
                height: 150, 
                color: Colors.yellow.shade800,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                    Image.asset(
                        'Marcas.png',
                        width: MediaQuery.of(context).size.width, 
                        height: 115, 
                        fit: BoxFit.cover, 
                    ),
                    SizedBox(height: 8),
                    Text(
                        'Bicicleta',
                        style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        ),
                    ),
                    ],
                ),
                ),
                ),
                InkWell(
                child: Container(
                height: 150, 
                color: Colors.yellow.shade800,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                    Image.asset(
                        'Taller.jpeg',
                        width: MediaQuery.of(context).size.width, 
                        height: 115, 
                        fit: BoxFit.cover, 
                    ),
                    SizedBox(height: 8),
                    Text(
                        'Mini',
                        style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        ),
                    ),
                    ],
                ),
                ),
                ),
                InkWell(
                child: Container(
                height: 150, 
                color: Colors.yellow.shade800,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                    Image.asset(
                        'Marcas.png',
                        width: MediaQuery.of(context).size.width, 
                        height: 115, 
                        fit: BoxFit.cover, 
                    ),
                    SizedBox(height: 8),
                    Text(
                        'Camioneta',
                        style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        ),
                    ),
                    ],
                ),
                ),
                ),
                InkWell(
                child: Container(
                height: 150, 
                color: Colors.yellow.shade800,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                    Image.asset(
                        'Taller.jpeg',
                        width: MediaQuery.of(context).size.width, 
                        height: 115, 
                        fit: BoxFit.cover, 
                    ),
                    SizedBox(height: 8),
                    Text(
                        'Limosina',
                        style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        ),
                    ),
                    ],
                ),
                ),
                ),
                InkWell(
                child: Container(
                height: 150, 
                color: Colors.yellow.shade800,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                    Image.asset(
                        'Marcas.png',
                        width: MediaQuery.of(context).size.width, 
                        height: 115, 
                        fit: BoxFit.cover, 
                    ),
                    SizedBox(height: 8),
                    Text(
                        'Bus',
                        style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        ),
                    ),
                    ],
                ),
                ),
                ),
                InkWell(
                child: Container(
                height: 150, 
                color: Colors.yellow.shade800,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                    Image.asset(
                        'Marcas.png',
                        width: MediaQuery.of(context).size.width, 
                        height: 115, 
                        fit: BoxFit.cover, 
                    ),
                    SizedBox(height: 8),
                    Text(
                        'Triciclo',
                        style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        ),
                    ),
                    ],
                ),
                ),
                ),
                InkWell(
                child: Container(
                height: 150, 
                color: Colors.yellow.shade800,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                    Image.asset(
                        'Taller.jpeg',
                        width: MediaQuery.of(context).size.width, 
                        height: 115, 
                        fit: BoxFit.cover, 
                    ),
                    SizedBox(height: 8),
                    Text(
                        'Cuatri',
                        style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        ),
                    ),
                    ],
                ),
                ),
                ),
                InkWell(
                child: Container(
                height: 150, 
                color: Colors.yellow.shade800,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                    Image.asset(
                        'Marcas.png',
                        width: MediaQuery.of(context).size.width, 
                        height: 115, 
                        fit: BoxFit.cover, 
                    ),
                    SizedBox(height: 8),
                    Text(
                        'Tanques',
                        style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        ),
                    ),
                    ],
                ),
                ),
                ),
            ]
        ),
        ),
    );
    }
}