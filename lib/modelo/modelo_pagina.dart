class ModeloPagina {
  final int id;
  final String title;
  final String materia;

  ModeloPagina({required this.id, required this.title, required this.materia});

  factory ModeloPagina.fromJson(Map<String, dynamic> json) {
    return ModeloPagina(
      id: json["id"] ?? 0,
      title: json["title"]["rendered"] ?? '',
      materia: json["content"]["rendered"] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "title": title,
      "materia": materia,
    };
  }

  @override
  String toString() {
    return 'ModeloPagina{id: $id, title: $title, content: $materia}';
  }
}
