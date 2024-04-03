class Servicios {
  final int id;
  final String Nombre;
  final String Tipo;
  final String Disponibilidad;
  final String Descripcion;

  const Servicios({
    required this.id,
    required this.Nombre,
    required this.Tipo,
    required this.Disponibilidad,
    required this.Descripcion,
  });

  factory Servicios.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'id': int id,
        'Nombre': String Nombre,
        'Tipo': String Tipo,
        'Disponibilidad': String Disponibilidad,
        'Descripcion': String Descripcion,
      } =>
        Servicios(
          id: id,
          Nombre: Nombre,
          Tipo: Tipo,
          Disponibilidad: Disponibilidad,
          Descripcion: Descripcion,
        ),
      _ => throw const FormatException('Error al cargar los servicios.'),
    };
  }
}
