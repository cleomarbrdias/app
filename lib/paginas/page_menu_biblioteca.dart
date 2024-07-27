import 'package:conass/modelo/menu.dart';
import 'package:conass/util/barra_menu.dart';
import 'package:conass/util/cores.dart';
import 'package:conass/util/util.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:conass/bloc/biblioteca_bloc.dart';
import 'package:conass/bloc/menu_bloc.dart';

class MenuBiblioteca extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of<MenuBloc>(context);
    final blocB = Provider.of<BibliotecaBloc>(context);

    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: BarraMenu(context),
      body: StreamBuilder<List<Menu>>(
        stream: bloc.outMenu,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text("Erro ao carregar menu"),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Cores.PrimaryVerde),
              ),
            );
          } else {
            final List<Menu> menus = snapshot.data!;
            return Container(
              width: screenWidth,
              height:
                  screenWidth * 0.15, // Altura proporcional à largura da tela
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: menus.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  Menu menu = menus[index];
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    child: GestureDetector(
                      onTap: () {
                        Util.catBiblioteca = menu.id;
                        blocB.inCategoria.add(menu.id);
                        print(menu.id);
                        Navigator.pop(context);
                        // push(context, PageBiblioteca());
                      },
                      child: Container(
                        child: Chip(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(30),
                            ),
                            side: BorderSide(
                              color: Colors.grey.shade400,
                              width: 1,
                            ),
                          ),
                          backgroundColor: Colors.grey.shade200,
                          label: Text(
                            menu.slug,
                            style: TextStyle(
                              color: Cores.VerdeClaro,
                              fontFamily: 'GoogleSans',
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          }
        },
      ),
    );
  }
}

// class MenuBiblioteca extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final bloc = Provider.of<MenuBloc>(context);
//     final blocB = Provider.of<BibliotecaBloc>(context);

//     return Scaffold(
//       appBar: BarraMenu(context),
//       body: StreamBuilder(
//         stream: bloc.outMenu,
//         builder: (context, AsyncSnapshot snapshot) {
//           if (!snapshot.hasData) {
//             return Center(
//               child: CircularProgressIndicator(
//                 valueColor: AlwaysStoppedAnimation<Color>(Color(0xff008979)),
//               ),
//             );
//           }
//           if (snapshot.hasData) {
//             int cor;
//             var corTexto;
//             var corIcone;
//             List<Menu> menus = snapshot.data as List<Menu>; // Cast explícito

//             return ListView.separated(
//               itemBuilder: (context, index) {
//                 Menu menu = menus[index];
//                 if (menu.id == Util.catBiblioteca) {
//                   cor = 0xfff3902b;
//                   corTexto = Color(0xFFFFFFFF);
//                   corIcone = Color(0xFFFFFFFF);
//                 } else {
//                   cor = 0xffffff;
//                   corTexto = Color(0xFF000000);
//                   corIcone = Cores.PrimaryLaranja;
//                 }

//                 return Padding(
//                   padding: const EdgeInsets.symmetric(vertical: 10.0),
//                   child: InkWell(
//                     onTap: () {
//                       Util.catBiblioteca = menu.id;
//                       blocB.inCategoria.add(menu.id);
//                       print(menu.id);
//                       pop(context);
//                       //push(context, PageBiblioteca());
//                     },
//                     child: Container(
//                       color: Color(cor),
//                       height: 50,
//                       child: Row(
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         children: <Widget>[
//                           Padding(
//                             padding: const EdgeInsets.only(left: 10.0),
//                             child: Image.asset(
//                               "images/estrelaconass.png",
//                               color: corIcone,
//                               width: 20,
//                             ),
//                           ),
//                           SizedBox(width: 10),
//                           Expanded(
//                             child: Text(
//                               menu.slug.toUpperCase(),
//                               style: TextStyle(color: corTexto),
//                               textAlign: TextAlign.left,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 );
//               },
//               separatorBuilder: (context, index) => Divider(
//                 height: 4,
//                 color: Cores.PrimaryVerde,
//               ),
//               itemCount:
//                   menus.length, // Acesso condicional ao comprimento da lista
//             );
//           } else {
//             return Center(child: Text("Erro ao Carregar menu"));
//           }
//         },
//       ),
//     );
//   }
// }
