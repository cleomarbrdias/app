import 'package:conass/componente/pagina.dart';
import 'package:provider/provider.dart';
import 'package:conass/bloc/favorito_bloc.dart';
import 'package:conass/componente/new_post_card_noticias.dart';
import 'package:conass/modelo/post.dart';
import 'package:conass/util/push.dart';
import 'package:flutter/material.dart';

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
        //backgroundColor: Color(0xff008979),
      ),
      body: Consumer<FavoritoBloc>(
        builder: (context, bloc, child) {
          final favoritos = bloc.favoritos;

          if (favoritos.isEmpty) {
            return Center(
              child: Text("Nenhum favorito adicionado"),
            );
          }

          return ListView(
            children: favoritos.values.map((v) {
              return InkWell(
                onTap: () {
                  _onClickPost(context, v);
                },
                onLongPress: () {
                  bloc.toggleFavorite(v);
                },
                child: NewPostCardNoticias(v),
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
