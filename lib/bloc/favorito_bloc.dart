import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:conass/modelo/post.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoritoBloc with ChangeNotifier {
  Map<String, Post> _favoritos = {};

  final _favController = StreamController<Map<String, Post>>.broadcast();
  Stream<Map<String, Post>> get outFav => _favController.stream;

  FavoritoBloc() {
    loadFav(); // Certifique-se de carregar os favoritos na inicialização
  }

  void toggleFavorite(Post post) {
    final postIdStr = post.id;
    if (_favoritos.containsKey(postIdStr)) {
      _favoritos.remove(postIdStr);
      print("Favorito removido: $postIdStr");
    } else {
      _favoritos[postIdStr] = post;
      print("Favorito adicionado: $postIdStr");
    }

    print("Total de favoritos: ${_favoritos.length}");
    _favController.sink.add(_favoritos);
    _saveFav();
    notifyListeners();
  }

  bool isFavorited(Post post) {
    return _favoritos.containsKey(post.id);
  }

  Future<void> loadFav() async {
    print("Carregando favoritos...");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getKeys().contains("favoritos")) {
      final favString = prefs.getString("favoritos") ?? "{}";
      final favMap = json.decode(favString) as Map<String, dynamic>;

      try {
        _favoritos = favMap.map((key, value) {
          return MapEntry(key, Post.fromJson(value));
        });
        print("Favoritos carregados: ${_favoritos.length}");
      } catch (e) {
        print("Erro ao carregar favoritos: $e");
      }

      _favController.add(_favoritos);
    } else {
      _favController.add({});
    }
    notifyListeners(); // Adicionado para garantir que a interface seja atualizada
  }

  void _saveFav() {
    print("Salvando favoritos...");
    SharedPreferences.getInstance().then((prefs) {
      final favString = json.encode(_favoritos.map((key, value) {
        return MapEntry(key, value.toJson());
      }));
      prefs.setString("favoritos", favString);
      print("Favoritos salvos: ${_favoritos.length}");
    });
  }

  Map<String, Post> get favoritos => _favoritos;

  @override
  void dispose() {
    _favController.close();
    super.dispose();
  }
}
