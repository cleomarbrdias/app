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

class PostCardVarios extends StatelessWidget {
  final Post post;
  PostCardVarios(this.post);

  @override
  Widget build(BuildContext context) {
    var dt = DateTime.parse(post.data ?? DateTime.now().toIso8601String());
    var forData = new DateFormat('dd/MM/yyyy');
    String resData = forData.format(dt);

    return Container(
      margin: const EdgeInsets.all(5),
      child: Row(
        children: <Widget>[
          Container(
            width: 100, // ajuste conforme necessário
            height: 100, // ajuste conforme necessário
            child: FadeInImage.memoryNetwork(
              placeholder: kTransparentImage,
              image: post.img.isNotEmpty ? post.img : 'images/placeholder.gif',
              fit: BoxFit.cover,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  InkWell(
                    onTap: () {
                      _onClickPost(context, post);
                    },
                    child: Text(
                      post.title,
                      style: TextStyle(
                        fontFamily: 'GoogleSans',
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'Publicado em | ' + resData,
                    style: TextStyle(
                      fontSize: 9,
                      color: const Color.fromARGB(255, 102, 102, 102),
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    post.resumo ?? "",
                    textAlign: TextAlign.justify,
                    style: TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ),
          ),
          Column(
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
                        Radius.circular(10),
                      ),
                    ),
                    backgroundColor: Cores.VerdeMedio,
                    label: Text(
                      "Leia Mais",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _onClickPost(BuildContext context, Post post) {
    push(context, Pagina(post));
  }
}
