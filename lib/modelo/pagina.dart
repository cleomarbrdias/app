class Pagina {
  final int id;
  final String title;
  final String materia;

  Pagina({required this.id, required this.title, required this.materia});

  factory Pagina.fromJson(Map<String, dynamic> json) {
    return Pagina(
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
    return 'Pagina{id: $id, title: $title, content: $materia}';
  }
}
