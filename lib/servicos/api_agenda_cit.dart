import 'dart:convert';
import 'package:conass/modelo/post_agenda_cit.dart';
import 'package:conass/util/util.dart';
import 'package:http/http.dart' as http;

class ApiAgendaCit {
  String? _categoria;
  String? _pesquisa;
  int _page = 1;
  int? categoria;

  Future<List<PostAgendaCit>> getPostsCit(String categoria) async {
    try {
      _page = 1;
      _categoria = categoria;

      Uri url = Uri.parse(
          "https://www.conass.org.br/wp-json/wp/v2/$categoria/?per_page=30&orderby=date&order=asc");
      http.Response response = await http.get(url);
      //&orderby=name&order=asc
      return decode(response);
    } catch (error) {
      Util.erro = "Erro ao estabelecer conexão, tente mais tarde!!";
      throw Exception(Util.erro); // Adicione um throw para retornar exceção
    }
  }

  List<PostAgendaCit> decode(http.Response response) {
    if (response.statusCode == 200) {
      var decoded = json.decode(response.body);

      List<PostAgendaCit> posts = decoded.map<PostAgendaCit>((map) {
        return PostAgendaCit.fromJson(map);
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
