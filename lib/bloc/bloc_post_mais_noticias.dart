import 'dart:async';
import 'package:flutter/material.dart';
import 'package:conass/modelo/post.dart';
import 'package:conass/servicos/api.dart';
import 'package:conass/util/util.dart';

class BlocPostMaisNoticias with ChangeNotifier {
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

  BlocPostMaisNoticias() {
    postServices = Api();
    _loadController.stream.listen((_) => _loadPosts());
  }

  void _loadPosts() async {
    try {
      _postsController.sink.add([]);
      posts = await postServices!.getPostsMaisNoticias();

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
// import 'dart:ui';

// import 'package:bloc_pattern/bloc_pattern.dart';
// import 'package:conass/modelo/post.dart';
// import 'package:conass/servicos/api.dart';
// import 'package:conass/util/util.dart';
// import 'package:rxdart/rxdart.dart';

// class BlocPostMaisNoticias implements BlocBase {
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

//   BlocPostMaisNoticias() {
//     postServices = Api();
//     _loadController.stream.listen((_) => _loadPosts());
//   }

//   void _loadPosts() async {
//     try {
//       _postsController.sink.add([]);
//       posts = await postServices!.getPostsMaisNoticias();

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
//   void addListener(VoidCallback listener) {
//     // TODO: implement addListener
//   }

//   @override
//   // TODO: implement hasListeners
//   bool get hasListeners => throw UnimplementedError();

//   @override
//   void notifyListeners() {
//     // TODO: implement notifyListeners
//   }

//   @override
//   void removeListener(VoidCallback listener) {
//     // TODO: implement removeListener
//   }
// }
