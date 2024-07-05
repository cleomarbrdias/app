class Post {
  String? id;
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
          .replaceAll('1 &#8211;', '');

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
          .replaceAll('&#8230', '...');

      if (json["acf"].isNotEmpty) {
        _categoria = json["acf"]["titulo_categoria"];

        _ebook = json["acf"]["linkEbook"];
        _pdf = json["acf"]["linkpdf"];
      }

      return Post(
          id: json["id"].toString(),
          title: ResTitle,
          data: json["date"],
          resumo: res,
          materia: json["content"]["rendered"],
          img: _resImg,
          link: json["link"],
          nCategoria: _categoria,
          linkEbook: _ebook,
          linkPdf: _pdf);
    } else {
      return Post(
        id: json["postId"].toString(),
        title: json["title"],
        data: json["date"],
        resumo: json["resumo"],
        materia: json["materia"],
        img: json["img"],
        link: json["link"],
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
