class Category {
  final int id;
  final String Tipo;
  final String Detalles;

  const Category({
    required this.id,
    required this.Tipo,
    required this.Detalles,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'id': int id,
        'Tipo': String Tipo,
        'Detalles': String Detalles,
      } =>
        Category(
          id: id,
          Tipo: Tipo,
          Detalles: Detalles,
        ),
      _ => throw const FormatException('Failed to load Category.'),
    };
  }
}
