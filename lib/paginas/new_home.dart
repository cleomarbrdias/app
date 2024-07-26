import 'dart:async';
import 'package:conass/componente/new_post_card_p.dart';
import 'package:conass/modelo/post.dart';
import 'package:conass/util/menu.dart';
import 'package:provider/provider.dart';
import 'package:conass/bloc/bloc_post_destaque.dart';
import 'package:conass/bloc/bloc_post_mais_noticias.dart';
import 'package:conass/bloc/menu_home_bloc.dart';
import 'package:conass/bloc/post_bloc.dart';
import 'package:conass/componente/componente_menu_estados.dart';
import 'package:conass/componente/menu_categoria.dart';
import 'package:conass/componente/mais_noticias.dart';
import 'package:conass/util/barra_menu.dart';
import 'package:conass/util/connectionStatusSingleton.dart';
import 'package:conass/util/cores.dart';
import 'package:conass/util/rodape.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NewHome extends StatefulWidget {
  NewHome({Key? key}) : super(key: key);
  @override
  _NewHomeState createState() => _NewHomeState();
}

class _NewHomeState extends State<NewHome> {
  StreamSubscription? _connectionChangeStream;
  bool isOffline = false;

  @override
  void initState() {
    super.initState();
    ConnectionStatusSingleton connectionStatus =
        ConnectionStatusSingleton.getInstance();
    _connectionChangeStream =
        connectionStatus.connectionChange.listen(connectionChanged);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<BlocPostDestaque>(context, listen: false).loadPosts.add(null);
      Provider.of<BlocPostMaisNoticias>(context, listen: false)
          .loadPosts
          .add(null);
      Provider.of<MenuHomeBloc>(context, listen: false)
          .fetchInitialData(); // Certifique-se de que o método seja chamado

      // Não é necessário chamar fetchInitialData diretamente aqui
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
      height: screenHeight * 0.3, // Ajuste proporcional à altura da tela
      child: StreamBuilder<List<Post>>(
        stream: bloc.outPosts,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Container(
              padding: EdgeInsets.all(10),
              child: Center(
                child: Text(
                  snapshot.error.toString(),
                  style: TextStyle(fontSize: 20, color: Colors.grey),
                ),
              ),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Cores.LaranjaEscuro),
              ),
            );
          } else {
            return ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return Container(
                  //largura do conteiner
                  width: screenWidth * 0.8, // Largura proporcional à tela
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

  Widget _buildMaisNoticias(BuildContext context) {
    final bloc = Provider.of<BlocPostMaisNoticias>(context);
    double screenWidth = MediaQuery.of(context).size.width;

    return StreamBuilder<List<Post>>(
      stream: bloc.outPosts,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Container(
            padding: EdgeInsets.all(10),
            child: Center(
              child: Text(
                snapshot.error.toString(),
                style: TextStyle(fontSize: 20, color: Colors.grey),
              ),
            ),
          );
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Container();
        } else {
          return MaisNoticias(posts: snapshot.data ?? []);
        }
      },
    );
  }
}


// import 'dart:async';
// import 'package:bloc_pattern/bloc_pattern.dart';
// import 'package:conass/bloc/bloc_menu-estados.dart';
// import 'package:conass/bloc/bloc_post_destaque.dart';
// import 'package:conass/bloc/bloc_post_mais_noticias.dart';
// import 'package:conass/bloc/post_bloc.dart';
// import 'package:conass/componente/componente_menu_estados.dart';
// import 'package:conass/componente/menu_categoria.dart';
// import 'package:conass/componente/mais_noticias.dart';
// import 'package:conass/componente/new_post_card_p.dart';
// import 'package:conass/modelo/post.dart';
// import 'package:conass/util/barra_menu.dart';
// import 'package:conass/util/connectionStatusSingleton.dart';
// import 'package:conass/util/cores.dart';
// import 'package:conass/util/menu.dart';
// import 'package:conass/util/rodape.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';

// class NewHome extends StatefulWidget {
//   NewHome({Key? key}) : super(key: key);
//   @override
//   _NewHomeState createState() => _NewHomeState();
// }

// class _NewHomeState extends State<NewHome> {
//   StreamSubscription? _connectionChangeStream;
//   bool isOffline = false;

//   final PostsBloc blocCat6 = PostsBloc();
//   final BlocPostDestaque blocDestaque = BlocPostDestaque();
//   final BlocMenuEstados blocEstado = BlocMenuEstados();
//   final BlocPostMaisNoticias blocMaisNoticias = BlocPostMaisNoticias();

//   @override
//   initState() {
//     super.initState();
//     ConnectionStatusSingleton connectionStatus =
//         ConnectionStatusSingleton.getInstance();
//     _connectionChangeStream =
//         connectionStatus.connectionChange.listen(connectionChanged);
//     blocDestaque.loadPosts.add(null); // Carrega os posts destaque
//   }

//   void connectionChanged(dynamic hasConnection) {
//     setState(() {
//       isOffline = !hasConnection;
//       SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
//     });
//   }

//   GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

//   @override
//   Widget build(BuildContext context) {
//     SystemChrome.setPreferredOrientations([
//       DeviceOrientation.portraitUp,
//       DeviceOrientation.portraitDown,
//     ]);

//     if (isOffline) {
//       WidgetsBinding.instance.addPostFrameCallback((_) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text(
//               "Parece que você está offline. Verifique sua conexão com a internet e tente novamente.",
//               style: TextStyle(color: Colors.white, fontSize: 16),
//             ),
//             backgroundColor: Cores.LaranjaEscuro,
//             duration: Duration(seconds: 3),
//           ),
//         );
//       });
//     }

//     return Scaffold(
//       key: _scaffoldKey,
//       appBar: BarraMenu(context),
//       drawer: MenuList(),
//       bottomNavigationBar: Rodape(),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             _buildPostRowNoticias(blocDestaque),
//             _buildMaisNoticias(blocMaisNoticias),
//             MenuCategoria(),
//             ComponenteMenuEstados(),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildPostRowNoticias(BlocPostDestaque bloc) {
//     bloc.loadPosts.add(null);
//     return Container(
//       height: 250, // Define a altura específica para o container
//       child: StreamBuilder<List<Post>>(
//         stream: bloc.outPosts,
//         builder: (context, snapshot) {
//           if (snapshot.hasError) {
//             return Container(
//               padding: EdgeInsets.all(10),
//               child: Center(
//                 child: Text(
//                   snapshot.error.toString(),
//                   style: TextStyle(fontSize: 20, color: Colors.grey),
//                 ),
//               ),
//             );
//           } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//             return Center(
//               child: CircularProgressIndicator(
//                 valueColor: AlwaysStoppedAnimation<Color>(Cores.LaranjaEscuro),
//               ),
//             );
//           } else {
//             return GridView.builder(
//               scrollDirection: Axis.horizontal,
//               gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: 1,
//                 mainAxisSpacing: 10,
//                 childAspectRatio: 1,
//               ),
//               itemBuilder: (context, index) {
//                 return NewPostCardP(snapshot.data![index]);
//               },
//               itemCount: snapshot.data!.length,
//               padding: const EdgeInsets.all(8.0),
//             );
//           }
//         },
//       ),
//     );
//   }

//   Widget _buildMaisNoticias(BlocPostMaisNoticias bloc) {
//     return StreamBuilder<List<Post>>(
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
//           return Container(); // Caso sem dados, retorna um Container vazio
//         } else {
//           return MaisNoticias(posts: snapshot.data ?? []);
//         }
//       },
//     );
//   }
// }
