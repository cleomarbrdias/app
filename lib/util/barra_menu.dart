import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:conass/bloc/favorito_bloc.dart';
import 'package:conass/delegates/pesquisa.dart';
import 'package:conass/modelo/post.dart';
import 'package:conass/util/cores.dart';
import 'package:flutter/material.dart';

// ignore: non_constant_identifier_names
PreferredSizeWidget BarraMenu(BuildContext context) {
  return AppBar(
    //title: Text(title),
    title: Image.asset(
      'images/logo-mono.png', // Substitua pelo caminho da sua imagem
      height: 40, // Ajuste o tamanho da imagem conforme necessário
    ),
    centerTitle: true,
    elevation: 0,
    //backgroundColor: Color(0xff008979),
    backgroundColor: Cores.PrimaryVerde,
    actions: <Widget>[
      Align(
        //favoritos
        alignment: Alignment.center,
        child: StreamBuilder<Map<String, Post>>(
            stream: BlocProvider.getBloc<FavoritoBloc>().outFav,
            /*stream: BlocProvider.of<FavoritoBloc>(context).outFav,*/
            builder: (context, snapshot) {
              if (snapshot.hasData)
                return Text("${snapshot.data!.length}");
              else
                return Container();
            }),
      ),
      /*
      IconButton(
          icon: Image.asset(
            "images/estrelaconass.png",
            width: 20,
            height: 20,
          ),
          onPressed: () {
            push(context, Favoritos());
          }),*/
      IconButton(
          icon: Icon(Icons.search),
          onPressed: () async {
            String? result =
                await showSearch(context: context, delegate: Pesquisa());
            if (result != null) {
              _onClickPesquisa(context, result);
            }
          })
    ],
  );
}

_onClickPesquisa(BuildContext context, String result) {
  // push(context, HomePesquisa(result));
}
