import 'dart:async';
import 'package:flutter/material.dart';
import 'package:conass/modelo/post.dart';
import 'package:conass/servicos/api.dart';
import 'package:conass/util/util.dart';

class BlocPostDestaque with ChangeNotifier {
  // declarando meu service API
  Api? postServices;

  // inicializando uma lista para armazenar meus dados
  List<Post> posts = [];

  // criando controles de saída
  final StreamController<List<Post>> _postsController =
      StreamController<List<Post>>.broadcast();
  Stream<List<Post>> get outPosts => _postsController.stream;

  // criando controles de entrada
  final StreamController<void> _loadController = StreamController<void>();
  Sink<void> get loadPosts => _loadController.sink;

  BlocPostDestaque() {
    postServices = Api();
    _loadController.stream.listen((_) => _loadPosts());
  }

  void _loadPosts() async {
    try {
      _postsController.sink.add([]);
      posts = await postServices!.getPostsDestaque();

      if (posts.isEmpty) {
        _postsController.sink.addError(Util.erro);
      } else {
        _postsController.sink.add(posts);
        notifyListeners();
      }
    } catch (error) {
      _postsController.sink.addError(Util.erro);
    }
  }

  @override
  void dispose() {
    _postsController.close();
    _loadController.close();
    super.dispose();
  }
}



// import 'dart:async';

// import 'package:bloc_pattern/bloc_pattern.dart';
// import 'package:conass/modelo/post.dart';
// import 'package:conass/servicos/api.dart';
// import 'package:conass/util/util.dart';
// import 'package:rxdart/rxdart.dart';

// class BlocPostDestaque implements BlocBase {
//   // declarando meu service API
//   Api? postServices;

//   // inicializando uma lista para armazenar meus dados
//   List<Post> posts = [];

//   // criando controles de saída
//   final BehaviorSubject<List<Post>> _postsController =
//       BehaviorSubject<List<Post>>();
//   Stream<List<Post>> get outPosts => _postsController.stream;

//   // criando controles de entrada
//   final BehaviorSubject<void> _loadController = BehaviorSubject<void>();
//   Sink<void> get loadPosts => _loadController.sink;

//   BlocPostDestaque() {
//     postServices = Api();
//     _loadController.stream.listen((_) => _loadPosts());
//   }

//   void _loadPosts() async {
//     try {
//       _postsController.sink.add([]);
//       posts = await postServices!.getPostsDestaque();

//       if (posts == null) {
//         _postsController.sink.addError(Util.erro);
//       } else {
//         _postsController.sink.add(posts);
//       }
//     } catch (error) {
//       _postsController.sink.addError(Util.erro);
//     }
//   }

//   @override
//   void dispose() {
//     _postsController.close();
//     _loadController.close();
//   }

//   @override
//   dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
// }
