import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:conass/bloc/favorito_bloc.dart';
import 'package:conass/componente/pagina.dart';
import 'package:conass/modelo/post.dart';
import 'package:conass/util/cores.dart';
import 'package:conass/util/push.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:share/share.dart';
import 'package:intl/intl.dart';
import 'dart:io';

class PostCard extends StatelessWidget {
  final Post post;
  PostCard(this.post, {required ScrollController scrollController});

  @override
  Widget build(BuildContext context) {
    print("Entrou no postCard - Normal");

    var dt = DateTime.parse(post.data ?? DateTime.now().toIso8601String());
    var forData = new DateFormat('dd/MM/yyyy');
    String resData = forData.format(dt);

    return Card(
      child: Container(
        margin: const EdgeInsets.all(5),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: post.categoria != 5
                  ? InkWell(
                      child: Text(
                        (post.title == null || post.title.isEmpty)
                            ? ''
                            : post.title,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'GoogleSans',
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                      onTap: () {
                        _onClickPost(context, post);
                      })
                  : InkWell(
                      child: Text(
                        (post.title == null || post.title.isEmpty)
                            ? ''
                            : post.title,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontFamily: 'GoogleSans',
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                      onTap: () {
                        _onClickPost(context, post);
                      }),
            ),
            post.categoria != 5
                ? Stack(
                    alignment: Alignment.bottomLeft,
                    children: <Widget>[
                      Center(
                        child: new FadeInImage.memoryNetwork(
                            fit: BoxFit.cover,
                            placeholder: kTransparentImage,
                            // ignore: unrelated_type_equality_checks
                            image:
                                // ignore: unrelated_type_equality_checks
                                post.img == 0
                                    ? 'images/placeholder.gif'
                                    : post.img),
                      ),
                      Container(
                          decoration: new BoxDecoration(
                            color: Cores.PrimaryVerde.withOpacity(0.8),
                            borderRadius: new BorderRadius.only(
                                topLeft: const Radius.circular(3.0),
                                topRight: const Radius.circular(3.0),
                                bottomLeft: const Radius.circular(3.0),
                                bottomRight: const Radius.circular(3.0)),
                          ),
                          width: 50,
                          height: 20,
                          child: Padding(
                            padding: EdgeInsets.only(
                                left: 8.0, top: 2.0, right: 8.0),
                            child: Text(
                              post.categoria.toString(),
                              style:
                                  TextStyle(color: Colors.white, fontSize: 10),
                            ),
                          ))
                    ],
                  )
                : SizedBox(),
            Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Text(
                    'Publicado em | ' + resData,
                    textAlign: TextAlign.left,
                    style: TextStyle(fontSize: 9, color: Colors.grey),
                  ),
                ),
              ],
            ),
            post.categoria != 5
                ? Padding(
                    padding: const EdgeInsets.only(top: 5.0),
                    child: Text(
                      post.resumo ?? "",
                      textAlign: TextAlign.justify,
                      style: TextStyle(fontSize: 14),
                    ),
                  )
                : SizedBox(),
            ButtonBar(
              children: <Widget>[
                Container(
                  width: 25,
                  height: 33,
                  child: Platform.isIOS
                      ? CupertinoButton(
                          padding: EdgeInsets.zero,
                          onPressed: () {
                            Share.share(post.link ?? '');
                          },
                          child: Icon(
                            Icons.share,
                            color: Cores.PrimaryVerde,
                          ),
                        )
                      : ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.zero,
                            backgroundColor: Colors.transparent,
                            elevation: 0, // Remove a sombra
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(3),
                            ), // Cor de fundo transparente
                          ),
                          onPressed: () {
                            Share.share(post.link ?? '');
                          },
                          child: Icon(
                            Icons.share,
                            color: Cores.PrimaryVerde,
                          ),
                        ),
                ),
                Container(
                  child: GestureDetector(
                    onTap: () {
                      _onClickPost(context, post);
                    },
                    child: Chip(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                          Radius.circular(3),
                        )),
                        backgroundColor: Cores.PrimaryVerde,
                        label: Text(
                          "Leia Mais",
                          style: TextStyle(color: Colors.white),
                        )),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _onClickPost(BuildContext context, Post post) {
    push(context, Pagina(post));
  }
}

/*
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:conass/bloc/favorito_bloc.dart';
import 'package:conass/componente/pagina.dart';
import 'package:conass/modelo/post.dart';
import 'package:conass/util/cores.dart';
import 'package:conass/util/push.dart';
import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:share/share.dart';
import 'package:intl/intl.dart';
import 'package:flutter_html/flutter_html.dart';

class PostCard extends StatelessWidget {
  final Post post;
  PostCard(this.post);

  @override
  Widget build(BuildContext context) {
    print("Entrou no postCard - Normal");

    //final bloc = BlocProvider.getBloc<FavoritoBloc>();

    var dt = DateTime.parse(post.data. ?? DateTime.now().toIso8601String());
    print(dt);
    var forData = new DateFormat('dd/MM/yyyy');
    String resData = forData.format(dt);

    return Card(
      child: Container(
        margin: const EdgeInsets.all(5),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: InkWell(
                  child: Text(
                    (post.title == null || post.title!.trim().isEmpty)
                        ? ''
                        : post.title!,
                    style: TextStyle(
                      fontFamily: 'GoogleSans',
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                  onTap: () {
                    _onClickPost(context, post);
                  }),
            ),
            Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Text(
                    'Publicado em | ' + resData,
                    textAlign: TextAlign.left,
                    style: TextStyle(fontSize: 9, color: Colors.grey),
                  ),
                ),
              ],
            ),
            ButtonTheme(
              child: ButtonBar(
                children: <Widget>[
                  new Container(
                    width: 25,
                    height: 33,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.fromLTRB(0, 1, 0, 1),
                        ),
                        onPressed: () {
                          Share.share(
                            post.link ?? '',
                          );
                        },
                        child: Icon(
                          Icons.share,
                          color: Cores.PrimaryVerde,
                        )),
                  ),
                  new Container(
                    child: GestureDetector(
                      onTap: () {
                        _onClickPost(context, post);
                      },
                      child: Chip(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                            Radius.circular(3),
                          )),
                          backgroundColor: Cores.PrimaryVerde,
                          label: Text(
                            "Leia Mais",
                            style: TextStyle(color: Colors.white),
                          )),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onClickPost(BuildContext context, Post post) {
    push(context, Pagina(post));
  }
}
*/
