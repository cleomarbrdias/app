import 'dart:async';
import 'package:flutter/material.dart';
import 'package:conass/modelo/post.dart';
import 'package:conass/servicos/api_biblioteca.dart';
import 'package:rxdart/rxdart.dart';

class BibliotecaBloc with ChangeNotifier {
  late ApiBiblioteca postServices;
  List<Post> posts = [];

  final BehaviorSubject<List<Post>> _postsSubject =
      BehaviorSubject<List<Post>>.seeded([]);
  Stream<List<Post>> get outPosts => _postsSubject.stream;

  final StreamController<int> _categoriaController = StreamController<int>();
  Sink<int> get inCategoria => _categoriaController.sink;

  BibliotecaBloc() {
    postServices = ApiBiblioteca();
    _categoriaController.stream.listen(_categoria);
  }

  void _categoria(int categoria) async {
    _postsSubject.add([]); // Clear the stream to indicate loading
    if (categoria != -1) {
      try {
        List<Post>? fetchedPosts = await postServices.getPosts(categoria);
        if (fetchedPosts != null) {
          posts = fetchedPosts;
          _postsSubject.add(posts);
        } else {
          _postsSubject.addError('Erro ao buscar posts');
        }
      } catch (e) {
        _postsSubject.addError('Erro ao buscar posts: $e');
      }
    }
    notifyListeners();
  }

  @override
  void dispose() {
    _postsSubject.close();
    _categoriaController.close();
    super.dispose();
  }
}
