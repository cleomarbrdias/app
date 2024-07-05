import 'dart:convert';
import 'package:conass/componente/pagina.dart';
import 'package:conass/util/util.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PostPage {
  Future<Container> getPostPage(String slug) async {
    try {
      http.Response response = await http
          .get(Uri.parse("https://www.conass.org.br/wp-json/v2/post/$slug"));

      if (response.statusCode == 200) {
        print("Resultado de post");
        return decoded(response);
      } else {
        http.Response response = await http.get(Uri.parse(
            "https://www.conass.org.br/wp-json/wp/v2/pages?slug=$slug"));

        if (response.statusCode == 200) {
          print("Resultado de página");
          return decoded(response);
        } else {
          throw Exception("Erro ao obter página");
        }
      }
    } catch (error) {
      print("Erro na requisição: $error");
      throw Exception("Erro na requisição: $error");
    }
  }

  Container decoded(http.Response response) {
    if (response.statusCode == 200) {
      Map<String, dynamic> pagMap = jsonDecode(response.body);

      //var pag = Pagina.fromJson(pagMap);

      //return pag
      // .toString(); // Retorne aqui o que você quer retornar como String

      return Container(
        child: Center(
          child: Text("Coorriginar apresentação de pagina."),
        ),
      );
    } else if (response.statusCode == 404) {
      Util.erro =
          "Página não encontrada (erro 404) - Pedimos desculpas, mas a página que você está tentando acessar não está disponível.";
      throw Exception("Erro 404: ${Util.erro}");
    } else {
      Util.erro = "Ocorreu um erro ao processar sua solicitação";
      throw Exception("Erro desconhecido: ${Util.erro}");
    }
  }
}
