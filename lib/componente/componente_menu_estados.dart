import 'package:conass/bloc/menu_home_bloc.dart';
import 'package:conass/bloc/post_bloc.dart';
import 'package:provider/provider.dart';
import '../data/dadosEstados.dart'; // Importando o arquivo de dados
import 'package:conass/modelo/menu_estados.dart';
import 'package:conass/paginas/home_page.dart';
import 'package:conass/util/cores.dart';
import 'package:conass/util/util.dart';
import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

class ComponenteMenuEstados extends StatelessWidget {
  Future<List<MenuEstados>> _loadMenuEstados() async {
    final List<dynamic> jsonData = dadosEstados;
    return jsonData.map((item) => MenuEstados.fromJson(item)).toList();
  }

  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of<PostsBloc>(context);
    double screenWidth = MediaQuery.of(context).size.width;

    return Container(
      color: Color(0xfff4f4f4),
      width: screenWidth,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 30, 0, 20),
            child: Center(
              child: Text(
                'Aconteceu nos estados',
                style: TextStyle(
                  color: Cores.LaranjaEscuro,
                  fontSize: 15,
                  fontFamily: 'GoogleSansMediumItalic',
                ),
              ),
            ),
          ),
          Container(
            height: screenWidth * 0.25, // Ajuste proporcional à largura da tela
            child: FutureBuilder<List<MenuEstados>>(
              future: _loadMenuEstados(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text("Erro ao carregar menu: ${snapshot.error}"),
                  );
                } else if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(
                      valueColor:
                          AlwaysStoppedAnimation<Color>(Cores.PrimaryVerde),
                    ),
                  );
                } else {
                  final List<MenuEstados> menus = snapshot.data!;
                  if (menus.isEmpty) {
                    return Center(
                      child: Text("Nenhum item encontrado"),
                    );
                  }
                  return ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: menus.length,
                    itemBuilder: (context, index) {
                      MenuEstados menu = menus[index];
                      if (menu.bandeira == null || menu.bandeira!.isEmpty) {
                        return SizedBox
                            .shrink(); // Não exibe o item se meta estiver vazio
                      }
                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: InkWell(
                          onTap: () {
                            Util.cat = menu.id;
                            print(Util.cat);
                            bloc.inCategoria
                                .add(Util.cat); // Atualizado para usar inMenu
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => HomePage(),
                              ),
                            );
                          },
                          child: Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.3),
                                      spreadRadius: 0,
                                      blurRadius: 5,
                                      offset: Offset(
                                          0, 1), // changes position of shadow
                                    ),
                                  ],
                                ),
                                width: screenWidth *
                                    0.15, // Ajuste proporcional à largura da tela
                                height: screenWidth *
                                    0.1, // Ajuste proporcional à largura da tela
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: FadeInImage.memoryNetwork(
                                    placeholder: kTransparentImage,
                                    image: menu.bandeira!,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                menu.title,
                                style: TextStyle(
                                  color: Cores.LaranjaEscuro,
                                  fontSize: 12, // Ajuste conforme necessário
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}



// import 'dart:convert';
// import 'package:bloc_pattern/bloc_pattern.dart';
// import 'package:conass/bloc/post_bloc.dart';

// import '../data/dadosEstados.dart'; // Importando o arquivo de dados

// import 'package:conass/modelo/menu_estados.dart';
// import 'package:conass/paginas/home_page.dart';
// import 'package:conass/util/cores.dart';
// import 'package:conass/util/util.dart';
// import 'package:flutter/material.dart';
// import 'package:transparent_image/transparent_image.dart';

// class ComponenteMenuEstados extends StatelessWidget {
//   Future<List<MenuEstados>> _loadMenuEstados() async {
//     // Usando os dados diretamente do arquivo Dart importado
//     final List<dynamic> jsonData = dadosEstados;
//     return jsonData.map((item) => MenuEstados.fromJson(item)).toList();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final bloc = BlocProvider.getBloc<PostsBloc>();
//     return Container(
//       color: Color(0xfff4f4f4),
//       width: MediaQuery.of(context).size.width,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Padding(
//             padding: const EdgeInsets.fromLTRB(20, 20, 0, 10),
//             child: Center(
//               child: Text(
//                 'Aconteceu nos estados',
//                 style: TextStyle(
//                   color: Cores.LaranjaEscuro,
//                   fontSize: 15,
//                   fontFamily: 'GoogleSansMediumItalic',
//                 ),
//               ),
//             ),
//           ),
//           Container(
//             height: 100, // Ajuste conforme necessário
//             child: FutureBuilder<List<MenuEstados>>(
//               future: _loadMenuEstados(),
//               builder: (context, snapshot) {
//                 if (snapshot.hasError) {
//                   return Center(
//                     child: Text("Erro ao carregar menu: ${snapshot.error}"),
//                   );
//                 } else if (!snapshot.hasData) {
//                   return Center(
//                     child: CircularProgressIndicator(
//                       valueColor:
//                           AlwaysStoppedAnimation<Color>(Cores.PrimaryVerde),
//                     ),
//                   );
//                 } else {
//                   final List<MenuEstados> menus = snapshot.data!;
//                   if (menus.isEmpty) {
//                     return Center(
//                       child: Text("Nenhum item encontrado"),
//                     );
//                   }
//                   return ListView.builder(
//                     shrinkWrap: true,
//                     scrollDirection: Axis.horizontal,
//                     itemCount: menus.length,
//                     itemBuilder: (context, index) {
//                       MenuEstados menu = menus[index];
//                       if (menu.bandeira == null || menu.bandeira!.isEmpty) {
//                         return SizedBox
//                             .shrink(); // Não exibe o item se meta estiver vazio
//                       }
//                       return Padding(
//                         padding: EdgeInsets.symmetric(horizontal: 10),
//                         child: InkWell(
//                           onTap: () {
//                             Util.cat = menu.id;
//                             print(Util.cat);
//                             bloc.inCategoria.add(Util.cat);
//                             Navigator.pushReplacement(
//                               context,
//                               MaterialPageRoute(
//                                 builder: (context) => HomePage(),
//                               ),
//                             );
//                           },
//                           child: Column(
//                             children: [
//                               Container(
//                                 decoration: BoxDecoration(
//                                   boxShadow: [
//                                     BoxShadow(
//                                       color: Colors.black.withOpacity(0.3),
//                                       spreadRadius: 0,
//                                       blurRadius: 5,
//                                       offset: Offset(
//                                           0, 1), // changes position of shadow
//                                     ),
//                                   ],
//                                 ),
//                                 width: 60, // Ajuste conforme necessário
//                                 height: 40, // Ajuste conforme necessário
//                                 child: ClipRRect(
//                                   borderRadius: BorderRadius.circular(8),
//                                   child: FadeInImage.memoryNetwork(
//                                     placeholder: kTransparentImage,
//                                     image: menu.bandeira!,
//                                     fit: BoxFit.cover,
//                                   ),
//                                 ),
//                               ),
//                               SizedBox(height: 8),
//                               Text(
//                                 menu.title,
//                                 style: TextStyle(
//                                   color: Cores.LaranjaEscuro,
//                                   fontSize: 12, // Ajuste conforme necessário
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       );
//                     },
//                   );
//                 }
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
