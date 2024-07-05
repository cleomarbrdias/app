import 'dart:convert';
import 'package:conass/modelo/post.dart';
import 'package:conass/util/util.dart';
import 'package:http/http.dart' as http;

class ApiBiblioteca {
  Future<List<Post>?> getPosts(int categoria) async {
    try {
      http.Response response = await http.get(
          "https://www.conass.org.br/biblioteca/wp-json/wp/v2/posts?categories=$categoria&per_page=99"
              as Uri);

      return decode(response);
    } catch (error) {
      print(error);
      Util.erro = "Ocorreu um erro ao processar sua solicitação";
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
          "Página não encontrada (erro 404) - Pedimos desculpas, mas a página que você está tentando acessar não está disponível. Pode ter sido alterada ou removida.";
      throw Exception("Erro do Else");
    } else {
      Util.erro = "Ocorreu um erro ao processar sua solicitação";

      throw Exception("Erro do Else");
    }
  }
}
