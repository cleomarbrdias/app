import 'dart:convert';

import 'package:conass/modelo/categoria.dart';
import 'package:http/http.dart' as http;

class ApiGetCategoria {
  Future<Categoria?> getCategoria(int id) async {
    final String uri = 'https://www.conass.org.br/wp-json/wp/v2/categories/$id';

    try {
      http.Response response = await http.get(Uri.parse(uri));

      if (response.statusCode == 200) {
        final Map<String, dynamic> json = jsonDecode(response.body);
        return Categoria.fromJson(json);
      } else {
        print('Failed to load category: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching category: $e');
    }

    return null;
  }
}
