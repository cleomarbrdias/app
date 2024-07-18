import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Featuredmedia {
  final int id;
  final String guid;
  String? title;
  Featuredmedia({
    required this.id,
    required this.guid,
    this.title,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'guid': guid,
      'title': title,
    };
  }

  factory Featuredmedia.fromJson(Map<String, dynamic> json) {
    String cleanText(String text) {
      return text
          .replaceAll(RegExp(r'<[^>]*>'), '')
          .replaceAll('Leia Mais..', '')
          .replaceAll('&nbsp; ', '')
          .replaceAll('&#8221;', '')
          .replaceAll('&#8220;', '')
          .replaceAll('&#8211;', '')
          .replaceAll('1 &#8211;', '')
          .replaceAll('[&hellip;]', '')
          .replaceAll('&#8230;', '...')
          .replaceAll('&#8230:', '...')
          .replaceAll('&#8230', '...');
    }

    final String resTitle = json['title']['rendered'] != null
        ? cleanText(json['title']['rendered'])
        : '';

    final String resImg = (json["guid"]["rendered"] as String? ?? "").isEmpty
        ? "https://www.conass.org.br/padraoMobile/padrao.png"
        : json["guid"]["rendered"];

    return Featuredmedia(id: json['id'] as int, guid: resImg, title: resTitle);
  }
}
