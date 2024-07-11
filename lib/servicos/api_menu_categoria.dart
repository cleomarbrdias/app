import 'dart:convert';

import 'package:conass/modelo/menu.dart';
import 'package:conass/util/util.dart';
import 'package:http/http.dart' as http;

class ApiMenuHome {
  Future<List<Menu>> getMenu() async {
    try {
      Uri url = Uri.parse("https://www.conass.org.br/wp-json/menuapp/menu");
      http.Response response = await http.get(url);

      return decode(response);
    } catch (error) {
      Util.erro = "Erro ao estabelecer conexão, tente mais tarde!!";
      throw Exception(Util.erro); // Adicione um throw para retornar exceção
    }
  }

  List<Menu> decode(http.Response response) {
    if (response.statusCode == 200) {
      var decoded = json.decode(response.body);

      List<Menu> menus = decoded.map<Menu>((map) {
        return Menu.fromJson(map);
      }).toList();

      return menus;
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
