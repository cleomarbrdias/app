import 'dart:async';
import 'dart:ui';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:conass/modelo/menu.dart';
import 'package:conass/servicos/api_menu_categoria.dart';
import 'package:rxdart/rxdart.dart';

class MenuCategoriaBloc implements BlocBase {
  late ApiMenuHome menuServices;
  late List<Menu> menus;

  /*
  Criando Stream de saida
   */
  final BehaviorSubject<List<Menu>> _postsController =
      BehaviorSubject<List<Menu>>();
  Stream get outMenu => _postsController.stream;

  /* Criando Stream de entrada */
  final _menuController = BehaviorSubject<int>.seeded(1);
  Sink get inMenu => _menuController.sink;

  MenuCategoriaBloc() {
    menuServices = ApiMenuHome();
    _menuController.stream.listen(_categoria);
  }
  void _categoria(int i) async {
    _postsController.sink.add([]);
    /*menus = await menuServices.getMenu();*/
    _postsController.sink.add(menus);
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
