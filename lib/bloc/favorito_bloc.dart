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
    SharedPreferences.getInstance().then((prefs) {
      if (prefs.getKeys().contains("favoritos")) {
        _favoritos =
            json.decode(prefs.getString("favoritos").toString()).map((k, v) {
          return MapEntry(k, Post.fromJson(v));
        }).cast<String, Post>();
        _favController.add(_favoritos);
      }
    });
  }

  void toggleFavorite(Post post) {
    if (_favoritos.containsKey(post.id)) {
      _favoritos.remove(post.id);
    } else {
      //_favoritos[post.id] = post;
    }

    _favController.sink.add(_favoritos);
    _saveFav();
    notifyListeners();
  }

  void _saveFav() {
    SharedPreferences.getInstance().then((prefs) {
      prefs.setString("favoritos", json.encode(_favoritos));
    });
  }

  @override
  void dispose() {
    _favController.close();
    super.dispose();
  }
}


// import 'dart:async';
// import 'dart:convert';

// import 'package:bloc_pattern/bloc_pattern.dart';
// import 'package:conass/modelo/post.dart';
// import 'package:rxdart/rxdart.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class FavoritoBloc implements BlocBase {
//   Map<String, Post> _favoritos = {};

//   final _favController = BehaviorSubject<Map<String, Post>>();
//   Stream<Map<String, Post>> get outFav => _favController.stream;

//   FavoritoBloc() {
//     SharedPreferences.getInstance().then((prefs) {
//       if (prefs.getKeys().contains("favoritos")) {
//         _favoritos =
//             json.decode(prefs.getString("favoritos").toString()).map((k, v) {
//           return MapEntry(k, Post.fromJson(v));
//         }).cast<String, Post>();
//         _favController.add(_favoritos);
//       }
//     });
//   }

//   void toggleFavorite(Post post) {
//     if (_favoritos.containsKey(post.id))
//       _favoritos.remove(post.id);
//     else
//       /*_favoritos[post.id] = post;*/

//       _favController.sink.add(_favoritos);

//     _saveFav();
//   }

//   void _saveFav() {
//     SharedPreferences.getInstance().then((prefs) {
//       prefs.setString("favoritos", json.encode(_favoritos));
//     });
//   }

//   @override
//   void dispose() {
//     _favController.close();
//   }

//   @override
//   dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
// }
