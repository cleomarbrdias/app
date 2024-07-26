import 'dart:convert';
import 'package:conass/modelo/menu_estados.dart';
import 'package:conass/util/util.dart';
import 'package:http/http.dart' as http;

class ApiMenuEstados {
  Future<List<MenuEstados>> getMenuEstados() async {
    try {
      Uri url = Uri.parse("https://www.conass.org.br/wp-json/menuapp/estados");
      http.Response response = await http.get(url);

      return decode(response);
    } catch (error) {
      Util.erro = "Erro ao estabelecer conexão, tente mais tarde!!";
      print("Erro: $error");
      throw Exception(Util.erro);
    }
  }

  List<MenuEstados> decode(http.Response response) {
    if (response.statusCode == 200) {
      var decoded = json.decode(response.body) as List<dynamic>;

      List<MenuEstados> menus = decoded.map<MenuEstados>((map) {
        return MenuEstados.fromJson(map);
      }).toList();

      print("Tamanho do Menu");
      print(menus.length);
      return menus;
    } else if (response.statusCode == 404) {
      Util.erro =
          "Página não encontrada (erro 404) - Pedimos desculpas, mas a página que você está tentando acessar não está disponível. Pode ter sido alterada ou removida.";
      print(Util.erro);
      throw Exception(Util.erro);
    } else {
      Util.erro = "Ocorreu um erro ao processar sua solicitação";
      print("Erro desconhecido: ${response.statusCode}");
      throw Exception("Erro desconhecido: ${response.statusCode}");
    }
  }
}
