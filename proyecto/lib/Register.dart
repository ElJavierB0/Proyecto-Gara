import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'MyHomePage.dart';
import 'Login.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor:
            Colors.blueGrey.shade900, // Cambiar el color del app bar
        title: Text(
          widget.title,
          style: TextStyle(
              color: Colors
                  .yellow.shade800), // Cambiar el color del texto del título
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Crea una cuenta',
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.yellow.shade800),
              ),
              SizedBox(height: 20),
              // Campos de entrada para el registro
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: 'Nombre',
                  labelStyle: TextStyle(
                      color: Colors.yellow
                          .shade800), // Cambiar el color del texto del label
                ),
              ),
              TextFormField(
                controller: usernameController,
                decoration: InputDecoration(
                  labelText: 'Apellido',
                  labelStyle: TextStyle(
                      color: Colors.yellow
                          .shade800), // Cambiar el color del texto del label
                ),
              ),
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: 'Correo electrónico',
                  labelStyle: TextStyle(
                      color: Colors.yellow
                          .shade800), // Cambiar el color del texto del label
                ),
              ),
              TextFormField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Contraseña',
                  labelStyle: TextStyle(
                      color: Colors.yellow
                          .shade800), // Cambiar el color del texto del label
                ),
              ),
              TextFormField(
                controller: phoneController,
                decoration: InputDecoration(
                  labelText: 'Número de Celular',
                  labelStyle: TextStyle(
                      color: Colors.yellow
                          .shade800), // Cambiar el color del texto del label
                ),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () async {
                  // Validar que no haya campos vacíos
                  if (nameController.text.isEmpty ||
                      usernameController.text.isEmpty ||
                      emailController.text.isEmpty ||
                      passwordController.text.isEmpty ||
                      phoneController.text.isEmpty) {
                    // Mostrar un mensaje de error si hay campos vacíos
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Por favor, completa todos los campos.'),
                        backgroundColor: Colors.red,
                      ),
                    );
                  } else {
                    // Crear un mapa con los datos del usuario
                    Map<String, dynamic> userData = {
                      'name': nameController.text,
                      'surname': usernameController.text,
                      'email': emailController.text,
                      'phone': phoneController.text,
                      'password': passwordController.text,
                    };

                    // Convertir el mapa a JSON
                    String jsonData = jsonEncode(userData);

                    // Enviar los datos a la API
                    final response = await http.post(
                      Uri.parse('http://127.0.0.1:8000/api/Users/create'),
                      headers: {'Content-Type': 'application/json'},
                      body: jsonData,
                    );

                    // Analizar la respuesta
                    if (response.statusCode == 200) {
                      // Navegar a la página de inicio una vez que el registro sea exitoso
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MyHomePage(title: 'Inicio'),
                        ),
                      );
                    } else {
                      // Mostrar un mensaje de error si algo salió mal
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                              'Error en el registro. Por favor, intenta de nuevo.'),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  }
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                      Colors.blueGrey.shade900), // Cambiar el color del botón
                  padding: MaterialStateProperty.all(
                      EdgeInsets.symmetric(horizontal: 20, vertical: 20)),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  )),
                ),
                child: Container(
                  width: double.infinity,
                  alignment: Alignment.center,
                  child: Text(
                    'Registrarme',
                    style: TextStyle(
                        color: Colors.yellow
                            .shade800), // Cambiar el color del texto del botón
                  ),
                ),
              ),
              SizedBox(height: 16),
              TextButton(
                onPressed: () {
                  // Navegar de regreso a la página de inicio de sesión
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginPage(title: 'Login'),
                    ),
                  );
                },
                style: TextButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                ),
                child: Container(
                  width: double.infinity,
                  alignment: Alignment.center,
                  child: Text(
                    'Regresar a inicio de sesión',
                    style: TextStyle(
                        color: Colors.yellow
                            .shade800), // Cambiar el color del texto del botón
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
