import 'dart:async';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:conass/bloc/post_camaras_tecnicas_bloc.dart';
import 'package:conass/bloc/post_presidentes_bloc.dart';
import 'package:conass/componente/post_card_camaras_tecnicas.dart';
import 'package:conass/util/barra_menu.dart';
import 'package:conass/util/connectionStatusSingleton.dart';
import 'package:conass/util/cores.dart';
import 'package:conass/util/menu.dart';
import 'package:conass/util/rodape.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PageCamarasTecnicas extends StatefulWidget {
  PageCamarasTecnicas({Key? key}) : super(key: key);
  @override
  _PageCamarasTecnicasState createState() => _PageCamarasTecnicasState();
}

class _PageCamarasTecnicasState extends State<PageCamarasTecnicas> {
  // ignore: unused_field, cancel_subscriptions
  StreamSubscription? _connectionChangeStream;

  bool isOffline = false;

  @override
  initState() {
    super.initState();

    ConnectionStatusSingleton connectionStatus =
        ConnectionStatusSingleton.getInstance();
    _connectionChangeStream =
        connectionStatus.connectionChange.listen(connectionChanged);
  }

  void connectionChanged(dynamic hasConnection) {
    setState(() {
      isOffline = !hasConnection;
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    });
  }

  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    final bloc = BlocProvider.getBloc<PostCamarasTecnicasBloc>();
    print("Pagina Camaras Tecnicas");
    if (isOffline) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              "Parece que você está offline. Verifique sua conexão com a internet e tente novamente.",
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
            backgroundColor: Cores.LaranjaEscuro,
            duration: Duration(seconds: 3),
          ),
        );
      });
    }

    return Scaffold(
        key: _scaffoldKey,
        appBar: BarraMenu(context),
        drawer: MenuList(),
        bottomNavigationBar: Rodape(),
        body: StreamBuilder(
            stream: bloc.outPosts,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Container(
                    padding: EdgeInsets.all(24),
                    child: Center(
                      child: Text(
                        snapshot.error.toString(),
                        style: TextStyle(fontSize: 20, color: Colors.grey),
                      ),
                    ));
              } else if (!snapshot.hasData || snapshot.data.length == 0) {
                return Center(
                  child: CircularProgressIndicator(
                    valueColor:
                        AlwaysStoppedAnimation<Color>(Cores.LaranjaEscuro),
                  ),
                );
              } else if (snapshot.hasData) {
                print(snapshot.data);
                return ListView.builder(
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      // Texto adicional no início da lista
                      return Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Text(
                          'Câmara Técnica '.toUpperCase(),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Cores.LaranjaClaro,
                          ),
                        ),
                      );
                    } else {
                      // Corrigir o índice para o snapshot.data
                      int dataIndex = index - 1;
                      if (dataIndex < snapshot.data.length) {
                        return PostCardCamarasTecnicas(
                          snapshot.data[dataIndex],
                        );
                      } else {
                        return Center(
                          child: Text("erro"),
                        );
                      }
                    }
                  },
                  itemCount: snapshot.data.length + 1,
                );
              } else {
                return Container(
                  child: Text("Nenhuma categoria carregada..."),
                );
              }
            }));
  }
}
