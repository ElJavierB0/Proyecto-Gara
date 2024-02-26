import 'package:flutter/material.dart';
import 'Service.dart';
import 'Modificaciones.dart';
import 'Reparaciones.dart';

class JobsPage extends StatefulWidget {
  const JobsPage({super.key, required this.title});

  final String title;

  @override
  State<JobsPage> createState() => _JobsPageState();
}

class _JobsPageState extends State<JobsPage> {
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
        child: ListView(padding: const EdgeInsets.all(8), children: <Widget>[
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ServicesPage(title: 'Servicios'),
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
                    'Taller.jpeg',
                    width: MediaQuery.of(context).size.width,
                    height: 115,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Servicios',
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
                  builder: (context) =>
                      const ReparacionesPage(title: 'Reparaciones'),
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
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      const ModificacionesPage(title: 'Modificaciones'),
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
        ]),
      ),
    );
  }
}
