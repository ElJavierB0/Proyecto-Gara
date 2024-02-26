class Brand {
  final int id;
  final String Nombre;
  final String Logo;
  final int Categoria;

  const Brand({
    required this.id,
    required this.Nombre,
    required this.Logo,
    required this.Categoria,
  });

  factory Brand.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'id': int id,
        'Nombre': String Nombre,
        'Logo': String Logo,
        'Categoria': int Categoria,
      } =>
        Brand(
          id: id,
          Nombre: Nombre,
          Logo: Logo,
          Categoria: Categoria,
        ),
      _ => throw const FormatException('Failed to load Brand.'),
    };
  }
}
