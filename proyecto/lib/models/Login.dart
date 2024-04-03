class Inicio {
  final String email;
  final String password;

  Inicio({
    required this.email,
    required this.password,
  });

  factory Inicio.fromJson(Map<String, dynamic> json) {
    return Inicio(
      email: json['email'],
      password: json['password'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
    };
  }
}
