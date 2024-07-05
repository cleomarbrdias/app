class Menu {
  final int id;
  final String slug;

  Menu({required this.id, required this.slug});

  factory Menu.fromJson(Map<String, dynamic> json) {
    int res = int.parse(json["object_id"]);
    return Menu(id: res, slug: json["title"]);
  }
}
