import 'dart:async';
import 'dart:ui';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:conass/modelo/menu.dart';
import 'package:conass/servicos/api_menu.dart';
import 'package:conass/util/util.dart';

import 'package:rxdart/rxdart.dart';

class MenuBloc implements BlocBase {
  ApiMenu? menuServices;
  List<Menu>? menus = [];

  /*
  Criando Stream de saida
   */
  final BehaviorSubject<List<Menu>> _postsController =
      BehaviorSubject<List<Menu>>();
  Stream get outMenu => _postsController.stream;

  /*
  Criando Stream de entrada
   */
  final _menuController = BehaviorSubject<String>.seeded("");
  Sink get inMenu => _menuController.sink;

  MenuBloc() {
    print("Entrou no construtor do bloc menu");
    menuServices = ApiMenu();
    _menuController.stream.listen(_categoria);
  }

  void _categoria($i) async {
    print("Entrou na inicialização do blocMenu");
    _postsController.sink.add([]);
    menus = await menuServices!.getMenu();
    _postsController.sink.add(menus!);
  }

  @override
  void dispose() {
    _postsController.close();
    _menuController.close();
  }

  @override
  void addListener(VoidCallback listener) {
    // TODO: implement addListener
  }

  @override
  void notifyListeners() {
    // TODO: implement notifyListeners
  }

  @override
  void removeListener(VoidCallback listener) {
    // TODO: implement removeListener
  }

  @override
  bool get hasListeners => throw UnimplementedError();
}
