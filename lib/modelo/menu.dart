class Menu {
  final String id;
  final String slug;

  Menu({required this.id, required this.slug});

  factory Menu.fromJson(Map<String, dynamic> json) {
    //int res = json["object_id"].toString();
    return Menu(id: json["object_id"], slug: json["title"]);
  }
}
