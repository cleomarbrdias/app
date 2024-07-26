import 'dart:async';
import 'package:flutter/material.dart';
import 'package:conass/modelo/post_presidentes.dart';
import 'package:conass/servicos/api_presidentes.dart';
import 'package:conass/util/util.dart';
import 'package:rxdart/rxdart.dart';

class PostPresidentesBloc with ChangeNotifier {
  ApiPresidentes? postServices;

  // acionando a lista para armazenamento dos dados
  List<PostPresidentes> posts = [];

  // criando controles de saída
  final BehaviorSubject<List<PostPresidentes>> _postsController =
      BehaviorSubject<List<PostPresidentes>>();
  Stream<List<PostPresidentes>> get outPosts => _postsController.stream;

  // criando controles de entrada
  final BehaviorSubject<String?> _categoriaController =
      BehaviorSubject<String?>.seeded('presidentes');
  StreamSink<String?> get inCategoria => _categoriaController.sink;

  PostPresidentesBloc() {
    postServices = ApiPresidentes();
    _categoriaController.stream.listen(_categoria);
    print(_categoriaController);
  }

  void _categoria(String? categoria) async {
    if (categoria != null) {
      print("Entrou na categoria diferente de null");
      _postsController.sink.add([]);
      posts = await postServices!.getPostsPresidentes(categoria);

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
// import 'dart:ui';
// import 'package:bloc_pattern/bloc_pattern.dart';
// import 'package:conass/modelo/post_presidentes.dart';
// import 'package:conass/servicos/api_presidentes.dart';
// import 'package:conass/util/util.dart';
// import 'package:rxdart/rxdart.dart';

// class PostPresidentesBloc implements BlocBase {
//   ApiPresidentes? postServices;

//   //acionando a lista para armazenamento dos dados
//   List<PostPresidentes> posts = [];

//   //criando controles de saida de saida final _categoriaController = BehaviorSubject<int>(seedValue: 6);
//   final BehaviorSubject<List<PostPresidentes>> _postsController =
//       BehaviorSubject<List<PostPresidentes>>();
//   //StreamController<List<Post>>();
//   Stream get outPosts => _postsController.stream;

//   //criando controles de entrada
//   final BehaviorSubject<String?> _categoriaController =
//       BehaviorSubject<String?>.seeded('presidentes');
//   StreamSink<String?> get inCategoria => _categoriaController.sink;

//   PostPresidentesBloc() {
//     postServices = ApiPresidentes();
//     _categoriaController.stream.listen(_categoria);
//     print(_categoriaController);
//   }

//   void _categoria(String? categoria) async {
//     if (categoria != null) {
//       print("Entrou na cetoria diferente de null");
//       _postsController.sink.add([]);
//       posts = await postServices!.getPostsPresidentes(categoria);

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
