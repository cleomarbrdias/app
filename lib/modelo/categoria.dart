class Categoria {
  final String nome_categoria;

  Categoria({required this.nome_categoria});

  factory Categoria.fromJson(Map<String, dynamic> json) {
    return Categoria(
      nome_categoria: json["name"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "nome_categoria": nome_categoria,
    };
  }
}
