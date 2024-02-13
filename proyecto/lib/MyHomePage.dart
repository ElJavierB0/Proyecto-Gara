import 'package:flutter/material.dart';
import 'Admins.dart';
import 'Brands.dart';
import 'Cars.dart';
import 'Categories.dart';
import 'Employees.dart';
import 'Records.dart';
import 'Remplacements.dart';
import 'Jobs.dart';
import 'Users.dart';
import 'Services.dart';
import 'Modificaciones.dart';
import 'Reparaciones.dart';
import 'Autos.dart';
import 'Login.dart';



class MyHomePage extends StatefulWidget {
    const MyHomePage({super.key, required this.title});

    final String title;

    @override
    State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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
        automaticallyImplyLeading: false,
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
                onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                    builder: (context) => const JobsPage(title: 'Trabajos'),
                    ),
                );
                },
                child: Container(
                height: 150, 
                color: Colors.cyan.shade800,
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
                        'Trabajos',
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
                onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                    builder: (context) => const CarsPage(title: 'Carros'),
                    ),
                );
                },
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
                onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                    builder: (context) => const RemplacementsPage(title: 'Refacciones'),
                    ),
                );
                },
                child: Container(
                height: 150, 
                color: Colors.cyan.shade800,
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
                        'Refacciones',
                        style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        ),
                    ),
                    ],
                ),
                ),
                ),
            ],
        ),
        ),
        floatingActionButton:Tooltip( 
        message: 'Cerrar Sesión',
            child: FloatingActionButton(
        onPressed: () {
            // Navegar a la página de inicio de sesión
            Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => LoginPage(title: 'Login'),
            ),
            );
        },
        backgroundColor: Colors.blueGrey.shade900, // Color del fondo del botón flotante
        elevation: 5.0, // Elevación de la sombra
        child: Icon(Icons.login, color: Colors.yellow.shade800), // No es necesario usar const aquí
        ),
        ),
    );
    }
}