import 'dart:async';
import 'package:flutter/material.dart';
import 'package:conass/modelo/menu.dart';
import 'package:conass/servicos/api_menu_categoria.dart';

class MenuHomeBloc with ChangeNotifier {
  final ApiMenuHome menuServices;
  List<Menu> menus = [];

  final _menuController = StreamController<List<Menu>>.broadcast();
  Stream<List<Menu>> get outMenu => _menuController.stream;

  MenuHomeBloc() : menuServices = ApiMenuHome() {
    fetchInitialData();
  }

  Future<void> fetchInitialData() async {
    _menuController.sink.add([]);
    try {
      menus = await menuServices.getMenu();
      print("Menus iniciais carregados: $menus");
      _menuController.sink.add(menus);
    } catch (error) {
      _menuController.sink.addError("Erro ao carregar menus: $error");
    }
  }

  @override
  void dispose() {
    _menuController.close();
    super.dispose();
  }
}



// import 'dart:async';
// import 'dart:ui';
// import 'package:bloc_pattern/bloc_pattern.dart';
// import 'package:conass/modelo/menu.dart';
// import 'package:conass/servicos/api_menu_categoria.dart';
// import 'package:rxdart/rxdart.dart';

// class MenuHomeBloc implements BlocBase {
//   ApiMenuHome? menuServices;
//   List<Menu> menus = [];

//   final BehaviorSubject<List<Menu>> _postsController =
//       BehaviorSubject<List<Menu>>();
//   Stream<List<Menu>> get outMenu => _postsController.stream;

//   final _menuController = BehaviorSubject<int>.seeded(6);
//   Sink<int> get inMenu => _menuController.sink;

//   MenuHomeBloc() {
//     menuServices = ApiMenuHome();
//     _menuController.stream.listen(_categoria);
//   }

//   void _categoria(int i) async {
//     _postsController.sink.add([]);
//     menus = await menuServices!.getMenu();
//     _postsController.sink.add(menus);
//   }

//   @override
//   void dispose() {
//     _postsController.close();
//     _menuController.close();
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
