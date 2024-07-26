import 'package:provider/provider.dart';
import 'package:conass/bloc/favorito_bloc.dart';
import 'package:conass/componente/pagina.dart';
import 'package:conass/modelo/post.dart';
import 'package:conass/util/push.dart';
import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

class Favoritos extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of<FavoritoBloc>(context);
    print("Pagina Favoritos");

    return Scaffold(
      appBar: AppBar(
        title: Text("Favoritos"),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Color(0xff008979),
      ),
      body: StreamBuilder<Map<String, Post>>(
        initialData: {},
        stream: bloc.outFav,
        builder: (context, snapshot) {
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: Text("Nenhum favorito adicionado"),
            );
          }
          return ListView(
            children: snapshot.data!.values.map((v) {
              return InkWell(
                onTap: () {
                  _onClickPost(context, v);
                },
                onLongPress: () {
                  bloc.toggleFavorite(v);
                },
                child: Card(
                  child: Container(
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Text(
                            v.title ?? '',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                        FadeInImage.memoryNetwork(
                          placeholder: kTransparentImage,
                          image: v.img == null || v.img == "0"
                              ? 'assets/images/placeholder.gif'
                              : v.img!,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 5.0),
                          //child: Text(v.resumo ?? ''),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }

  void _onClickPost(BuildContext context, Post post) {
    push(context, Pagina(post));
  }
}

// import 'package:bloc_pattern/bloc_pattern.dart';
// import 'package:conass/bloc/favorito_bloc.dart';
// import 'package:conass/componente/pagina.dart';
// import 'package:conass/modelo/post.dart';
// import 'package:conass/util/push.dart';

// import 'package:flutter/material.dart';
// import 'package:transparent_image/transparent_image.dart';

// class Favoritos extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final bloc = BlocProvider.getBloc<FavoritoBloc>();
//     print("Pagina Favoritos");

//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Favoritos"),
//         centerTitle: true,
//         elevation: 0,
//         backgroundColor: Color(0xff008979),
//       ),
//       body: StreamBuilder<Map<String, Post>>(
//           initialData: {},
//           stream: bloc.outFav,
//           builder: (context, snapshot) {
//             return ListView(
//               children: snapshot.data!.values.map((v) {
//                 return InkWell(
//                   onTap: () {
//                     _onClickPost(context, v);
//                   },
//                   onLongPress: () {
//                     bloc.toggleFavorite(v);
//                   },
//                   child: Card(
//                       child: Container(
//                     child: Column(
//                       children: <Widget>[
//                         Padding(
//                           padding: const EdgeInsets.all(5.0),
//                           child: Text(
//                             v.title,
//                             style: TextStyle(
//                                 fontSize: 18, fontWeight: FontWeight.bold),
//                           ),
//                         ),
//                         new FadeInImage.memoryNetwork(
//                             placeholder: kTransparentImage,
//                             // ignore: unrelated_type_equality_checks
//                             image: v.img == 0
//                                 ? 'assets/images/placeholder.gif'
//                                 : v.img),
//                         Padding(
//                           padding: const EdgeInsets.only(top: 5.0),
//                           /*child: Text(v.resumo),*/
//                         ),
//                       ],
//                     ),
//                   )),
//                 );
//               }).toList(),
//             );
//           }),
//     );
//   }

//   void _onClickPost(BuildContext context, Post post) {
//     push(context, Pagina(post));
//   }
// }
