import 'package:flutter/material.dart';
import 'Car.dart';
import 'Remplacement.dart';
import 'Job.dart';
import 'Login.dart';
import 'User.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tu Aplicación',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Inicio'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey.shade900,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                widget.title,
                style: TextStyle(color: Colors.yellow.shade800),
              ),
            ),
          ],
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blueGrey.shade900,
              ),
              child: Text(
                'Menú',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.garage), // Icono de Trabajos
              title: Text('Trabajos'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const JobsPage(title: 'Trabajos'),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.directions_car), // Icono de Carros
              title: Text('Carros'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CarsPage(title: 'Carros'),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.build), // Icono de Refacciones
              title: Text('Refacciones'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        const RemplacementPage(title: 'Refacciones'),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.manage_accounts), // Icono de Cuenta
              title: Text('Cuenta'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const UsersPage(title: 'Cuenta'),
                  ),
                );
              },
            ),
            Divider(), // Línea divisoria
            ListTile(
              leading: Icon(Icons.logout), // Icono para cerrar sesión
              title: Text('Cerrar Sesión'),
              onTap: () {
                // Aquí puedes agregar lógica para cerrar sesión
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginPage(title: 'Login'),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: ListView(
          padding: const EdgeInsets.all(8),
          children: <Widget>[
            // ... Tu contenido actual
          ],
        ),
      ),
    );
  }
}
