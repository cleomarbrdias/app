import 'dart:io';

import 'package:provider/provider.dart';
import 'package:conass/bloc/favorito_bloc.dart';
import 'package:conass/componente/pagina.dart';
import 'package:conass/modelo/post.dart';
import 'package:conass/util/cores.dart';
import 'package:conass/util/push.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:intl/intl.dart';

class PostCardConassInforma extends StatelessWidget {
  final Post post;

  PostCardConassInforma(this.post);

  @override
  Widget build(BuildContext context) {
    var forData = DateFormat('dd/MM/yyyy');

    return Card(
      child: Container(
        margin: const EdgeInsets.all(5),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: InkWell(
                child: Text(
                  (post.title == null || post.title!.isEmpty)
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
                },
              ),
            ),
            Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  /*
                  child: Text(
                    'Publicado em | ' + resData,
                    textAlign: TextAlign.left,
                    style: TextStyle(fontSize: 9, color: Colors.grey),
                  ),
                  */
                ),
              ],
            ),
            ButtonTheme(
              child: ButtonBar(
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
                              color: Cores.VerdeMedio,
                            ),
                          )
                        : ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.zero,
                              backgroundColor: Colors.transparent,
                              elevation: 0, // Remove a sombra
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ), // Cor de fundo transparente
                            ),
                            onPressed: () {
                              Share.share(post.link ?? '');
                            },
                            child: Icon(
                              Icons.share,
                              color: Cores.VerdeMedio,
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
                          ),
                        ),
                        backgroundColor: Cores.PrimaryVerde,
                        label: Text(
                          "Leia Mais",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
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
