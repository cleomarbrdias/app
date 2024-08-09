import 'package:flutter/material.dart';

class TextSizeProvider with ChangeNotifier {
  double _sizeTitle = 16.0;
  double _sizeConteudo = 12.0;
  double _sizePublicado = 8.0;

  final double _minSizeTitle = 16.0;
  final double _maxSizeTitle = 24.0;

  final double _minSizeConteudo = 12.0;
  final double _maxSizeConteudo = 20.0;

  final double _minSizePublicado = 8.0;
  final double _maxSizePublicado = 14.0;

  double get sizeTitle => _sizeTitle;
  double get sizeConteudo => _sizeConteudo;
  double get sizePublicado => _sizePublicado;

  void increaseTextSize() {
    if (_sizeTitle < _maxSizeTitle) _sizeTitle += 1;
    if (_sizeConteudo < _maxSizeConteudo) _sizeConteudo += 1;
    if (_sizePublicado < _maxSizePublicado) _sizePublicado += 1;
    notifyListeners();
  }

  void decreaseTextSize() {
    if (_sizeTitle > _minSizeTitle) _sizeTitle -= 1;
    if (_sizeConteudo > _minSizeConteudo) _sizeConteudo -= 1;
    if (_sizePublicado > _minSizePublicado) _sizePublicado -= 1;
    notifyListeners();
  }
}
