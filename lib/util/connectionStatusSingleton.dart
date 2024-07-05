import 'dart:io'; //InternetAddress utility
import 'dart:async'; //For StreamController/Stream

import 'package:connectivity/connectivity.dart';

class ConnectionStatusSingleton {
  // Isso cria a instância única chamando o construtor `_internal` especificado abaixo
  static final ConnectionStatusSingleton _singleton = new ConnectionStatusSingleton._internal();
  ConnectionStatusSingleton._internal();

  // Isso é o que é usado para recuperar a instância por meio do aplicativo
    static ConnectionStatusSingleton getInstance() => _singleton;

// Isso rastreia o status atual da conexão
  bool hasConnection = false;

  // É assim que permitiremos a inscrição em alterações de conexão
  StreamController connectionChangeController = new StreamController.broadcast();


  // flutter_connectivity
  final Connectivity _connectivity = Connectivity();

  // Conecte-se ao stream do flutter_connectivity para ouvir as alterações
  // E verifique o status da conexão fora do portão
  void initialize() {
    _connectivity.onConnectivityChanged.listen(_connectionChange);
    checkConnection();
  }

  Stream get connectionChange => connectionChangeController.stream;

  // Um método de limpeza para fechar nosso StreamController
  // Como isso deve existir durante
  // realmente um problema

  void dispose() {
    connectionChangeController.close();


  }

  // ouvinte de flutter_connectivity
  void _connectionChange(ConnectivityResult result) {
    checkConnection();
  }

  // O status da conexão alterado envia uma atualização para todos os ouvintes
  Future<bool> checkConnection() async {
    bool previousConnection = hasConnection;

    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        hasConnection = true;
      } else {
        hasConnection = false;
      }
    } on SocketException catch(_) {
      hasConnection = false;
    }

    // O teste para realmente ver se há uma conexão
    if (previousConnection != hasConnection) {
      connectionChangeController.add(hasConnection);
    }

    return hasConnection;
  }
}