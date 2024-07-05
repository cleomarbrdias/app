import 'dart:convert';
import 'package:conass/modelo/post.dart';
import 'package:conass/util/util.dart';
import 'package:connectivity/connectivity.dart';
import 'package:http/http.dart' as http;

class Api {
  int? _categoria;
  String? _pesquisa;
  int _page = 1;
  int? categoria;

  @override
  Future<List<Post>> getPosts(int categoria) async {
    try {
      _page = 1;
      _categoria = categoria;

      // http.Response response = await http.get(Uri.parse(
      //    "https://www.conass.org.br/wp-json/wp/v2/posts?categories=$categoria"));
      // return decode(response);
      print("Categoria $categoria");

      Uri url = Uri.parse(
          "https://www.conass.org.br/wp-json/wp/v2/posts?categories=$_categoria");
      http.Response response = await http.get(url);

      return decode(response);
    } catch (error) {
      Util.erro = "Erro ao estabelecer conexão, tente mais tarde!!";
      throw Exception(Util.erro); // Adicione um throw para retornar exceção
    }
  }

  @override
  Future<List<Post>> nextPage() async {
    _page++;

    try {
      var connectivityResult = await (Connectivity().checkConnectivity());

      if (connectivityResult == ConnectivityResult.none) {
        // Lógica para tratamento de falta de conexão
      }

      http.Response response = await http.get(Uri.parse(
          "https://www.conass.org.br/wp-json/wp/v2/posts?categories=$_categoria&page=$_page"));
      return decode(response);
    } catch (error) {
      print("Erro na próxima página: $error");
      throw Exception("Erro na próxima página: $error"); // Retorne uma exceção
    }
  }

  @override
  Future<List<Post>> getSearch(String pesquisa) async {
    try {
      _page = 1;
      _pesquisa = pesquisa;

      http.Response response = await http.get(Uri.parse(
          "https://www.conass.org.br/wp-json/wp/v2/posts?search=$pesquisa"));
      return decode(response);
    } catch (error) {
      print("Erro na busca: $error");
      throw Exception("Erro na busca: $error"); // Retorne uma exceção
    }
  }

  @override
  Future<List<Post>> getSearchNext() async {
    try {
      _page++;

      http.Response response = await http.get(Uri.parse(
          "https://www.conass.org.br/wp-json/wp/v2/posts?search=$_pesquisa&page=$_page"));
      return decode(response);
    } catch (error) {
      print("Erro na próxima página da busca: $error");
      throw Exception(
          "Erro na próxima página da busca: $error"); // Retorne uma exceção
    }
  }

  List<Post> decode(http.Response response) {
    if (response.statusCode == 200) {
      var decoded = json.decode(response.body);

      List<Post> posts = decoded.map<Post>((map) {
        return Post.fromJson(map);
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
