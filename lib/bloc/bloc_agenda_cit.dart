import 'dart:async';
import 'package:conass/modelo/post_agenda_cit.dart';
import 'package:conass/servicos/api_agenda_cit.dart';
import 'package:flutter/material.dart';
import 'package:conass/util/util.dart';
import 'package:rxdart/rxdart.dart';

class BlocAgendaCit with ChangeNotifier {
  ApiAgendaCit? postServices;

  // acionando a lista para armazenamento dos dados
  List<PostAgendaCit> posts = [];

  // criando controles de saída
  final BehaviorSubject<List<PostAgendaCit>> _postsController =
      BehaviorSubject<List<PostAgendaCit>>();
  Stream<List<PostAgendaCit>> get outPosts => _postsController.stream;

  // criando controles de entrada
  final BehaviorSubject<String?> _categoriaController =
      BehaviorSubject<String?>.seeded('cit-agenda');
  StreamSink<String?> get inCategoria => _categoriaController.sink;

  BlocAgendaCit() {
    postServices = ApiAgendaCit();
    _categoriaController.stream.listen(_categoria);
    print(_categoriaController);
  }

  void _categoria(String? categoria) async {
    if (categoria != null) {
      print("Entrou na categoria diferente de null");
      _postsController.sink.add([]);
      posts = await postServices!.getPostsCit(categoria);

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
