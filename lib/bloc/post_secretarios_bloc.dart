import 'dart:async';
import 'package:flutter/material.dart';
import 'package:conass/modelo/post_secretarios.dart';
import 'package:conass/servicos/api_get_secretarios.dart';
import 'package:conass/util/util.dart';
import 'package:rxdart/rxdart.dart';

class PostSecretariosBloc with ChangeNotifier {
  ApiGetSecretarios? postServices;

  // acionando a lista para armazenamento dos dados
  List<PostSecretarios> posts = [];

  // criando controles de saída
  final BehaviorSubject<List<PostSecretarios>> _postsController =
      BehaviorSubject<List<PostSecretarios>>();
  Stream<List<PostSecretarios>> get outPosts => _postsController.stream;

  // criando controles de entrada
  final BehaviorSubject<String?> _categoriaController =
      BehaviorSubject<String?>.seeded('secretarias-estaduai');
  StreamSink<String?> get inCategoria => _categoriaController.sink;

  PostSecretariosBloc() {
    postServices = ApiGetSecretarios();
    _categoriaController.stream.listen(_categoria);
    print(_categoriaController);
  }

  void _categoria(String? categoria) async {
    if (categoria != null) {
      print("Entrou na categoria diferente de null");
      _postsController.sink.add([]);
      posts = await postServices!.getPostsSes(categoria);

      if (posts == null) {
        _postsController.sink.addError(Util.erro);
      } else {
        _postsController.sink.add(posts);
      }
    } else {
      print("Entrou no next page");

      if (posts == null) {
        _postsController.sink.addError(Util.erro);
      } else {
        _postsController.sink.add(posts);
      }
    }
    _postsController.sink.add(posts);
    notifyListeners();
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
// import 'package:conass/modelo/post_secretarios.dart';
// import 'package:conass/servicos/api_get_secretarios.dart';
// import 'package:conass/util/util.dart';
// import 'package:rxdart/rxdart.dart';

// class PostSecretariosBloc implements BlocBase {
//   ApiGetSecretarios? postServices;

//   //acionando a lista para armazenamento dos dados
//   List<PostSecretarios> posts = [];

//   //criando controles de saida de saida final _categoriaController = BehaviorSubject<int>(seedValue: 6);
//   final BehaviorSubject<List<PostSecretarios>> _postsController =
//       BehaviorSubject<List<PostSecretarios>>();
//   //StreamController<List<Post>>();
//   Stream get outPosts => _postsController.stream;

//   //criando controles de entrada
//   final BehaviorSubject<String?> _categoriaController =
//       BehaviorSubject<String?>.seeded('secretarias-estaduai');
//   StreamSink<String?> get inCategoria => _categoriaController.sink;

//   PostSecretariosBloc() {
//     postServices = ApiGetSecretarios();
//     _categoriaController.stream.listen(_categoria);
//     print(_categoriaController);
//   }

//   void _categoria(String? categoria) async {
//     if (categoria != null) {
//       print("Entrou na cetoria diferente de null");
//       _postsController.sink.add([]);
//       posts = await postServices!.getPostsSes(categoria);

//       if (posts == null) {
//         _postsController.sink.addError(Util.erro);
//       } else {
//         _postsController.sink.add(posts);
//       }
//     } else {
//       print("entrou no next pag");
//       //final NewPosts = await postServices!.nextPage();
//       //posts += NewPosts;

//       //posts!.addAll(await postServices!.nextPage());

//       if (posts == null) {
//         _postsController.sink.addError(Util.erro);
//       } else {
//         _postsController.sink.add(posts);
//       }
//     }
//     _postsController.sink.add(posts);
//   }

//   @override
//   void dispose() {
//     _postsController.close();
//     _categoriaController.close();
//   }

//   @override
//   dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
// }
