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
