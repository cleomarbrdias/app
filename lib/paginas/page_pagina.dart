import 'package:provider/provider.dart';
import 'package:conass/componente/componente_page.dart';
import 'package:conass/modelo/modelo_pagina.dart';
import 'package:conass/util/barra_menu.dart';
import 'package:flutter/material.dart';
import 'package:conass/bloc/pagina_bloc.dart';
import 'package:conass/util/util.dart';
import 'package:shimmer/shimmer.dart';

class PagePagina extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;

  PagePagina({
    Key? key,
    required this.scaffoldKey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of<PaginaBloc>(context, listen: false);
    print("Entrou na Page Pagina");
    bloc.inPage.add(Util.pagina);

    return Scaffold(
      key: scaffoldKey,
      appBar: BarraMenu(context),
      body: StreamBuilder<ModeloPagina>(
        stream: bloc.outPage,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            print("Erro no snapshot: ${snapshot.error}");
            return Container(
              padding: EdgeInsets.all(24),
              child: Center(
                child: Text(
                  snapshot.error.toString(),
                  style: TextStyle(fontSize: 20, color: Colors.grey),
                ),
              ),
            );
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            print("Snapshot está aguardando dados");
            return _buildShimmerEffect();
          } else if (snapshot.hasData) {
            print("Dados do snapshot: ${snapshot.data}");
            final pagina = snapshot.data!;
            return ComponentePage(pagina);
          } else {
            print("Snapshot sem dados");
            return Container(
              child: Center(
                child: Text("Página não encontrada...."),
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

// ignore_for_file: public_member_api_docs, sort_constructors_first
// import 'package:bloc_pattern/bloc_pattern.dart';
// import 'package:conass/componente/componente_page.dart';
// import 'package:conass/modelo/modelo_pagina.dart';
// import 'package:conass/util/barra_menu.dart';
// import 'package:flutter/material.dart';
// import 'package:conass/bloc/pagina_bloc.dart';
// import 'package:conass/componente/pagina.dart';
// import 'package:conass/util/util.dart';
// import 'package:flutter/material.dart';

// class PagePagina extends StatelessWidget {
//   final GlobalKey<ScaffoldState> scaffoldKey;

//   PagePagina({
//     Key? key,
//     required this.scaffoldKey,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final bloc = BlocProvider.getBloc<PaginaBloc>();
//     print("Entrou na Page Pagina");
//     bloc.inPage.add(Util.pagina);

//     return Scaffold(
//       key: scaffoldKey,
//       appBar: BarraMenu(context),
//       body: StreamBuilder<ModeloPagina>(
//         stream: bloc.outPage,
//         builder: (context, snapshot) {
//           if (snapshot.hasError) {
//             print("Erro no snapshot: ${snapshot.error}");
//             return Container(
//               padding: EdgeInsets.all(24),
//               child: Center(
//                 child: Text(
//                   snapshot.error.toString(),
//                   style: TextStyle(fontSize: 20, color: Colors.grey),
//                 ),
//               ),
//             );
//           } else if (snapshot.connectionState == ConnectionState.waiting) {
//             print("Snapshot está aguardando dados");
//             return Center(
//               child: CircularProgressIndicator(
//                 valueColor: AlwaysStoppedAnimation<Color>(Color(0xff008979)),
//               ),
//             );
//           } else if (snapshot.hasData) {
//             print("Dados do snapshot: ${snapshot.data}");
//             final pagina = snapshot.data!;
//             return ComponentePage(pagina);
//           } else {
//             print("Snapshot sem dados");
//             return Container(
//               child: Center(
//                 child: Text("Página não encontrada...."),
//               ),
//             );
//           }
//         },
//       ),
//     );
//   }
// }

/*
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:conass/bloc/pagina_bloc.dart';
import 'package:conass/util/util.dart';
import 'package:flutter/material.dart';

class PagePagina extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;

  PagePagina({Key? key, required this.scaffoldKey}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.getBloc<PaginaBloc>();
    print("Entrou na Page Pagina");
    bloc.inPage.add(Util.pagina);

    return Scaffold(
        body: StreamBuilder(
            stream: bloc.outPage,
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
              } else if (!snapshot.hasData) {
                return Center(
                  child: Container(
                    color: Colors.white,
                    child: CircularProgressIndicator(
                      valueColor:
                          AlwaysStoppedAnimation<Color>(Color(0xff008979)),
                    ),
                  ),
                );
              } else if (!snapshot.hasData) {
                //return Page(snapshot.data);
                return Container(
                  child: Center(
                    child: Text("Coorriginar apresentação de pagina."),
                  ),
                );
              } else {
                return Container(
                    child: Center(
                  child: Text("Pagina não encontrada...."),
                ));
              }
            }));
  }
}
*/
