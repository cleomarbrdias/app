import 'dart:convert';
import 'package:conass/componente/pagina.dart';
import 'package:conass/util/util.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ApiPagina {
  Future<Pagina> getPagina(int pagina) async {
    try {
      print("Categoria $pagina");

      String url;
      print("Tipo de pagina: ${Util.tipo}");
      if (Util.tipo == 1) {
        print("Entrou no tipo 1");
        url = "https://www.conass.org.br/wp-json/wp/v2/posts/$pagina";
      } else {
        print("Entrou no diferente");
        url = "https://www.conass.org.br/wp-json/wp/v2/pages/$pagina";
      }

      Uri uri = Uri.parse(url);
      http.Response response = await http.get(uri);

      return decode(response);
    } catch (error) {
      Util.erro = "Erro ao estabelecer conexão, tente mais tarde!!";
      throw Exception(Util.erro);
    }
  }

  Pagina decode(http.Response response) {
    if (response.statusCode == 200) {
      var decoded = json.decode(response.body);

      return Pagina.fromJson(decoded);
    } else if (response.statusCode == 404) {
      Util.erro =
          "Página não encontrada (erro 404) - Pedimos desculpas, mas a página que você está tentando acessar não está disponível.";
      throw Exception("Erro 404: ${Util.erro}");
    } else if (response.statusCode == 400) {
      Util.erro = "FIM";
      throw Exception("Erro 400: ${Util.erro}");
    } else {
      Util.erro = "Ocorreu um erro ao processar sua solicitação";
      throw Exception("Erro desconhecido: ${Util.erro}");
    }
  }
}


  /*
  Future<Pagina> getPagina(int pagina) async {
    String url;
    print("Tipo de pagina: ${Util.tipo}");
    if (Util.tipo == 1) {
      print("Entrou no tipo 1");
      url = "https://www.conass.org.br/wp-json/wp/v2/posts/$pagina";
    } else {
      print("Entrou no diferente");
      url = "https://www.conass.org.br/wp-json/wp/v2/pages/$pagina";
    }

    Uri uri = Uri.parse(url);
    http.Response response = await http.get(uri);
    print("Response status code: ${response.statusCode}");

    if (response.statusCode == 200) {
      Map<String, dynamic> pagMap = jsonDecode(response.body);
      if (pagMap.isEmpty) {
        print("Mapa de página vazio.");
        throw Exception("Mapa de página vazio.");
      }
      print("Print do PagMap");
      print(pagMap);
      var pag = Pagina.fromJson(pagMap);
      print("Pagina carregada: =>");
      print(pag);
      return pag;
    } else if (response.statusCode == 404) {
      Util.erro =
          "Página não encontrada (erro 404) - Pedimos desculpas, mas a página que você está tentando acessar não está disponível. Pode ter sido alterada ou removida.";
      throw Exception("Erro 404: Página não encontrada");
    } else {
      Util.erro = "Ocorreu um erro ao processar sua solicitação";
      throw Exception("Erro: ${response.statusCode}");
    }
  }

  
}

*/

/*
import 'dart:convert';
import 'package:conass/componente/pagina.dart';
import 'package:conass/util/util.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ApiPagina {
  Future<Pagina> getPagina(int pagina) async {
    String url;
    print("Tipo de pagina");
    print(Util.tipo);
    if (Util.tipo == 1) {
      print("Entrou no tipo 1");
      url = "https://www.conass.org.br/wp-json/wp/v2/posts/$pagina";
    } else {
      print("Entrou no diferente");
      url = "https://www.conass.org.br/wp-json/wp/v2/pages/$pagina";
    }

/*
"https://www.conass.org.br/wp-json/wp/v2/pages/$pagina"
 */

    Uri uri = Uri.parse(url);
    http.Response response = await http.get(uri);
    //http.Response response = await http.get(url as Uri);

    if (response.statusCode == 200) {
      Map<String, dynamic> pagMap = jsonDecode(response.body);

      var pag = Pagina.fromJson(pagMap);
      print(pag);
      return pag;

      // return Container(
      //   child: Center(
      //     child: Text("CArregando apresentação de pagina."),
      //   ),
      // );
    } else if (response.statusCode == 404) {
      Util.erro =
          "Página não encontrada (erro 404) - Pedimos desculpas, mas a página que você está tentando acessar não está disponível. Pode ter sido alterada ou removida.";
      throw Exception("Erro do Else");
    } else {
      Util.erro = "Ocorreu um erro ao processar sua solicitação";

      throw Exception("Erro do Else");
    }
  }
}
*/