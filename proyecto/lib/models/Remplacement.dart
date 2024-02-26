class Remplacement {
  final int id;
  final String name;
  final String type;
  final String description;
  final int price;
  final String img;

  const Remplacement({
    required this.id,
    required this.name,
    required this.type,
    required this.description,
    required this.price,
    required this.img,
  });

  factory Remplacement.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'id': int id,
        'name': String name,
        'type': String type,
        'description': String description,
        'price': int price,
        'img': String img,
      } =>
        Remplacement(
            id: id,
            name: name,
            type: type,
            description: description,
            price: price,
            img: img),
      _ => throw const FormatException('Failed to load Remplacement.'),
    };
  }
}
