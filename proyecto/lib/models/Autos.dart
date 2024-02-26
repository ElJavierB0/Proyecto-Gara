class Autos {
  final int id;
  final String Nombre;
  final String Estado;
  final String Imagen;
  final int Marca;

  const Autos({
    required this.id,
    required this.Nombre,
    required this.Estado,
    required this.Imagen,
    required this.Marca,
  });

  factory Autos.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'id': int id,
        'Nombre': String Nombre,
        'Estado': String Estado,
        'Imagen': String Imagen,
        'Marca': int Marca,
      } =>
        Autos(
            id: id,
            Nombre: Nombre,
            Estado: Estado,
            Imagen: Imagen,
            Marca: Marca),
      _ => throw const FormatException('Failed to load album.'),
    };
  }
}
