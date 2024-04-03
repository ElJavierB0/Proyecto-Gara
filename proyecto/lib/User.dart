import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert'; // Importa la biblioteca dart:convert

class UsersPage extends StatefulWidget {
  const UsersPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<UsersPage> createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  late SharedPreferences _prefs;
  late Map<String, dynamic> _profileData;
  String? _accessToken; // Cambia _accessToken a nullable
  bool _editingMode = false;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    _prefs = await SharedPreferences.getInstance();
    setState(() {
      _accessToken = _prefs.getString(
          'accessToken'); // No es necesario el operador ?? en este caso
      _profileData = Map<String, dynamic>.from(
          jsonDecode(_prefs.getString('profile') ?? '{}'));
    });
  }

  void _toggleEditingMode() {
    setState(() {
      _editingMode = !_editingMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey.shade900,
        title: Text(
          'Datos de Usuario',
          style: TextStyle(color: Colors.yellow.shade800),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Primera fila con la imagen del usuario
          Padding(
            padding: EdgeInsets.all(16.0),
            child: CircleAvatar(
              radius: 50,
              // Aquí cargas la imagen del usuario desde la URL proporcionada por la base de datos
              backgroundImage: NetworkImage(_profileData['Imagen'] ?? ''),
            ),
          ),
          // Segunda fila con los datos y botones
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Datos de Perfil:',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.yellow.shade800,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Nombre: ${_profileData['name'] ?? 'N/A'} ${_profileData['surname'] ?? 'N/A'}',
                    style: TextStyle(
                        fontSize: 16, color: Colors.blueGrey.shade900),
                  ),
                  Text(
                    'Email: ${_profileData['email'] ?? 'N/A'}',
                    style: TextStyle(
                        fontSize: 16, color: Colors.blueGrey.shade900),
                  ),
                  Text(
                    'Celular: ${_profileData['phone'] ?? 'N/A'}',
                    style: TextStyle(
                        fontSize: 16, color: Colors.blueGrey.shade900),
                  ),
                  // Agrega más campos según sea necesario
                  SizedBox(height: 16),
                  _editingMode
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                // Acción para guardar los cambios
                                _toggleEditingMode();
                              },
                              style: ElevatedButton.styleFrom(
                                primary: Colors.blueGrey.shade900,
                              ),
                              child: Text(
                                'Guardar',
                                style: TextStyle(color: Colors.yellow.shade800),
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                // Acción para cancelar la edición
                                _toggleEditingMode();
                              },
                              style: ElevatedButton.styleFrom(
                                primary: Colors.blueGrey.shade900,
                              ),
                              child: Text(
                                'Cancelar',
                                style: TextStyle(color: Colors.yellow.shade800),
                              ),
                            ),
                          ],
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              onPressed: _toggleEditingMode,
                              style: ElevatedButton.styleFrom(
                                primary: Colors.blueGrey.shade900,
                              ),
                              child: Text(
                                'Editar',
                                style: TextStyle(color: Colors.yellow.shade800),
                              ),
                            ),
                          ],
                        ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
