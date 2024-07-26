class PostAgendaCit {
  final String title;
  final String dataAssembleia;
  final String dataCit;
  final String dataCns;

  PostAgendaCit({
    required this.title,
    required this.dataAssembleia,
    required this.dataCit,
    required this.dataCns,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'data_assembleia': dataAssembleia,
      'data_cit': dataCit,
      'data_cns': dataCns,
    };
  }

  factory PostAgendaCit.fromJson(Map<String, dynamic> json) {
    return PostAgendaCit(
      title: json['title']['rendered'] as String? ?? 'Título não disponível',
      dataAssembleia:
          json['meta']['data-assembleia'] as String? ?? 'Data não disponível',
      dataCit: json['meta']['data-cit'] as String? ?? 'Data não disponível',
      dataCns: json['meta']['data-cns'] as String? ?? 'Data não disponível',
    );
  }
}
