import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class MenuEstados {
  final int id;
  final String title;
  String? bandeira;

  MenuEstados({
    required this.id,
    required this.title,
    this.bandeira,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'bandeira': bandeira,
    };
  }

  factory MenuEstados.fromJson(Map<String, dynamic> json) {
    return MenuEstados(
      id: int.parse(json['object_id'] as String),
      title: json['title'] as String,
      bandeira: json['bandeira'] as String,
    );
  }

  String toJson() => json.encode(toMap());
}
