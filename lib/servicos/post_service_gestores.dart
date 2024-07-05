import 'dart:convert';
import 'package:conass/modelo/post.dart';
import 'package:http/http.dart' as http;

class PostServiceGestores {
  static Future<List> getPosts() async {
    try {
      final String apiUrl = "https://www.conass.org.br/wp-json/wp/v2/";
      List posts;
      int countPage = 27;
      var res = await http.get(
          Uri.encodeFull(apiUrl +
                  "posts?categories=36&per_page=$countPage&filter[orderby]=title&order=asc")
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
