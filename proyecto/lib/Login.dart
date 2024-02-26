import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:proyecto/models/User.dart';

import 'dart:async';
import 'dart:convert';
import 'Register.dart';
import 'MyHomePage.dart';

Future<List<Usuario>> fetchUsuarios() async {
  final response = await http.get(Uri.parse('http://127.0.0.1:8000/api/Users'));

  if (response.statusCode == 200) {
    Iterable jsonResponse = jsonDecode(response.body);
    List<Usuario> usuarios =
        jsonResponse.map((data) => Usuario.fromJson(data)).toList();
    return usuarios;
  } else {
    throw Exception('Failed to load Usuarios');
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.blueGrey.shade900,
        title: Text(
          widget.title,
          style: TextStyle(color: Colors.yellow.shade800),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Inicio de Sesión',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.yellow.shade800,
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: 'Correo electrónico',
                  labelStyle: TextStyle(
                    color: Colors.yellow.shade800,
                  ),
                ),
              ),
              SizedBox(height: 12),
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Contraseña',
                  labelStyle: TextStyle(
                    color: Colors.yellow.shade800,
                  ),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (emailController.text.isEmpty ||
                      passwordController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Por favor, completa todos los campos.'),
                        backgroundColor: Colors.red,
                      ),
                    );
                  } else {
                    checkCredentials(
                        emailController.text, passwordController.text);
                  }
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.blueGrey.shade900,
                ),
                child: Text('Iniciar Sesión',
                    style: TextStyle(color: Colors.yellow.shade800)),
              ),
              SizedBox(height: 16),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          const RegisterPage(title: 'Registro'),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.blueGrey.shade900,
                ),
                child: Text(
                  '¿No tienes una cuenta? Regístrate',
                  style: TextStyle(color: Colors.yellow.shade800),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> checkCredentials(String email, String password) async {
    try {
      List<Usuario> usuarios = await fetchUsuarios();

      for (Usuario usuario in usuarios) {
        if (usuario.Email == email && usuario.Password == password) {
          if (usuario.Status == 3 && usuario.Nivel == 3) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const MyHomePage(title: 'Inicio'),
              ),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Permiso denegado. Contacta al administrador.'),
                backgroundColor: Colors.red,
              ),
            );
          }

          return;
        }
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Usuario no registrado. Regístrate para acceder.'),
          backgroundColor: Colors.red,
        ),
      );
    } catch (e) {
      print('Error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content:
              Text('Error al verificar las credenciales. Inténtalo de nuevo.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}
