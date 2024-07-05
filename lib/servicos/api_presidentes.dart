import 'dart:convert';
import 'package:conass/modelo/post.dart';
import 'package:http/http.dart' as http;

class PostServicePresidentes {
  static Future<List> getPosts() async {
    try {
      final String apiUrl = "https://www.conass.org.br/wp-json/wp/v2/";
      List posts;
      int countPage = 100;
      var res = await http.get(
          Uri.encodeFull(apiUrl + "posts?categories=39&per_page=$countPage")
              as Uri,
          headers: {"Accept": "application/json"});
      final mapPosts = json.decode(res.body).cast<Map<String, dynamic>>();
      posts = mapPosts.map<Post>((json) => Post.fromJson(json)).toList();
      return posts;
    } catch (error) {
      return [];
    }
  }
}
