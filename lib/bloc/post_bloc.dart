import 'dart:async';
import 'dart:ui';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:conass/modelo/post.dart';
import 'package:conass/servicos/api.dart';
import 'package:conass/util/util.dart';
import 'package:rxdart/rxdart.dart';

class PostsBloc implements BlocBase {
  //declarando meu service API
  Api? postServices;

  //anciando uma lista para armazenar meus dados
  List<Post>? posts;

  //criando controles de saida de saida final _categoriaController = BehaviorSubject<int>(seedValue: 6);
  final BehaviorSubject<List<Post>> _postsController =
      BehaviorSubject<List<Post>>();
  //StreamController<List<Post>>();
  Stream get outPosts => _postsController.stream;

  //criando controles de entrada
  final _categoriaController = BehaviorSubject<int>.seeded(6);
  Sink get inCategoria => _categoriaController.sink;

  PostsBloc() {
    postServices = Api();
    _categoriaController.stream.listen(_categoria);
    print(_categoriaController);
  }
  void _categoria(int categoria) async {
    if (categoria != null) {
      print("Entrou na cetoria diferente de null");
      _postsController.sink.add([]);
      posts = await postServices!.getPosts(categoria);

      if (posts == null) {
        _postsController.sink.addError(Util.erro);
      } else {
        _postsController.sink.add(posts!);
      }
    } else {
      print("entrou no next pag");
      //posts += await postServices!.nextPage();
      posts!.addAll(await postServices!.nextPage());

      if (posts == null) {
        _postsController.sink.addError(Util.erro);
      } else {
        _postsController.sink.add(posts!);
      }
    }
    _postsController.sink.add(posts!);
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
