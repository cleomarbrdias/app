import 'dart:async';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:conass/bloc/post_bloc.dart';
import 'package:conass/componente/post_card.dart';
import 'package:conass/util/barra_menu.dart';
import 'package:conass/util/connectionStatusSingleton.dart';
import 'package:conass/util/cores.dart';
import 'package:conass/util/menu.dart';
import 'package:conass/util/modal.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Modal modal = Modal();

  StreamSubscription? _connectionChangeStream;

  bool isOffline = false;

  @override
  void initState() {
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

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    final bloc = BlocProvider.getBloc<PostsBloc>();

    if (isOffline) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              "Sem Conexão",
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
            backgroundColor: Cores.PrimaryVerde,
            duration: Duration(seconds: 3),
          ),
        );
      });
    }

    return Scaffold(
        key: _scaffoldKey,
        appBar: BarraMenu(context, "CONASS"),
        drawer: MenuList(),
        body: StreamBuilder(
            stream: bloc.outPosts,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                print('Entrou na validação de erro do Snapshot home_page');
                return Center(
                  child: Text("Ocorreu um erro ao lista  publicações.."),
                );
              } else if (!snapshot.hasData || snapshot.data.length == 0) {
                print('Carregando dados de Snapshot home_page');
                return Center(
                  child: CircularProgressIndicator(
                    valueColor:
                        AlwaysStoppedAnimation<Color>(Color(0xff008979)),
                  ),
                );
              } else if (snapshot.hasData) {
                print('entrou no Snapshot home_page');
                return ListView.builder(
                  itemBuilder: (context, index) {
                    if (index < snapshot.data.length) {
                      print('Tamanho da lsita é $snapshot.data.length');
                      ScrollController scrollController2 = ScrollController();
                      return PostCard(
                        snapshot.data[index],
                        scrollController: scrollController2,
                      );
                    } else if (index > 1) {
                      bloc.inCategoria.add(null);
                      return Container(
                        height: 40,
                        width: 40,
                        alignment: Alignment.center,
                        child: CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Color(0xff008979)),
                        ),
                      );
                    }
                  },
                  itemCount: snapshot.data.length + 1,
                );
              } else
                return Container(
                  child: Text("Nenhuma categoria carregada..."),
                );
            }));
  }

  _onClickPesquisa(BuildContext context, String result) {
    //push(context, HomePesquisa(result));
  }
}
