import 'dart:convert';
import 'package:conass/util/util.dart';
import 'package:http/http.dart' as http;

class ApiGetIdSecretaria {
  Future<int> getId(String slug) async {
    try {
      http.Response response = await http.get(Uri.parse(
          "https://www.conass.org.br/wp-json/wp/v2/secretarias-estaduai?slug=$slug"));

      if (response.statusCode == 200) {
        Util.tipo = 1;
        int pag = json.decode(response.body)['id'];
        return pag;
      } else if (response.statusCode == 404) {
        response = await http.get(Uri.parse(
            "https://www.conass.org.br/wp-json/wp/v2/secretarias-estaduai?slug=$slug"));

        if (response.statusCode == 200) {
          Util.tipo = 2;
          List<dynamic> pag = json.decode(response.body);
          int pagina = pag.isNotEmpty
              ? pag[0]["id"]
              : -1; // Tratamento caso a lista esteja vazia
          print("valor pag => $pagina");
          return pagina;
        } else if (response.statusCode == 404) {
          Util.erro =
              "Página não encontrada (erro 404) - Pedimos desculpas, mas a página que você está tentando acessar não está disponível. Pode ter sido alterada ou removida.";
          throw Exception("Erro 404: ${Util.erro}");
        } else {
          Util.erro = "Ocorreu um erro ao processar sua solicitação";
          throw Exception("Erro desconhecido: ${Util.erro}");
        }
      } else {
        Util.erro = "Ocorreu um erro ao processar sua solicitação";
        throw Exception("Erro desconhecido: ${Util.erro}");
      }
    } catch (error) {
      print("Erro na requisição: $error");
      throw Exception("Erro na requisição: $error");
    }
  }
}
