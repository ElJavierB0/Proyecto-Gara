import 'package:flutter/material.dart';
import 'Register.dart';
import 'MyHomePage.dart';

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
        backgroundColor: Colors.blueGrey.shade900, // Color del fondo
        title: Text(
            widget.title,
            style: TextStyle(color: Colors.yellow.shade800), // Color del texto
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
                  color: Colors.yellow.shade800, // Color del texto
                ),
                ),
                SizedBox(height: 20),
                TextField(
                controller: emailController,
                decoration: InputDecoration(
                    labelText: 'Correo electrónico',
                    labelStyle: TextStyle(color: Colors.yellow.shade800), // Color del texto del label
                ),
                ),
                SizedBox(height: 12),
                TextField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                    labelText: 'Contraseña',
                  labelStyle: TextStyle(color: Colors.yellow.shade800), // Color del texto del label
                ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                onPressed: () {
                  // Validar que los campos no estén vacíos
                    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
                    // Mostrar un mensaje de error si los campos están vacíos
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                        content: Text('Por favor, completa todos los campos.'),
                        backgroundColor: Colors.red, // Color del fondo del SnackBar
                        ),
                    );
                    } else {
                    // Verificar si los datos ingresados son correctos
                    if (emailController.text == 'javier@gmail.com' && passwordController.text == '12345') {
                      // Lógica de inicio de sesión exitosa
                        Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const MyHomePage(title: 'Inicio'),
                        ),
                        );
                    } else {
                      // Mostrar un mensaje de datos incorrectos
                        ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            content: Text('Correo o contraseña incorrectos. Inténtalo de nuevo.'),
                            backgroundColor: Colors.red, // Color del fondo del SnackBar
                        ),
                        );
                    }
                    }
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.blueGrey.shade900, // Color del fondo del botón
                ),
                child: Text('Iniciar Sesión', style: TextStyle(color: Colors.yellow.shade800)), // Color del texto del botón
                ),
                SizedBox(height: 16),
                TextButton(
                onPressed: () {
                  // Navegar a la página de registro
                    Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const RegisterPage(title: 'Registro'),
                    ),
                    );
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.blueGrey.shade900, // Color del fondo del botón
                ),
                child: Text('¿No tienes una cuenta? Regístrate', style: TextStyle(color: Colors.yellow.shade800), // Color del texto
                ),
                ),
            ],
            ),
        ),
        ),
    );
    }
}
