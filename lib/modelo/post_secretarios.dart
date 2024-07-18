import 'package:conass/servicos/api_featuredmedia.dart';

class PostSecretarios {
  final int id;
  final String modified;
  final String estado;
  final String nome_do_secretario;
  final String nome_da_secretaria;
  final String mini_curriculo;
  final String endereco_secretaria;
  final String telefone_gab;
  final String telefone_ascom;
  final String e_mail_gab;
  final String e_mail_ascom;
  final String site_da_ses;
  final String plano_estadual_de_saude;
  final String mapas_estrategicos_das_ses;
  final String bandeira;
  final String imageDestaque;

  PostSecretarios(
      {required this.id,
      required this.modified,
      required this.estado,
      required this.nome_do_secretario,
      required this.nome_da_secretaria,
      required this.mini_curriculo,
      required this.endereco_secretaria,
      required this.telefone_gab,
      required this.telefone_ascom,
      required this.e_mail_gab,
      required this.e_mail_ascom,
      required this.site_da_ses,
      required this.plano_estadual_de_saude,
      required this.mapas_estrategicos_das_ses,
      required this.bandeira,
      required this.imageDestaque});

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'modified': modified,
      'estado': estado,
      'nome_do_secretario': nome_do_secretario,
      'nome_da_secretaria': nome_da_secretaria,
      'mini_curriculo': mini_curriculo,
      'endereco_secretaria': endereco_secretaria,
      'telefone_gab': telefone_gab,
      'telefone_ascom': telefone_ascom,
      'e_mail_gab': e_mail_gab,
      'e_mail_ascom': e_mail_ascom,
      'site_da_ses': site_da_ses,
      'plano_estadual_de_saude': plano_estadual_de_saude,
      'mapas_estrategicos_das_ses': mapas_estrategicos_das_ses,
      'bandeira': bandeira,
      'imageDestaque': imageDestaque,
    };
  }

  factory PostSecretarios.fromJson(Map<String, dynamic> json) {
    //chamada para carregar os dados da imagem

    final String resImg = (json["featured_media_url"] as String? ?? "").isEmpty
        ? "https://www.conass.org.br/padraoMobile/padrao.png"
        : json["featured_media_url"];

    String parseString(dynamic value) {
      if (value is String && value.isNotEmpty) {
        return value;
      }
      return " "; // Retorno padrão para outros campos
    }

    return PostSecretarios(
      id: json['id'] as int,
      modified: parseString(json['modified']),
      estado: parseString(json['meta']['estado']),
      nome_do_secretario: parseString(json['meta']['nome-do-secretario']),
      nome_da_secretaria: parseString(json['meta']['nome-da-secretaria']),
      mini_curriculo: parseString(json['meta']['mini-curriculo']),
      endereco_secretaria: parseString(json['meta']['endereco-secretaria']),
      telefone_gab: parseString(json['meta']['telefone-gab']),
      telefone_ascom: parseString(json['meta']['telefone-ascom']),
      e_mail_gab: parseString(json['meta']['e-mail-gab']),
      e_mail_ascom: parseString(json['meta']['e-mail-ascom']),
      site_da_ses: parseString(json['meta']['site-da-ses']),
      plano_estadual_de_saude:
          parseString(json['meta']['plano-estadual-de-saude']),
      mapas_estrategicos_das_ses:
          parseString(json['meta']['mapas-estrategicos-das-ses']),
      bandeira: validarFotoEBandeira(json['meta']['bandeira']),
      imageDestaque: resImg,
    );
  }

  static String validarFotoEBandeira(dynamic value) {
    if (value is String && value.isNotEmpty) {
      return value;
    }
    return "https://www.conass.org.br/padraoMobile/padrao.png"; // URL padrão
  }
}
