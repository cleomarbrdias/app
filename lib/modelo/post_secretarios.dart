class PostSecretarios {
  int? id;
  String? modified;
  String? estado;
  String? nome_do_secretario;
  final String foto_secretario;
  String? nome_da_secretaria;
  String? mini_curriculo;
  String? endereco_secretaria;
  String? telefone_gab;
  String? telefone_ascom;
  String? e_mail_gab;
  String? e_mail_ascom;
  String? site_da_ses;
  String? plano_estadual_de_saude;
  String? mapas_estrategicos_das_ses;
  final String bandeira;

  PostSecretarios({
    this.id,
    this.modified,
    this.estado,
    this.nome_do_secretario,
    required this.foto_secretario,
    this.nome_da_secretaria,
    this.mini_curriculo,
    this.endereco_secretaria,
    this.telefone_gab,
    this.telefone_ascom,
    this.e_mail_gab,
    this.e_mail_ascom,
    this.site_da_ses,
    this.plano_estadual_de_saude,
    this.mapas_estrategicos_das_ses,
    required this.bandeira,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'modified': modified,
      'estado': estado,
      'nome_do_secretario': nome_do_secretario,
      'foto_secretario': foto_secretario,
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
    };
  }

  factory PostSecretarios.fromJson(Map<String, dynamic> json) {
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
      foto_secretario: validarFotoEBandeira(json['meta']['foto-secretario']),
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
    );
  }

  static String validarFotoEBandeira(dynamic value) {
    if (value is String && value.isNotEmpty) {
      return value;
    }
    return "https://www.conass.org.br/padraoMobile/padrao.png"; // URL padrão
  }
}
