import 'dart:async';

import 'package:conass/modelo/post.dart';
import 'package:conass/servicos/api.dart';
import 'package:conass/util/util.dart';
import 'package:flutter/material.dart';

class BlocPostMaisNoticias with ChangeNotifier {
  Api? postServices;
  List<Post> posts = [];

  final StreamController<List<Post>> _postsController =
      StreamController<List<Post>>.broadcast();
  Stream<List<Post>> get outPosts => _postsController.stream;

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

      print("Posts carregados: ${posts.length}");
      if (posts.isEmpty) {
        _postsController.sink.addError(Util.erro);
      } else {
        _postsController.sink.add(posts);
        notifyListeners();
      }
    } catch (error) {
      print("Erro ao carregar posts: $error");
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
