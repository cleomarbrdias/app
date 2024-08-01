import 'dart:async';
import 'package:flutter/material.dart';
import 'package:conass/modelo/post.dart';
import 'package:conass/servicos/api.dart';
import 'package:conass/util/util.dart';

class PostsBloc with ChangeNotifier {
  Api? postServices;
  List<Post> posts = [];
  bool _hasMoreContent =
      true; // Variável para rastrear o estado de fim de conteúdo

  bool get hasMoreContent => _hasMoreContent; // Getter público

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
      _hasMoreContent =
          true; // Resetar o estado de fim de conteúdo ao carregar uma nova categoria
      print('Categoria carregada => $categoria');
      try {
        posts = await postServices!.getPosts(categoria);

        if (posts.isEmpty) {
          _postsController.sink.addError(Util.erro);
        } else {
          _postsController.sink.add(posts);
        }
      } catch (e) {
        _postsController.sink.addError(e.toString());
      }
    } else {
      if (_hasMoreContent) {
        try {
          final newPosts = await postServices!.nextPage();
          if (newPosts.isEmpty) {
            _hasMoreContent = false;
          } else {
            posts += newPosts;
            _postsController.sink.add(posts);
          }
        } catch (e) {
          _postsController.sink.addError(e.toString());
        }
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
// import 'package:flutter/material.dart';
// import 'package:conass/modelo/post.dart';
// import 'package:conass/servicos/api.dart';
// import 'package:conass/util/util.dart';

// class PostsBloc with ChangeNotifier {
//   Api? postServices;
//   List<Post> posts = [];

//   final StreamController<List<Post>> _postsController =
//       StreamController<List<Post>>.broadcast();
//   Stream<List<Post>> get outPosts => _postsController.stream;

//   final StreamController<int?> _categoriaController = StreamController<int?>();
//   Sink<int?> get inCategoria => _categoriaController.sink;

//   PostsBloc() {
//     postServices = Api();
//     _categoriaController.stream.listen(_categoria);
//   }

//   void _categoria(int? categoria) async {
//     if (categoria != null) {
//       _postsController.sink.add([]);
//       Util.cat = categoria;

//       print('Categoria Carregada => $categoria');
//       try {
//         posts = await postServices!.getPosts(categoria);

//         if (posts == null || posts.isEmpty) {
//           _postsController.sink.addError(Util.erro);
//         } else {
//           _postsController.sink.add(posts);
//         }
//       } catch (e) {
//         _postsController.sink.addError(e.toString());
//       }
//     } else {
//       try {
//         final newPosts = await postServices!.nextPage();
//         posts += newPosts;

//         if (posts == null || posts.isEmpty) {
//           _postsController.sink.addError(Util.erro);
//         } else {
//           _postsController.sink.add(posts);
//         }
//       } catch (e) {
//         _postsController.sink.addError(e.toString());
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
