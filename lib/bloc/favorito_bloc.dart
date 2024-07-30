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
    _loadFav();
  }

  void toggleFavorite(Post post) {
    if (_favoritos.containsKey(post.id)) {
      _favoritos.remove(post.id);
    } else {
      _favoritos[post.id] = post;
    }

    _favController.sink.add(_favoritos);
    _saveFav();
    notifyListeners();
  }

  bool isFavorited(Post post) {
    return _favoritos.containsKey(post.id);
  }

  Future<void> _loadFav() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getKeys().contains("favoritos")) {
      _favoritos =
          json.decode(prefs.getString("favoritos").toString()).map((k, v) {
        return MapEntry(k, Post.fromJson(v));
      }).cast<String, Post>();
      _favController.add(_favoritos);
    }
  }

  void _saveFav() {
    SharedPreferences.getInstance().then((prefs) {
      prefs.setString("favoritos", json.encode(_favoritos));
    });
  }

  Map<String, Post> get favoritos => _favoritos;

  @override
  void dispose() {
    _favController.close();
    super.dispose();
  }
}
