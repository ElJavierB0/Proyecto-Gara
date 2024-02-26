import 'package:flutter/material.dart';

class UsersPage extends StatefulWidget {
  const UsersPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<UsersPage> createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  // Variables para los controladores de los campos del formulario
  TextEditingController nameController = TextEditingController();
  TextEditingController surnameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey.shade900,
        title: Text(
          widget.title,
          style: TextStyle(color: Colors.yellow.shade800),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Modificar datos:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            TextFormField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Nombre'),
            ),
            TextFormField(
              controller: surnameController,
              decoration: InputDecoration(labelText: 'Apellido'),
            ),
            TextFormField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Correo electrónico'),
            ),
            TextFormField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(labelText: 'Nueva contraseña'),
            ),
            TextFormField(
              controller: phoneController,
              decoration: InputDecoration(labelText: 'Número de Celular'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Aquí puedes simular alguna acción ficticia al presionar el botón
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Cambios guardados'),
                      content:
                          Text('Los cambios fueron guardados exitosamente.'),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text('OK'),
                        ),
                      ],
                    );
                  },
                );
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.blueGrey.shade900,
              ),
              child: Text(
                'Guardar cambios',
                style: TextStyle(color: Colors.yellow.shade800),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
