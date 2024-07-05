class Pagina {
  final String title;
  final String materia;

  Pagina({required this.title, required this.materia});

  factory Pagina.fromJson(Map<String, dynamic> json) {
    return Pagina(
      title: json["title"]["rendered"],
      materia: json["content"]["rendered"],
    );
  }
}
