import 'dart:convert';

import 'package:conass/modelo/camaras_tecnicas.dart';
import 'package:conass/util/util.dart';
import 'package:http/http.dart' as http;

class ApiCamarasTecnicas {
  String? _categoria;

  Future<List<CamarasTecnicas>> getPostsCamarasTecnicas(
      String categoria) async {
    try {
      _categoria = categoria;

      print("API Categoria => $categoria");

      Uri url = Uri.parse(
          "https://www.conass.org.br/wp-json/wp/v2/$categoria?per_page=100");
      http.Response response = await http.get(url);
      //&orderby=name&order=asc
      return decode(response);
    } catch (error) {
      Util.erro = "Erro ao estabelecer conexão, tente mais tarde!!";
      throw Exception(Util.erro); // Adicione um throw para retornar exceção
    }
  }

  List<CamarasTecnicas> decode(http.Response response) {
    if (response.statusCode == 200) {
      var decoded = json.decode(response.body);
      print("Entrou no response 200");
      List<CamarasTecnicas> posts = decoded.map<CamarasTecnicas>((map) {
        return CamarasTecnicas.fromJson(map);
      }).toList();

      return posts;
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
