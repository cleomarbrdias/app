import 'dart:async';
import 'package:flutter/material.dart';
import 'package:conass/modelo/menu_estados.dart';
import 'package:conass/servicos/api_menu_estados.dart';

class BlocMenuEstados with ChangeNotifier {
  ApiMenuEstados? menuServices;
  List<MenuEstados> menus = [];

  final StreamController<List<MenuEstados>> _postsController =
      StreamController<List<MenuEstados>>.broadcast();
  Stream<List<MenuEstados>> get outMenu => _postsController.stream;

  BlocMenuEstados() {
    menuServices = ApiMenuEstados();
    _loadMenu();
  }

  void _loadMenu() async {
    _postsController.sink.add([]);
    try {
      menus = await menuServices!.getMenuEstados();
      _postsController.sink.add(menus);
      notifyListeners();
    } catch (e) {
      print("Erro ao carregar menu: $e");
      _postsController.sink.addError(e);
    }
  }

  @override
  void dispose() {
    _postsController.close();
    super.dispose();
  }
}



// import 'dart:async';
// import 'dart:ui';
// import 'package:bloc_pattern/bloc_pattern.dart';
// import 'package:conass/modelo/menu_estados.dart';
// import 'package:conass/servicos/api_menu_estados.dart';
// import 'package:rxdart/rxdart.dart';

// class BlocMenuEstados implements BlocBase {
//   ApiMenuEstados? menuServices;
//   List<MenuEstados> menus = [];

//   final BehaviorSubject<List<MenuEstados>> _postsController =
//       BehaviorSubject<List<MenuEstados>>();
//   Stream<List<MenuEstados>> get outMenu => _postsController.stream;

//   BlocMenuEstados() {
//     menuServices = ApiMenuEstados();
//     _loadMenu();
//   }

//   void _loadMenu() async {
//     _postsController.sink.add([]);
//     try {
//       menus = await menuServices!.getMenuEstados();
//       _postsController.sink.add(menus);
//     } catch (e) {
//       print("Erro ao carregar menu: $e");
//       _postsController.sink.addError(e);
//     }
//   }

//   @override
//   void dispose() {
//     _postsController.close();
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
