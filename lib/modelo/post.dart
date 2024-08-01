import 'dart:convert';

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
  List<String>? name_descritores;
  String? isbn;
  String? doi;
  List<Arquivo>? arquivos; // Adicionando a nova propriedade arquivos

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
    this.name_descritores,
    this.isbn,
    this.doi,
    this.arquivos, // Adicionando a nova propriedade arquivos
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    String resImg = "https://www.conass.org.br/padraoMobile/padrao.png";

    if (json["featured_media_details"] != false &&
        json["featured_media_details"] != null &&
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

    final String resTitle =
        (json["title"] != null && json["title"]["rendered"] != null)
            ? cleanText(json["title"]["rendered"])
            : '';

    final String resResumo =
        json["excerpt"] != null && json["excerpt"]["rendered"] != null
            ? cleanText(json["excerpt"]["rendered"])
            : '';

    final String resMateria =
        json["content"] != null && json["content"]["rendered"] != null
            ? json["content"]["rendered"]
            : "";

    String linkPdf = "";
    if (json["acf"] != null && json["acf"].isNotEmpty) {
      linkPdf = json["acf"]["linkpdf"] as String? ?? "";
    }

    String linkEbook = "";
    if (json["acf"] != null && json["acf"].isNotEmpty) {
      linkEbook = json["acf"]["linkEbook"] as String? ?? "";
    }

    final List<String> categoriaList = json["nomeCategoria"] != null
        ? List<String>.from(json["nomeCategoria"])
        : [];
    final String? firstCategoria =
        categoriaList.isNotEmpty ? categoriaList.first : null;

    final List<String> name_descritores =
        json["meta"]["name_descritores"] != null
            ? List<String>.from(json["meta"]["name_descritores"])
            : [];

    // Parsing arquivos
    List<Arquivo> arquivos = [];
    if (json["meta"]["name_arquivos"] != null) {
      arquivos = List<Map<String, dynamic>>.from(json["meta"]["name_arquivos"])
          .map((e) => Arquivo.fromJson(e))
          .toList();
    }

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
      name_descritores: name_descritores,
      isbn: json["meta"]["isbn"] ?? '',
      doi: json["meta"]["doi"] ?? '',
      arquivos: arquivos, // Adicionando a nova propriedade arquivos
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
      "name_descritores": name_descritores,
      "isbn": isbn,
      "doi": doi,
      "arquivos": arquivos
          ?.map((e) => e.toJson())
          .toList(), // Adicionando a nova propriedade arquivos
    };
  }
}

class Arquivo {
  String? nomeDoArquivo;
  String? arquivo;

  Arquivo({
    this.nomeDoArquivo,
    this.arquivo,
  });

  factory Arquivo.fromJson(Map<String, dynamic> json) {
    return Arquivo(
      nomeDoArquivo: json['name_arquivos']['nome-do-arquivo'] as String?,
      arquivo: json['name_arquivos']['_arquivo'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nome-do-arquivo': nomeDoArquivo,
      '_arquivo': arquivo,
    };
  }
}



// class Post {
//   final String id;
//   final String title;
//   String? resumo;
//   String? materia;
//   final String img;
//   String? link;
//   String? nCategoria;
//   String? linkPdf;
//   String? linkEbook;
//   final String data;
//   String? categoria;
//   List<String>? categoriaList;
//   List<String>? name_descritores;
//   String? isbn;
//   String? doi;

//   Post({
//     required this.id,
//     required this.title,
//     this.resumo,
//     this.materia,
//     required this.img,
//     this.link,
//     this.nCategoria,
//     this.linkPdf,
//     this.linkEbook,
//     required this.data,
//     this.categoria,
//     this.categoriaList,
//     this.name_descritores,
//     this.isbn,
//     this.doi,
//   });

//   factory Post.fromJson(Map<String, dynamic> json) {
//     String resImg = "https://www.conass.org.br/padraoMobile/padrao.png";

//     if (json["featured_media_details"] != false &&
//         json["featured_media_details"] != null &&
//         json["featured_media_details"]["url"] != null &&
//         (json["featured_media_details"]["url"] as String).isNotEmpty) {
//       resImg = json["featured_media_details"]["url"];
//     } else if (json["jetpack_featured_media_url"] != null &&
//         (json["jetpack_featured_media_url"] as String).isNotEmpty) {
//       resImg = json["jetpack_featured_media_url"];
//     }

//     String cleanText(String text) {
//       return text
//           .replaceAll(RegExp(r'<[^>]*>'), '')
//           .replaceAll('Leia Mais..', '')
//           .replaceAll('&nbsp; ', '')
//           .replaceAll('&#8221;', '')
//           .replaceAll('&#8220;', '')
//           .replaceAll('&#8211;', '')
//           .replaceAll('1 &#8211;', '')
//           .replaceAll('[&hellip;]', '')
//           .replaceAll('&#8230;', '...')
//           .replaceAll('&#8230:', '...')
//           .replaceAll('&#8230', '...');
//     }

//     final String resTitle =
//         (json["title"] != null && json["title"]["rendered"] != null)
//             ? cleanText(json["title"]["rendered"])
//             : '';

//     final String resResumo =
//         json["excerpt"] != null && json["excerpt"]["rendered"] != null
//             ? cleanText(json["excerpt"]["rendered"])
//             : '';

//     final String resMateria =
//         json["content"] != null && json["content"]["rendered"] != null
//             ? json["content"]["rendered"]
//             : "";

//     String linkPdf = "";
//     if (json["acf"] != null && json["acf"].isNotEmpty) {
//       linkPdf = json["acf"]["linkpdf"] as String? ?? "";
//     }

//     String linkEbook = "";
//     if (json["acf"] != null && json["acf"].isNotEmpty) {
//       linkEbook = json["acf"]["linkEbook"] as String? ?? "";
//     }

//     final List<String> categoriaList = json["nomeCategoria"] != null
//         ? List<String>.from(json["nomeCategoria"])
//         : [];
//     final String? firstCategoria =
//         categoriaList.isNotEmpty ? categoriaList.first : null;

//     final List<String> name_descritores =
//         json["meta"]["name_descritores"] != null
//             ? List<String>.from(json["meta"]["name_descritores"])
//             : [];

//     return Post(
//       id: json["id"].toString(),
//       title: resTitle.isNotEmpty ? resTitle : (json["title"] ?? ''),
//       data: json["date"] ?? '',
//       resumo: resResumo,
//       materia: resMateria,
//       img: resImg,
//       link: json["link"] ?? '',
//       linkPdf: linkPdf,
//       linkEbook: linkEbook,
//       categoria: firstCategoria,
//       categoriaList: categoriaList,
//       name_descritores: name_descritores,
//       isbn: json["meta"]["isbn"] ?? '',
//       doi: json["meta"]["doi"] ?? '',
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       "id": id,
//       "title": title,
//       "data": data,
//       "resumo": resumo,
//       "materia": materia,
//       "img": img,
//       "link": link,
//       "nCategoria": nCategoria,
//       "linkPdf": linkPdf,
//       "linkEbook": linkEbook,
//       "categoria": categoria,
//       "categoriaList": categoriaList,
//       "name_descritores": name_descritores,
//       "isbn": isbn,
//       "doi": doi,
//     };
//   }
// }
