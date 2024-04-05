class Usuario {
  final int id;
  final String Nombre;
  final String Apellido;
  final String Email;
  final String Celular;
  final dynamic Status; // Cambiado a dynamic
  final dynamic Nivel; // Cambiado a dynamic

  const Usuario({
    required this.id,
    required this.Nombre,
    required this.Apellido,
    required this.Email,
    required this.Celular,
    required this.Status,
    required this.Nivel,
  });

  factory Usuario.fromJson(Map<String, dynamic> json) {
    return Usuario(
      id: json['id'] as int,
      Nombre: json['Nombre'] as String,
      Apellido: json['Apellido'] as String,
      Email: json['Email'] as String,
      Celular: json['Celular'] as String,
      Status:
          int.tryParse(json['Status'].toString()), // Intenta convertir a int
      Nivel: int.tryParse(json['Nivel'].toString()), // Intenta convertir a int
    );
  }
}
