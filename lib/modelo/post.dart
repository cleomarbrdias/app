class Post {
  final String id;
  final String title;
  String? resumo;
  String? materia;
  final String img;
  String? link;
  String? nCategoria;
  String? linkPdf;
  String? linkEbook;
  final String data;
  String? categoria;
  List<String>? categoriaList;

  Post({
    required this.id,
    required this.title,
    this.resumo,
    this.materia,
    required this.img,
    this.link,
    this.nCategoria,
    this.linkPdf,
    this.linkEbook,
    required this.data,
    this.categoria,
    this.categoriaList,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    // final String resImg =
    //     (json["featured_media_details"]["url"] as String? ?? "").isEmpty
    //         ? "https://www.conass.org.br/padraoMobile/padrao.png"
    //         : (json["featured_media_details"]["url"]);

    String resImg = "https://www.conass.org.br/padraoMobile/padrao.png";

    if (json["featured_media_details"] != false &&
        json["featured_media_details"]["url"] != null &&
        (json["featured_media_details"]["url"] as String).isNotEmpty) {
      resImg = json["featured_media_details"]["url"];
    } else if (json["jetpack_featured_media_url"] != null &&
        (json["jetpack_featured_media_url"] as String).isNotEmpty) {
      resImg = json["jetpack_featured_media_url"];
    }

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

    final String resTitle = json["title"]["rendered"] != null
        ? cleanText(json["title"]["rendered"])
        : '';

    final String resResumo = json["excerpt"]["rendered"] != null
        ? cleanText(json["excerpt"]["rendered"])
        : '';

    final String resMateria = json["content"]["rendered"] != null
        ? json["content"]["rendered"] ?? ""
        : "";

    String linkPdf = "";
    if (json["acf"] != null && json["acf"].isNotEmpty) {
      linkPdf = json["acf"]["linkpdf"] as String? ?? "";
    }

    String linkEbook = "";
    if (json["acf"] != null && json["acf"].isNotEmpty) {
      linkEbook = json["acf"]["linkEbook"] as String? ?? "";
    }

    final List<String> categoriaList =
        List<String>.from(json["nomeCategoria"] ?? []);
    final String? firstCategoria =
        categoriaList.isNotEmpty ? categoriaList.first : null;

    return Post(
      id: json["id"].toString(),
      title: resTitle.isNotEmpty ? resTitle : (json["title"] ?? ''),
      data: json["date"] ?? '',
      resumo: resResumo,
      materia: resMateria,
      img: resImg,
      link: json["link"] ?? '',
      linkPdf: linkPdf,
      linkEbook: linkEbook,
      categoria: firstCategoria,
      categoriaList: categoriaList,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "title": title,
      "data": data,
      "resumo": resumo,
      "materia": materia,
      "img": img,
      "link": link,
      "nCategoria": nCategoria,
      "linkPdf": linkPdf,
      "linkEbook": linkEbook,
      "categoria": categoria,
      "categoriaList": categoriaList,
    };
  }
}
