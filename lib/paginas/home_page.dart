import 'dart:async';
import 'package:conass/componente/new_post_card_noticias.dart';
import 'package:provider/provider.dart';
import 'package:conass/bloc/post_bloc.dart';
import 'package:conass/modelo/post.dart';
import 'package:conass/util/barra_menu.dart';
import 'package:conass/util/connectionStatusSingleton.dart';
import 'package:conass/util/cores.dart';
import 'package:conass/util/menu.dart';
import 'package:conass/util/rodape.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shimmer/shimmer.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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

    final bloc = Provider.of<PostsBloc>(context);

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
      body: StreamBuilder<List<Post>>(
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
              ),
            );
          } else if (!snapshot.hasData) {
            return _buildShimmerEffect();
          } else if (snapshot.data!.isEmpty) {
            return Center(
              child: Text(
                "Não há mais registros para carregar.",
                style: TextStyle(
                  color: Cores.LaranjaEscuro,
                  fontSize: 13,
                  fontFamily: 'GibsonMediumItalic',
                ),
              ),
            );
          } else {
            return NotificationListener<ScrollNotification>(
              onNotification: (ScrollNotification scrollInfo) {
                if (scrollInfo.metrics.pixels ==
                        scrollInfo.metrics.maxScrollExtent &&
                    bloc.hasMoreContent) {
                  bloc.inCategoria.add(null);
                }
                return false;
              },
              child: ListView.builder(
                itemCount: snapshot.data!.length + 1,
                itemBuilder: (context, index) {
                  if (index < snapshot.data!.length) {
                    return NewPostCardNoticias(snapshot.data![index]);
                  } else {
                    return Center(
                      child: bloc.hasMoreContent
                          ? _buildShimmerEffect()
                          : Text(
                              "Não há mais registros para carregar.",
                              style: TextStyle(
                                color: Cores.LaranjaEscuro,
                                fontSize: 13,
                                fontFamily: 'GibsonMediumItalic',
                              ),
                            ),
                    );
                  }
                },
              ),
            );
          }
        },
      ),
    );
  }

  Widget _buildShimmerEffect() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: ListView.builder(
        itemCount: 5, // Número de itens de carregamento falso
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: double.infinity,
              height: 100.0,
              color: Colors.white,
            ),
          );
        },
      ),
    );
  }
}


// class HomePage extends StatefulWidget {
//   HomePage({Key? key}) : super(key: key);
//   @override
//   _HomePageState createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   StreamSubscription? _connectionChangeStream;
//   bool isOffline = false;

//   @override
//   initState() {
//     super.initState();

//     ConnectionStatusSingleton connectionStatus =
//         ConnectionStatusSingleton.getInstance();
//     _connectionChangeStream =
//         connectionStatus.connectionChange.listen(connectionChanged);
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

//     final bloc = Provider.of<PostsBloc>(context);

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
//       body: StreamBuilder<List<Post>>(
//         stream: bloc.outPosts,
//         builder: (context, snapshot) {
//           if (snapshot.hasError) {
//             return Container(
//               padding: EdgeInsets.all(24),
//               child: Center(
//                 child: Text(
//                   snapshot.error.toString(),
//                   style: TextStyle(fontSize: 20, color: Colors.grey),
//                 ),
//               ),
//             );
//           } else if (!snapshot.hasData) {
//             return Center(
//               child: CircularProgressIndicator(
//                 valueColor: AlwaysStoppedAnimation<Color>(Cores.LaranjaEscuro),
//               ),
//             );
//           } else if (snapshot.data!.isEmpty) {
//             print(snapshot.data);
//             return Center(
//               child: Text(
//                 "Não há mais registros para carregar.",
//                 style: TextStyle(
//                   color: Cores.LaranjaEscuro,
//                   fontSize: 13,
//                   fontFamily: 'GibsonMediumItalic',
//                 ),
//               ),
//             );
//           } else {
//             return NotificationListener<ScrollNotification>(
//               onNotification: (ScrollNotification scrollInfo) {
//                 if (scrollInfo.metrics.pixels ==
//                     scrollInfo.metrics.maxScrollExtent) {
//                   bloc.inCategoria.add(null);
//                 }
//                 return false;
//               },
//               child: ListView.builder(
//                 itemCount: snapshot.data!.length + 1,
//                 itemBuilder: (context, index) {
//                   if (index < snapshot.data!.length) {
//                     return NewPostCardNoticias(snapshot.data![index]);
//                   } else {
//                     return Center(
//                       child: CircularProgressIndicator(
//                         valueColor:
//                             AlwaysStoppedAnimation<Color>(Cores.LaranjaEscuro),
//                       ),
//                     );
//                   }
//                 },
//               ),
//             );
//           }
//         },
//       ),
//     );
//   }
// }

// import 'dart:async';
// import 'package:bloc_pattern/bloc_pattern.dart';
// import 'package:conass/bloc/post_bloc.dart';
// import 'package:conass/componente/post_card.dart';
// import 'package:conass/componente/post_card_conass_informa.dart';
// import 'package:conass/componente/post_card_notas_conass.dart';
// import 'package:conass/modelo/post.dart';
// import 'package:conass/util/barra_menu.dart';
// import 'package:conass/util/connectionStatusSingleton.dart';
// import 'package:conass/util/cores.dart';
// import 'package:conass/util/menu.dart';
// import 'package:conass/util/rodape.dart';
// import 'package:conass/util/util.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';

// class HomePage extends StatefulWidget {
//   HomePage({Key? key}) : super(key: key);
//   @override
//   _HomePageState createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   StreamSubscription? _connectionChangeStream;
//   bool isOffline = false;

//   @override
//   initState() {
//     super.initState();

//     ConnectionStatusSingleton connectionStatus =
//         ConnectionStatusSingleton.getInstance();
//     _connectionChangeStream =
//         connectionStatus.connectionChange.listen(connectionChanged);
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

//     final bloc = BlocProvider.getBloc<PostsBloc>();

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
//       body: StreamBuilder<List<Post>>(
//           stream: bloc.outPosts,
//           builder: (context, snapshot) {
//             if (snapshot.hasError) {
//               return Container(
//                   padding: EdgeInsets.all(24),
//                   child: Center(
//                     child: Text(
//                       snapshot.error.toString(),
//                       style: TextStyle(fontSize: 20, color: Colors.grey),
//                     ),
//                   ));
//             } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//               return Center(
//                 child: CircularProgressIndicator(
//                   valueColor:
//                       AlwaysStoppedAnimation<Color>(Cores.LaranjaEscuro),
//                 ),
//               );
//             } else {
//               return ListView.builder(
//                 itemBuilder: (context, index) {
//                   if (index < snapshot.data!.length) {
//                     if (Util.cat == 5) {
//                       return PostCardConassInforma(snapshot.data![index]);
//                     } else if (Util.cat == 118) {
//                       return PostCardNotasConass(snapshot.data![index]);
//                     } else {
//                       return PostCard(snapshot.data![index]);
//                     }
//                   } else if (index > 1) {
//                     bloc.inCategoria.add(null);
//                     return Container(
//                       height: 40,
//                       width: 40,
//                       alignment: Alignment.center,
//                       child: CircularProgressIndicator(
//                         valueColor:
//                             AlwaysStoppedAnimation<Color>(Cores.LaranjaEscuro),
//                       ),
//                     );
//                   } else {
//                     return Center(
//                       child: Text("erro"),
//                     );
//                   }
//                 },
//                 itemCount: snapshot.data!.length + 1,
//               );
//             }
//           }),
//     );
//   }
// }
