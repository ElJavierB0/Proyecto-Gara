import 'package:flutter/material.dart';
import 'package:proyecto/Historial.dart';
import 'package:proyecto/models/User.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'Car.dart';
import 'Job.dart';
import 'Login.dart';
import 'MyHomePage.dart';
import 'Remplacement.dart';
import 'Record.dart';
import 'User.dart';

Future<List<Usuario>> fetchUsuarios() async {
  final response =
      await http.get(Uri.parse('https://romo.terrabyteco.com/api/Users'));

  if (response.statusCode == 200) {
    Iterable jsonResponse = jsonDecode(response.body);
    List<Usuario> remplacements =
        jsonResponse.map((data) => Usuario.fromJson(data)).toList();
    return remplacements;
  } else {
    throw Exception('Failed to load Remplacements');
  }
}

class PersonaPage extends StatefulWidget {
  const PersonaPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<PersonaPage> createState() => _PersonaPageState();
}

class _PersonaPageState extends State<PersonaPage> {
  late Future<List<Usuario>> futureUsuarios;
  int _selectedIndex = 0;
  String? _userName;

  @override
  void initState() {
    super.initState();
    _loadUserName();
    futureUsuarios = fetchUsuarios();
  }

  Future<void> _loadUserName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userProfile = prefs.getString('profile');
    if (userProfile != null) {
      Map<String, dynamic> profileData = jsonDecode(userProfile);
      setState(() {
        _userName = profileData['name'];
      });
    } else {
      setState(() {
        _userName = '';
      });
    }
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
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blueGrey.shade900,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Menú',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Hola $_userName', // Aquí se muestra el nombre del usuario
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: Icon(Icons.garage),
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
              leading: Icon(Icons.directions_car),
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
              leading: Icon(Icons.build),
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
              leading: Icon(Icons.history),
              title: Text('Historial'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        const HistorialPage(title: 'Historial'),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.manage_accounts),
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
            Divider(),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Cerrar Sesión'),
              onTap: () {
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
      body: FutureBuilder<List<Usuario>>(
        future: futureUsuarios,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Text('No hay datos disponibles');
          }

          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final isEven = index.isEven;
              final cardColor =
                  isEven ? Colors.yellow.shade800 : Colors.blueGrey.shade900;
              final textColor =
                  isEven ? Colors.blueGrey.shade900 : Colors.yellow.shade800;
              return InkWell(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Center(
                          child: Text("Detalles de Remplacements"),
                        ),
                        content: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Image.asset(
                                'Taller.jpeg',
                                fit: BoxFit.cover,
                              ),
                              SizedBox(height: 8),
                              Row(
                                children: [
                                  Text(
                                    'Id: ',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Text(snapshot.data![index].id.toString()),
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    'Nombre: ',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    '${snapshot.data![index].Nombre} ${snapshot.data![index].Apellido}',
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    'Email: ',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Text(snapshot.data![index].Email),
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    'Celular: ',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Text(snapshot.data![index].Celular),
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    'Status: ',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Text(snapshot.data![index].Status.toString()),
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    'Nivel: ',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Text(snapshot.data![index].Nivel.toString()),
                                ],
                              ),
                              SizedBox(height: 4),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  ElevatedButton(
                                    onPressed: () {
                                      // Lógica para cerrar el AlertDialog
                                      Navigator.of(context).pop();
                                    },
                                    child: Text('Cerrar'),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  padding: EdgeInsets.all(8.0),
                  margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  decoration: BoxDecoration(
                    color: cardColor,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(
                        'Piezas.png',
                        width: double.infinity,
                        height: 150.0,
                        fit: BoxFit.cover,
                      ),
                      SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text(
                                'Id: ',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: textColor,
                                ),
                              ),
                              Text(
                                '${snapshot.data![index].id}',
                                style: TextStyle(color: textColor),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text(
                                'Nombre: ',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: textColor,
                                ),
                              ),
                              Text(
                                '${snapshot.data![index].Nombre} ${snapshot.data![index].Apellido}',
                                style: TextStyle(color: textColor),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text(
                                'Email: ',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: textColor,
                                ),
                              ),
                              Text(
                                '${snapshot.data![index].Email}',
                                style: TextStyle(color: textColor),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text(
                                'Celular: ',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: textColor,
                                ),
                              ),
                              Text(
                                '${snapshot.data![index].Celular}',
                                style: TextStyle(color: textColor),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text(
                                'Status: ',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: textColor,
                                ),
                              ),
                              Text(
                                '${snapshot.data![index].Status}',
                                style: TextStyle(color: textColor),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text(
                                'Nivel: ',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: textColor,
                                ),
                              ),
                              Text(
                                '${snapshot.data![index].Nivel}',
                                style: TextStyle(color: textColor),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'Usuarios',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Inicio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.post_add),
            label: 'Añadir',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.yellow.shade800,
        onTap: (int index) {
          setState(() {
            _selectedIndex = index;
          });
          switch (index) {
            case 0:
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PersonaPage(title: 'Usuarios'),
                ),
              );
              break;
            case 1:
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MyHomePage(title: 'Inicio'),
                ),
              );
              break;
            case 2:
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => RecordsPage(title: 'Realizar Pedido'),
                ),
              );
              break;
            default:
              break;
          }
        },
      ),
    );
  }
}
