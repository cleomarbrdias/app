import 'dart:async';
import 'package:flutter/material.dart';
import 'package:conass/modelo/modelo_pagina.dart';
import 'package:conass/servicos/api_pagina.dart';
import 'package:conass/util/util.dart';

class PaginaBloc with ChangeNotifier {
  late ApiPagina api;

  final _pageController = StreamController<ModeloPagina>.broadcast();
  Stream<ModeloPagina> get outPage => _pageController.stream;

  final _inController = StreamController<int>.broadcast();
  Sink<int> get inPage => _inController.sink;

  PaginaBloc() {
    api = ApiPagina();
    _inController.stream.listen(_page);
  }

  void _page(int p) async {
    try {
      ModeloPagina pagi = await api.getPagina(p);

      _pageController.sink.add(pagi);
      notifyListeners();
    } catch (e) {
      _pageController.sink.addError(Util.erro);
      notifyListeners();
    }
  }

  @override
  void dispose() {
    _inController.close();
    _pageController.close();
    super.dispose();
  }
}


// import 'dart:async';
// import 'package:bloc_pattern/bloc_pattern.dart';
// import 'package:conass/modelo/modelo_pagina.dart';
// import 'package:conass/servicos/api_pagina.dart';
// import 'package:conass/util/util.dart';
// import 'package:rxdart/rxdart.dart';
// import 'dart:ui';

// class PaginaBloc extends BlocBase {
//   late ApiPagina api;

//   final StreamController<ModeloPagina> _pageController =
//       StreamController<ModeloPagina>.broadcast();
//   Stream<ModeloPagina> get outPage => _pageController.stream;

//   final _inController = BehaviorSubject<int>();
//   Sink<int> get inPage => _inController.sink;

//   PaginaBloc() {
//     api = ApiPagina();
//     _inController.stream.listen(_page);
//   }

//   void _page(int p) async {
//     try {
//       print("Solicitando página $p");
//       ModeloPagina pagi = await api.getPagina(p);
//       print("Página recebida: $pagi");
//       _pageController.sink.add(pagi);
//     } catch (e) {
//       print("Erro ao carregar a página: $e");
//       _pageController.sink.addError(Util.erro);
//     }
//   }

//   @override
//   void dispose() {
//     _inController.close();
//     _pageController.close();
//   }
// }

// /*
// import 'dart:async';
// import 'package:bloc_pattern/bloc_pattern.dart';
// import 'package:conass/componente/pagina.dart';
// import 'package:conass/servicos/api_pagina.dart';
// import 'package:conass/util/util.dart';

// import 'package:rxdart/rxdart.dart';

// class PaginaBloc extends BlocBase {
//   late ApiPagina api;

//   late Pagina pagi;

//   final StreamController<Pagina> _pageController =
//       StreamController<Pagina>.broadcast();
//   Stream get outPage => _pageController.stream;

//   final _inController = BehaviorSubject<int>();
//   Sink get inPage => _inController.sink;

//   PaginaBloc() {
//     api = ApiPagina();
//     _inController.stream.listen(_page);
//   }

//   void _page(int p) async {
//     pagi = (await api.getPagina(p)) as Pagina;

//     if (pagi == null) {
//       _pageController.sink.addError(Util.erro);
//     } else {
//       _pageController.sink.add(pagi);
//     }
//   }

//   @override
//   void dispose() {
//     _inController.close();
//     _pageController.close();
//   }
// }
// */