import 'dart:async';
import 'dart:io';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:conass/bloc/menu_home_bloc.dart';
import 'package:conass/bloc/post_bloc.dart';
import 'package:conass/componente/post_card.dart';
import 'package:conass/modelo/menu.dart';
import 'package:conass/util/barra_menu.dart';
import 'package:conass/util/connectionStatusSingleton.dart';
import 'package:conass/util/cores.dart';
import 'package:conass/util/menu.dart';
import 'package:conass/util/push.dart';
import 'package:conass/util/rodape.dart';
import 'package:conass/util/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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

    final bloc = BlocProvider.getBloc<PostsBloc>();

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
        //bottomNavigationBar: Rodape(),
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
                    if (index < snapshot.data.length) {
                      return PostCard(
                        snapshot.data[index],
                      );
                    } else if (index > 1) {
                      print(index);
                      bloc.inCategoria.add(null);
                      return Container(
                        height: 40,
                        width: 40,
                        alignment: Alignment.center,
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                              Cores.LaranjaEscuro),
                        ),
                      );
                    } else {
                      return Center(
                        child: Text("erro"),
                      );
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
/*
  Rodape1() {
    final menubloc = BlocProvider.getBloc<MenuCategoriaBloc>();
    final bloc = BlocProvider.getBloc<PostsBloc>();
    return Container(
      decoration: new BoxDecoration(
          border:
              Border(top: BorderSide(width: 0.3, color: Cores.PrimaryLaranja))),
      width: MediaQuery.of(context).size.width,
      height: 80,
      child: StreamBuilder(
          stream: menubloc.outMenu,
          builder: (context, snapshot) {
            print("Entrou no builder no menu");
            if (snapshot.hasError) {
              print("erro no snapshot do bloc");
              return Center(
                child: Text("Erro ao carregar menu"),
              );
            } else if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Cores.PrimaryVerde),
                ),
              );
            } else {
              return ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshot.data.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    final List<Menu> menus = snapshot.data;
                    Menu menu = menus[index];
                    return Padding(
                        padding: EdgeInsets.only(left: 5, right: 5),
                        child: GestureDetector(
                          onTap: () {
                            Util.cat = menu.id;
                            bloc.inCategoria.add(Util.cat);
                            setState(() {});
                          },
                          child: Chip(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                Radius.circular(3),
                              )),
                              backgroundColor: menu.id == Util.cat
                                  ? Cores.LaranjaEscuro
                                  : Cores.VerdeMedio,
                              label: Text(
                                menu.slug,
                                style: TextStyle(color: Colors.white),
                              )),
                        ));
                  });
            }
          }),
    );
  }

  */
}


/*
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
*/