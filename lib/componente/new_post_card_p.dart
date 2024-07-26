import 'package:conass/componente/pagina.dart';
import 'package:conass/modelo/post.dart';
import 'package:conass/util/cores.dart';
import 'package:conass/util/push.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:share/share.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart'; // Import necessário
import 'dart:io';

class NewPostCardP extends StatelessWidget {
  final Post post;
  NewPostCardP(this.post);

  @override
  Widget build(BuildContext context) {
    var dt = DateTime.parse(post.data ?? DateTime.now().toIso8601String());
    var forData = DateFormat('dd/MM/yyyy');
    String resData = forData.format(dt);

    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return InkWell(
      onTap: () {
        _onClickPost(context, post);
      },
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 0,
              blurRadius: 10,
              offset: Offset(0, 1),
            ),
          ],
        ),
        margin: EdgeInsets.symmetric(
            //margem suprior e inferior
            horizontal: screenWidth * 0.01,
            vertical: screenHeight * 0.01),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Stack(
              alignment: Alignment.bottomLeft,
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: FadeInImage.memoryNetwork(
                    placeholder: kTransparentImage,
                    image: post.img ?? 'images/placeholder.gif',
                    width: double.infinity,
                    height: screenHeight *
                        0.25, // Ajuste proporcional à altura da tela
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: screenHeight *
                        0.25, // Ajuste proporcional à altura da tela
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                          10.0), // Adiciona a borda ao Container
                      border: Border.all(
                          color: Colors.grey.withOpacity(0.10), width: 1),
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [
                          Colors.black.withOpacity(0.5),
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: screenHeight * 0.01,
                        horizontal: screenWidth * 0.02),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color(0xff258670).withOpacity(0.8),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      padding: EdgeInsets.symmetric(
                          vertical: screenHeight * 0.01,
                          horizontal: screenWidth * 0.02),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Text(
                              post.title ?? '',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                              ),
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          // Icon(
                          //   Icons.bookmark_border,
                          //   color: Colors.white,
                          // ),
                        ],
                      ),
                    ),
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
    Navigator.push(
      context,
      PageTransition(
        type: PageTransitionType.rightToLeft,
        child: Pagina(post),
        duration: Duration(milliseconds: 500),
      ),
    );
  }
}
