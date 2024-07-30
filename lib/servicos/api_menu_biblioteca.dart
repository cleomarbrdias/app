import 'dart:convert';
import 'package:conass/modelo/menu.dart';
import 'package:conass/util/util.dart';
import 'package:http/http.dart' as http;

class ApiMenuBiblioteca {
  Future<List<Menu>> getMenu() async {
    try {
      Uri url = Uri.parse(
          "https://www.conass.org.br/biblioteca/wp-json/menuapp/menu");
      http.Response response = await http.get(url);
      return decode(response);
    } catch (error) {
      Util.erro = "Erro ao estabelecer conexão, tente mais tarde!!";
      throw Exception(Util.erro);
    }
  }

  List<Menu> decode(http.Response response) {
    if (response.statusCode == 200) {
      print("retorno ok da api menu.");
      var decoded = json.decode(response.body);
      return List<Menu>.from(decoded.map((map) => Menu.fromJson(map)));
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
