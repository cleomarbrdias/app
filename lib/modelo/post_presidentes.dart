import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class PostPresidentes {
  final int id;
  String? title;
  String? anoDeGestao;
  final String bandeira;
  String? nomeEstado;
  final String imageDestaque;
  PostPresidentes({
    required this.id,
    this.title,
    this.anoDeGestao,
    required this.bandeira,
    this.nomeEstado,
    required this.imageDestaque,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'anoDeGestao': anoDeGestao,
      'bandeira': bandeira,
      'nomeEstado': nomeEstado,
      'imageDestaque': imageDestaque,
    };
  }

  factory PostPresidentes.fromJson(Map<String, dynamic> json) {
    final String resImg = (json['meta']["bandeira"] as String? ?? "").isEmpty
        ? "https://www.conass.org.br/padraoMobile/padrao.png"
        : json['meta']["bandeira"];

    final String resDest =
        (json["featured_media_details"]["url"] as String? ?? "").isEmpty
            ? "https://www.conass.org.br/padraoMobile/padrao.png"
            : json["featured_media_details"]["url"];

    String parseString(dynamic value) {
      if (value is String && value.isNotEmpty) {
        return value;
      }
      return " "; // Retorno padrão para outros campos
    }

    // final List<String> NomeEstadoList =
    //     List<String>.from(json["nomeEstado"] ?? []);
    // final String? firstNomeEstado =
    //     NomeEstadoList.isNotEmpty ? NomeEstadoList.first : null;

    return PostPresidentes(
      id: json['id'] as int,
      title: parseString(json['title']['rendered']),
      anoDeGestao: parseString(json['meta']['ano-de-gestao']),
      bandeira: resImg,
      nomeEstado: parseString(json['meta']['estado']),
      imageDestaque: resDest,
    );
  }
}
