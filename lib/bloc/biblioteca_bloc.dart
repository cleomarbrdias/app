import 'dart:async';
import 'dart:ui';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:conass/modelo/post.dart';
import 'package:conass/servicos/api_biblioteca.dart';
import 'package:conass/util/util.dart';
import 'package:rxdart/rxdart.dart';

class BibliotecaBloc implements BlocBase {
  //declarando meu service API
  late ApiBiblioteca postServices;

  //inst
  //anciando uma lista para armazenar meus dados
  late List<Post> posts;

  //criando controles de saida de saida final _categoriaController = BehaviorSubject<int>(seedValue: 6);
  final _postsController = BehaviorSubject<List<Post>>();
  Stream get outPosts => _postsController.stream;

  //criando controles de entrada

  final _categoriaController = BehaviorSubject<int>.seeded(Util.catBiblioteca);
  Sink get inCategoria => _categoriaController.sink;

  BibliotecaBloc() {
    postServices = ApiBiblioteca();
    _categoriaController.stream.listen(_categoria);
  }
  void _categoria(int categoria) async {
    _postsController.sink.add([]);

    posts = (await postServices.getPosts(categoria))!;
    _postsController.sink.add(posts);
  }

  @override
  void dispose() {
    _postsController.close();
    _categoriaController.close();
  }

  @override
  void addListener(VoidCallback listener) {
    // TODO: implement addListener
  }

  @override
  // TODO: implement hasListeners
  bool get hasListeners => throw UnimplementedError();

  @override
  void notifyListeners() {
    // TODO: implement notifyListeners
  }

  @override
  void removeListener(VoidCallback listener) {
    // TODO: implement removeListener
  }
}
