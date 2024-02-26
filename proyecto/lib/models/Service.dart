class Servicios {
  final int id;
  final String Nombre;
  final String Tipo;
  final String Disponibilidad;

  const Servicios({
    required this.id,
    required this.Nombre,
    required this.Tipo,
    required this.Disponibilidad,
  });

  factory Servicios.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'id': int id,
        'Nombre': String Nombre,
        'Tipo': String Tipo,
        'Disponibilidad': String Disponibilidad,
      } =>
        Servicios(
          id: id,
          Nombre: Nombre,
          Tipo: Tipo,
          Disponibilidad: Disponibilidad,
        ),
      _ => throw const FormatException('Failed to load album.'),
    };
  }
}
