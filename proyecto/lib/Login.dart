import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import 'Register.dart';
import 'MyHomePage.dart';

Future<Map<String, dynamic>> fetchInicios(String email, String password) async {
  try {
    final response = await http.post(
      Uri.parse('http://127.0.0.1:8000/api/Login'),
      body: {
        'email': email,
        'password': password,
      },
    );

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      return jsonResponse;
    } else {
      throw Exception(
          'Failed to load Login. Status Code: ${response.statusCode}');
    }
  } catch (e) {
    print('Error during fetchInicios: $e');
    throw e;
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
      print('Fetching Inicio...');
      Map<String, dynamic> inicioData = await fetchInicios(email, password);

      final accessToken = inicioData['access_token'];
      final profile = inicioData['profile'];

      if (accessToken != null && profile != null) {
        // Guarda el accessToken utilizando SharedPreferences
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('accessToken', accessToken);
        await prefs.setString('profile',
            jsonEncode(profile)); // Guarda el perfil como una cadena JSON

        // Procede con la lógica de autenticación exitosa
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const MyHomePage(title: 'Inicio'),
          ),
        );
        return;
      } else {
        // Manejar la respuesta si falta información o si el inicio de sesión falla
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Inicio no registrado. Regístrate para acceder.'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      print('Error during checkCredentials: $e');
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
