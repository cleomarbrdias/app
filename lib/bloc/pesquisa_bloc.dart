import 'dart:async';
import 'dart:ui';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:conass/modelo/post.dart';
import 'package:conass/servicos/api.dart';
import 'package:conass/util/util.dart';
import 'package:rxdart/subjects.dart';

class PesquisasBloc implements BlocBase {
  //declarando meu service API
  late Api api;

  //instanciando uma lista para armazenar meus dados
  late List<Post> posts;

  //criando controles de saida de saida
  final BehaviorSubject<List<Post>> _postsController =
      BehaviorSubject<List<Post>>();
  Stream get outPosts => _postsController.stream;

  //criando controles de entrada
  final BehaviorSubject<String> _pesquisaController = BehaviorSubject();
  Sink get inPesquisa => _pesquisaController.sink;

  PesquisasBloc() {
    api = Api();
    _pesquisaController.stream.listen(_pesquisa);
  }

  void _pesquisa(String pesquisa) async {
    if (pesquisa != null) {
      _postsController.sink.add([]);
      posts = await api.getSearch(pesquisa);

      if (posts == null) {
        _postsController.sink.addError(Util.erro);
      } else {
        _postsController.sink.add(posts);
      }
    } else {
      posts += await api.getSearchNext();

      if (posts == null) {
        _postsController.sink.addError(Util.erro);
      } else {
        _postsController.sink.add(posts);
      }
    }
    //_postsController.sink.add(posts);
  }

  @override
  void dispose() {
    _postsController.close();
    _pesquisaController.close();
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
