import 'dart:async';
import 'package:flutter/material.dart';
import 'package:conass/modelo/post.dart';
import 'package:conass/servicos/api.dart';
import 'package:conass/util/util.dart';

class PostsBloc with ChangeNotifier {
  Api? postServices;
  List<Post> posts = [];

  final StreamController<List<Post>> _postsController =
      StreamController<List<Post>>.broadcast();
  Stream<List<Post>> get outPosts => _postsController.stream;

  final StreamController<int?> _categoriaController = StreamController<int?>();
  Sink<int?> get inCategoria => _categoriaController.sink;

  PostsBloc() {
    postServices = Api();
    _categoriaController.stream.listen(_categoria);
  }

  void _categoria(int? categoria) async {
    if (categoria != null) {
      _postsController.sink.add([]);
      Util.cat = categoria;
      posts = await postServices!.getPosts(categoria);

      if (posts == null || posts.isEmpty) {
        _postsController.sink.addError(Util.erro);
      } else {
        _postsController.sink.add(posts);
      }
    } else {
      final newPosts = await postServices!.nextPage();
      posts += newPosts;

      if (posts == null || posts.isEmpty) {
        _postsController.sink.addError(Util.erro);
      } else {
        _postsController.sink.add(posts);
      }
    }
  }

  @override
  void dispose() {
    _postsController.close();
    _categoriaController.close();
    super.dispose();
  }
}




// import 'dart:async';
// import 'package:bloc_pattern/bloc_pattern.dart';
// import 'package:conass/modelo/post.dart';
// import 'package:conass/servicos/api.dart';
// import 'package:conass/util/util.dart';
// import 'package:rxdart/rxdart.dart';

// class PostsBloc extends BlocBase {
//   Api? postServices;
//   List<Post> posts = [];

//   final BehaviorSubject<List<Post>> _postsController =
//       BehaviorSubject<List<Post>>();
//   Stream<List<Post>> get outPosts => _postsController.stream;

//   final BehaviorSubject<int?> _categoriaController = BehaviorSubject<int?>();
//   Sink<int?> get inCategoria => _categoriaController.sink;

//   PostsBloc() {
//     postServices = Api();
//     _categoriaController.stream.listen(_categoria);
//   }

//   void _categoria(int? categoria) async {
//     if (categoria != null) {
//       _postsController.sink.add([]);
//       Util.cat = categoria;
//       posts = await postServices!.getPosts(categoria);

//       if (posts == null || posts.isEmpty) {
//         _postsController.sink.addError(Util.erro);
//       } else {
//         _postsController.sink.add(posts);
//       }
//     } else {
//       final newPosts = await postServices!.nextPage();
//       posts += newPosts;

//       if (posts == null || posts.isEmpty) {
//         _postsController.sink.addError(Util.erro);
//       } else {
//         _postsController.sink.add(posts);
//       }
//     }
//   }

//   @override
//   void dispose() {
//     _postsController.close();
//     _categoriaController.close();
//     super.dispose();
//   }
// }
