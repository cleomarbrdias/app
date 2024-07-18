class Post {
  int? id;
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

  Post({
    this.id,
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
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    final String resImg =
        (json["jetpack_featured_media_url"] as String? ?? "").isEmpty
            ? "https://www.conass.org.br/padraoMobile/padrao.png"
            : json["jetpack_featured_media_url"];

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

    final String resTitle =
        json["title"] != null ? cleanText(json["title"]["rendered"]) : '';

    final String resResumo =
        json["excerpt"] != null ? cleanText(json["excerpt"]["rendered"]) : '';

    final String resMateria =
        json["content"] != null ? json["content"]["rendered"] ?? "" : "";
/*
    final String acf_categoria = json["acf"] != null

        ? (json["acf"]["titulo_categoria"] as String? ?? '')
        : '';
*/

    String linkPdf = "";
    if (json.containsKey(json["acf"]) &&
        json["acf"] != null &&
        json["acf"].containsKey("linkpdf")) {
      linkPdf = json["acf"]["linkpdf"] as String? ?? "";
    }

    String linkEbook = "";
    if (json.containsKey(json["acf"]) &&
        json["acf"] != null &&
        json["acf"].containsKey("linkEbook")) {
      linkEbook = json["acf"]["linkEbook"] as String? ?? "";
    }
    /*
    final String linkPdf =
        json["acf"] != null ? (json["acf"]["linkpdf"] as String? ?? '') : '';

    final String linkEbook =
        json["acf"] != null ? (json["acf"]["linkEbook"] as String? ?? '') : '';
*/
    final List<String> categoriaList =
        List<String>.from(json["nomeCategoria"] ?? []);
    final String? firstCategoria =
        categoriaList.isNotEmpty ? categoriaList.first : null;

    return Post(
      id: json["id"] ?? json["id"],
      title: resTitle.isNotEmpty ? resTitle : (json["title"] ?? ''),
      data: json["date"] ?? '',
      resumo: resResumo,
      materia: resMateria,
      img: resImg,
      link: json["link"] ?? '',
      //nCategoria: nCategoria,
      linkPdf: linkPdf,
      linkEbook: linkEbook,
      categoria: firstCategoria,
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
    };
  }
}





/*
class Post {
  int? id;
  final String title;
  String? resumo;
  String? materia;
  final String img;
  String? link;
  final String nCategoria;
  String? linkPdf;
  String? linkEbook;
  final String data;

  Post({
    this.id,
    required this.title,
    this.resumo,
    this.materia,
    required this.img,
    this.link,
    required this.nCategoria,
    this.linkPdf,
    this.linkEbook,
    required this.data,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    final String _resImg;
    String _categoria = " ";
    String _pdf = " ";
    String _ebook = "";

    if (json["jetpack_featured_media_url"] == " ") {
      _resImg = "https://www.conass.org.br/padraoMobile/padrao.png";
    } else {
      _resImg = json["jetpack_featured_media_url"];
    }

    if (json.containsKey("id")) {
      final String res = json["excerpt"]["rendered"]
          .replaceAll(new RegExp(r'<[^>]*>'), '')
          .replaceAll('Leia Mais..', '')
          .replaceAll('&nbsp; ', '')
          .replaceAll('&#8221;', '')
          .replaceAll('&#8220;', '')
          .replaceAll('&#8211;', '')
          .replaceAll('1 &#8211;', '')
          .replaceAll('[&hellip;]', '');

      // ignore: non_constant_identifier_names
      final String ResTitle = json["title"]["rendered"]
          .replaceAll(new RegExp(r'<[^>]*>'), '')
          .replaceAll('Leia Mais..', '')
          .replaceAll('&nbsp; ', '')
          .replaceAll('&#8221;', '')
          .replaceAll('&#8220;', '')
          .replaceAll('&#8211;', '')
          .replaceAll('1 &#8211;', '')
          .replaceAll('&#8230;', '...')
          .replaceAll('&#8230:', '...')
          .replaceAll('&#8230', '...')
          .replaceAll('[&hellip;]', '');

      if (json["acf"].isNotEmpty) {
        _categoria = json["acf"]["titulo_categoria"] ?? '';

        _ebook = json["acf"]["linkEbook"] ?? '';
        _pdf = json["acf"]["linkpdf"] ?? '';
      }

      return Post(
          id: json["id"],
          title: ResTitle,
          data: json["date"],
          resumo: res,
          materia: json["content"]["rendered"] != null ? json["content"]["rendered"]: "",
          img: _resImg,
          link: json["link"],
          nCategoria: _categoria,
          linkEbook: _ebook,
          linkPdf: _pdf);
    } else {
      return Post(
        id: json["postId"],
        title: json["title"] != null ? json["title"],
        data: json["date"] ?? '',
        resumo: json["resumo"] ?? '',
        materia: json["materia"] ?? '',
        img: json["img"] ?? '',
        link: json["link"] ?? '',
        nCategoria: _categoria,
      );
    }
  }

  Map<String, dynamic> toJson() {
    return {
      "postId": id,
      "title": title,
      "data": data,
      "resumo": resumo,
      "materia": materia,
      "img": img,
      "link": link
    };
  }
}
*/