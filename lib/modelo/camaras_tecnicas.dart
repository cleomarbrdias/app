class CamarasTecnicas {
  final int id;
  final String title;
  final String sobre;
  final String apresentacao;
  final String membros;
  final String linksDocumentos;
  final String eventos;
  final String imageDestaque;

  CamarasTecnicas({
    required this.id,
    required this.title,
    required this.sobre,
    required this.apresentacao,
    required this.membros,
    required this.linksDocumentos,
    required this.eventos,
    required this.imageDestaque,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'sobre': sobre,
      'apresentacao': apresentacao,
      'membros': membros,
      'linksDocumentos': linksDocumentos,
      'eventos': eventos,
      'imageDestaque': imageDestaque,
    };
  }

  factory CamarasTecnicas.fromJson(Map<String, dynamic> json) {
    return CamarasTecnicas(
      id: json['id'] as int,
      title: json['title']['rendered'] as String? ?? '',
      sobre: json['meta']['sobre-as-camaras-tecnicas'] as String? ?? '',
      apresentacao: json['meta']['apresentacao'] as String? ?? '',
      membros: json['meta']['membros'] as String? ?? '',
      linksDocumentos: json['meta']['links-e-documentos'] as String? ?? '',
      eventos: json['meta']['eventos'] as String? ?? '',
      imageDestaque: json['featured_media_url'] as String? ?? '',
    );
  }
}
