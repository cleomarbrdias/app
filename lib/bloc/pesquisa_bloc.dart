import 'dart:async';
import 'package:flutter/material.dart';
import 'package:conass/modelo/post.dart';
import 'package:conass/servicos/api.dart';
import 'package:conass/util/util.dart';
import 'package:rxdart/rxdart.dart';

class PesquisasBloc with ChangeNotifier {
  // declarando meu service API
  Api? api;

  // instanciando uma lista para armazenar meus dados
  List<Post> posts = [];

  // criando controles de saída
  final BehaviorSubject<List<Post>> _postsController =
      BehaviorSubject<List<Post>>();
  Stream<List<Post>> get outPosts => _postsController.stream;

  // criando controles de entrada
  final BehaviorSubject<String> _pesquisaController = BehaviorSubject<String>();
  Sink<String> get inPesquisa => _pesquisaController.sink;

  PesquisasBloc() {
    api = Api();
    _pesquisaController.stream.listen(_pesquisa);
  }

  void _pesquisa(String pesquisa) async {
    if (pesquisa.isNotEmpty) {
      _postsController.sink.add([]);
      posts = await api!.getSearch(pesquisa);

      if (posts.isEmpty) {
        _postsController.sink.addError(Util.erro);
      } else {
        _postsController.sink.add(posts);
      }
    } else {
      posts += await api!.getSearchNext();

      if (posts.isEmpty) {
        _postsController.sink.addError(Util.erro);
      } else {
        _postsController.sink.add(posts);
      }
    }
    notifyListeners();
  }

  @override
  void dispose() {
    _postsController.close();
    _pesquisaController.close();
    super.dispose();
  }
}
