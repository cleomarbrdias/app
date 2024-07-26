import 'dart:async';
import 'package:conass/modelo/post_secretarios.dart';
import 'package:provider/provider.dart';
import 'package:conass/bloc/post_secretarios_bloc.dart';
import 'package:conass/componente/post_card_gestores.dart';
import 'package:conass/util/barra_menu.dart';
import 'package:conass/util/connectionStatusSingleton.dart';
import 'package:conass/util/cores.dart';
import 'package:conass/util/menu.dart';
import 'package:conass/util/rodape.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PageSecretarios extends StatefulWidget {
  PageSecretarios({Key? key}) : super(key: key);
  @override
  _PageSecretariosState createState() => _PageSecretariosState();
}

class _PageSecretariosState extends State<PageSecretarios> {
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

    final bloc = Provider.of<PostSecretariosBloc>(context);
    print("Pagina Secretarios");
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
      body: StreamBuilder<List<PostSecretarios>>(
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
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Cores.LaranjaEscuro),
              ),
            );
          } else {
            return ListView.builder(
              itemBuilder: (context, index) {
                if (index == 0) {
                  // Texto adicional no início da lista
                  return Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      'Secretarias Estaduais',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'GoogleSansMediumItalic',
                        fontWeight: FontWeight.w600,
                        color: Cores.LaranjaEscuro,
                      ),
                    ),
                  );
                } else {
                  // Corrigir o índice para o snapshot.data
                  int dataIndex = index - 1;
                  if (dataIndex < snapshot.data!.length) {
                    return PostCardGestores(
                      snapshot.data![dataIndex],
                    );
                  } else {
                    return Center(
                      child: Text("erro"),
                    );
                  }
                }
              },
              itemCount: snapshot.data!.length + 1,
            );
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    _connectionChangeStream?.cancel();
    super.dispose();
  }
}


// import 'dart:async';
// import 'package:bloc_pattern/bloc_pattern.dart';
// import 'package:conass/bloc/post_secretarios_bloc.dart';
// import 'package:conass/componente/post_card_gestores.dart';
// import 'package:conass/componente/post_card_ses.dart';
// import 'package:conass/util/barra_menu.dart';
// import 'package:conass/util/connectionStatusSingleton.dart';
// import 'package:conass/util/cores.dart';
// import 'package:conass/util/menu.dart';
// import 'package:conass/util/rodape.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';

// class PageSecretarios extends StatefulWidget {
//   PageSecretarios({Key? key}) : super(key: key);
//   @override
//   _PageSecretariosState createState() => _PageSecretariosState();
// }

// class _PageSecretariosState extends State<PageSecretarios> {
//   // ignore: unused_field, cancel_subscriptions
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

//     final bloc = BlocProvider.getBloc<PostSecretariosBloc>();
//     print("Pagina Secretarios");
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
//         key: _scaffoldKey,
//         appBar: BarraMenu(context),
//         drawer: MenuList(),
//         bottomNavigationBar: Rodape(),
//         body: StreamBuilder(
//             stream: bloc.outPosts,
//             builder: (context, snapshot) {
//               if (snapshot.hasError) {
//                 return Container(
//                     padding: EdgeInsets.all(24),
//                     child: Center(
//                       child: Text(
//                         snapshot.error.toString(),
//                         style: TextStyle(fontSize: 20, color: Colors.grey),
//                       ),
//                     ));
//               } else if (!snapshot.hasData || snapshot.data.length == 0) {
//                 return Center(
//                   child: CircularProgressIndicator(
//                     valueColor:
//                         AlwaysStoppedAnimation<Color>(Cores.LaranjaEscuro),
//                   ),
//                 );
//               } else if (snapshot.hasData) {
//                 print(snapshot.data);
//                 return ListView.builder(
//                   itemBuilder: (context, index) {
//                     if (index == 0) {
//                       // Texto adicional no início da lista
//                       return Padding(
//                         padding: EdgeInsets.all(16.0),
//                         child: Text(
//                           'Secretarias Estaduais',
//                           textAlign: TextAlign.center,
//                           style: TextStyle(
//                             fontSize: 20,
//                             fontFamily: 'GoogleSansMediumItalic',
//                             fontWeight: FontWeight.w600,
//                             color: Cores.LaranjaEscuro,
//                           ),
//                         ),
//                       );
//                     } else {
//                       // Corrigir o índice para o snapshot.data
//                       int dataIndex = index - 1;
//                       if (dataIndex < snapshot.data.length) {
//                         return PostCardGestores(
//                           snapshot.data[dataIndex],
//                         );
//                       } else {
//                         return Center(
//                           child: Text("erro"),
//                         );
//                       }
//                     }
//                   },
//                   itemCount: snapshot.data.length + 1,
//                 );
//               } else {
//                 return Container(
//                   child: Text("Nenhuma categoria carregada..."),
//                 );
//               }
//             }));
//   }
// }
