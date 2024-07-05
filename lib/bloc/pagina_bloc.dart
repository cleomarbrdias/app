import 'dart:async';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:conass/componente/pagina.dart';
import 'package:conass/servicos/api_pagina.dart';
import 'package:conass/util/util.dart';

import 'package:rxdart/rxdart.dart';

class PaginaBloc extends BlocBase {
  late ApiPagina api;

  late Pagina pagi;

  final StreamController<Pagina> _pageController =
      StreamController<Pagina>.broadcast();
  Stream get outPage => _pageController.stream;

  final _inController = BehaviorSubject<int>();
  Sink get inPage => _inController.sink;

  PaginaBloc() {
    api = ApiPagina();
    _inController.stream.listen(_page);
  }

  void _page(int p) async {
    pagi = (await api.getPagina(p)) as Pagina;

    if (pagi == null) {
      _pageController.sink.addError(Util.erro);
    } else {
      _pageController.sink.add(pagi);
    }
  }

  @override
  void dispose() {
    _inController.close();
    _pageController.close();
  }
}
