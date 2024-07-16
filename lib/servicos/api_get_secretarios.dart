import 'dart:convert';
import 'package:conass/modelo/post_secretarios.dart';
import 'package:conass/util/util.dart';
import 'package:http/http.dart' as http;

class ApiGetSecretarios {
  String? _categoria;
  String? _pesquisa;
  int _page = 1;
  int? categoria;

  Future<List<PostSecretarios>> getPostsSes(String categoria) async {
    try {
      _page = 1;
      _categoria = categoria;

      print("Categoria $categoria");

      Uri url = Uri.parse(
          "https://www.conass.org.br/wp-json/wp/v2/$categoria/?orderby=slug&order=asc&per_page=30");
      http.Response response = await http.get(url);
      //&orderby=name&order=asc
      return decode(response);
    } catch (error) {
      Util.erro = "Erro ao estabelecer conexão, tente mais tarde!!";
      throw Exception(Util.erro); // Adicione um throw para retornar exceção
    }
  }

  List<PostSecretarios> decode(http.Response response) {
    if (response.statusCode == 200) {
      var decoded = json.decode(response.body);

      List<PostSecretarios> posts = decoded.map<PostSecretarios>((map) {
        return PostSecretarios.fromJson(map);
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
