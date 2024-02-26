class Usuario {
  final int id;
  final String Nombre;
  final String Apellido;
  final String Email;
  final String Celular;
  final String Password;
  final int Status;
  final int Nivel;
  final String Imagen;

  const Usuario({
    required this.id,
    required this.Nombre,
    required this.Apellido,
    required this.Email,
    required this.Celular,
    required this.Password,
    required this.Status,
    required this.Nivel,
    required this.Imagen,
  });

  factory Usuario.fromJson(Map<String, dynamic> json) {
    return Usuario(
      id: json['id'] as int,
      Nombre: json['Nombre'] as String,
      Apellido: json['Apellido'] as String,
      Email: json['Email'] as String,
      Celular: json['Celular'] as String,
      Password: json['Password'] as String,
      Status: json['Status'] as int,
      Nivel: json['Nivel'] as int,
      Imagen: json['Imagen'] as String,
    );
  }
}
