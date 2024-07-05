import 'dart:convert';
import 'package:conass/componente/pagina.dart';
import 'package:conass/util/util.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ApiPagina {
  Future<Container> getPagina(int pagina) async {
    String url;

    if (Util.tipo == 1) {
      url = "https://www.conass.org.br/wp-json/wp/v2/posts/$pagina";
    } else {
      url = "https://www.conass.org.br/wp-json/wp/v2/pages/$pagina";
    }

/*
"https://www.conass.org.br/wp-json/wp/v2/pages/$pagina"
 */
    http.Response response = await http.get(url as Uri);

    if (response.statusCode == 200) {
      Map<String, dynamic> pagMap = jsonDecode(response.body);

      //var pag = Pagina.fromJson(pagMap);

      //return pag;

      return Container(
        child: Center(
          child: Text("Coorriginar apresentação de pagina."),
        ),
      );
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
