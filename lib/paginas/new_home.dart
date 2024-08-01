import 'dart:async';
import 'package:conass/componente/new_post_card_p.dart';
import 'package:conass/modelo/post.dart';
import 'package:conass/paginas/home_page.dart';
import 'package:conass/util/menu.dart';
import 'package:conass/util/push.dart';
import 'package:conass/util/sem_conexao.dart';
import 'package:provider/provider.dart';
import 'package:conass/bloc/bloc_post_destaque.dart';
import 'package:conass/bloc/bloc_post_mais_noticias.dart';
import 'package:conass/bloc/menu_home_bloc.dart';
import 'package:conass/componente/componente_menu_estados.dart';
import 'package:conass/componente/menu_categoria.dart';
import 'package:conass/componente/mais_noticias.dart';
import 'package:conass/util/barra_menu.dart';
import 'package:conass/util/connectionStatusSingleton.dart';
import 'package:conass/util/cores.dart';
import 'package:conass/util/rodape.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shimmer/shimmer.dart';

class NewHome extends StatefulWidget {
  NewHome({Key? key}) : super(key: key);
  @override
  _NewHomeState createState() => _NewHomeState();
}

class _NewHomeState extends State<NewHome> {
  StreamSubscription? _connectionChangeStream;
  bool isOffline = false;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    ConnectionStatusSingleton connectionStatus =
        ConnectionStatusSingleton.getInstance();
    _connectionChangeStream =
        connectionStatus.connectionChange.listen(connectionChanged);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_isInitialized) {
        Provider.of<BlocPostDestaque>(context, listen: false)
            .loadPosts
            .add(null);
        Provider.of<BlocPostMaisNoticias>(context, listen: false)
            .loadPosts
            .add(null);
        Provider.of<MenuHomeBloc>(context, listen: false).fetchInitialData();
        _isInitialized = true;
        print("Frame callback chamado");
      }
    });
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildPostRowNoticias(context),
            _buildMaisNoticias(context),
            MenuCategoria(),
            ComponenteMenuEstados(),
          ],
        ),
      ),
    );
  }

  Widget _buildPostRowNoticias(BuildContext context) {
    final bloc = Provider.of<BlocPostDestaque>(context);
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Container(
      height: screenHeight * 0.3,
      child: StreamBuilder<List<Post>>(
        stream: bloc.outPosts,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return SemConexao(
              message:
                  "Erro ao carregar as notícias, tente novamente mais tarde.",
              onRetry: () {
                pushReplacement(context, NewHome());
              },
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 3,
                itemBuilder: (context, index) {
                  return Container(
                    width: screenWidth * 0.8,
                    margin:
                        EdgeInsets.symmetric(horizontal: screenWidth * 0.02),
                    color: Colors.white,
                  );
                },
              ),
            );
          } else {
            return ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return Container(
                  width: screenWidth * 0.8,
                  margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.02),
                  child: NewPostCardP(snapshot.data![index]),
                );
              },
            );
          }
        },
      ),
    );
  }

  // Widget _buildPostRowNoticias(BuildContext context) {
  //   final bloc = Provider.of<BlocPostDestaque>(context);
  //   double screenHeight = MediaQuery.of(context).size.height;
  //   double screenWidth = MediaQuery.of(context).size.width;

  //   return Container(
  //     height: screenHeight * 0.3, // Ajuste proporcional à altura da tela
  //     child: StreamBuilder<List<Post>>(
  //       stream: bloc.outPosts,
  //       builder: (context, snapshot) {
  //         if (snapshot.hasError) {
  //           return Container(
  //             padding: EdgeInsets.all(10),
  //             child: Center(
  //               child: Text(
  //                 snapshot.error.toString(),
  //                 style: TextStyle(fontSize: 20, color: Colors.grey),
  //               ),
  //             ),
  //           );
  //         } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
  //           return Shimmer.fromColors(
  //             baseColor: Colors.grey[300]!,
  //             highlightColor: Colors.grey[100]!,
  //             child: ListView.builder(
  //               scrollDirection: Axis.horizontal,
  //               itemCount: 3, // Número de itens de carregamento falso
  //               itemBuilder: (context, index) {
  //                 return Container(
  //                   width: screenWidth * 0.8,
  //                   margin:
  //                       EdgeInsets.symmetric(horizontal: screenWidth * 0.02),
  //                   color: Colors.white,
  //                 );
  //               },
  //             ),
  //           );
  //         } else {
  //           return ListView.builder(
  //             scrollDirection: Axis.horizontal,
  //             itemCount: snapshot.data!.length,
  //             itemBuilder: (context, index) {
  //               return Container(
  //                 width: screenWidth * 0.8, // Largura proporcional à tela
  //                 margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.02),
  //                 child: NewPostCardP(snapshot.data![index]),
  //               );
  //             },
  //           );
  //         }
  //       },
  //     ),
  //   );
  // }

  Widget _buildMaisNoticias(BuildContext context) {
    final bloc = Provider.of<BlocPostMaisNoticias>(context);
    double screenWidth = MediaQuery.of(context).size.width;

    return StreamBuilder<List<Post>>(
      stream: bloc.outPosts,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return SemConexao(
            message:
                "Erro ao carregar as notícias, tente novamente mais tarde.",
            onRetry: () {
              pushReplacement(context, NewHome());
            },
          );
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Column(
              children: List.generate(
                3, // Número de itens de carregamento falso
                (index) => Container(
                  width: screenWidth * 0.9,
                  height:
                      100, // Altura de exemplo para os itens de carregamento
                  margin: EdgeInsets.symmetric(vertical: 10),
                  color: Colors.white,
                ),
              ),
            ),
          );
        } else {
          print("Chama mais noticias");
          return MaisNoticias(posts: snapshot.data ?? []);
        }
      },
    );
  }
}
