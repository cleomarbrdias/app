import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:conass/componente/pagina.dart';
import 'package:conass/modelo/post.dart';
import 'package:conass/util/cores.dart';
import 'package:conass/util/push.dart';
import 'package:page_transition/page_transition.dart'; // Import necessário

class MaisNoticias extends StatelessWidget {
  final List<Post> posts;

  MaisNoticias({required this.posts});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double cardWidth = screenWidth * 0.35;

    return Container(
      color: Color(0xfff2faf8), // Cor de fundo do container principal
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 5, 0, 20),
            child: Center(
              child: Text(
                'Mais Notícias',
                style: TextStyle(
                  color: Cores.LaranjaEscuro,
                  fontSize: 15,
                  fontFamily: 'GibsonMediumItalic',
                ),
              ),
            ),
          ),
          Container(
            height: cardWidth, // Ajuste proporcional à largura dos cards
            margin: EdgeInsets.only(bottom: 10), // Adiciona margem inferior
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: posts.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    _onClickPost(context, posts[index]);
                  },
                  child: Container(
                    width: cardWidth, // Largura dos cards proporcional à tela
                    margin: EdgeInsets.symmetric(horizontal: 8.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: Stack(
                        children: [
                          FadeInImage.memoryNetwork(
                            placeholder: kTransparentImage,
                            image: posts[index].img ?? 'images/placeholder.gif',
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: double.infinity,
                          ),
                          Positioned(
                            bottom: 0,
                            left: 0,
                            right: 0,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Color(0xff894124).withOpacity(0.8),
                                //borderRadius: BorderRadius.circular(20.0),
                              ),
                              padding: EdgeInsets.symmetric(
                                  vertical: screenWidth * 0.01,
                                  horizontal: screenWidth * 0.02),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Flexible(
                                    child: Text(
                                      posts[index].title ?? '',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                      ),
                                      //determina a altura e linhas do title
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
                            // child: Container(
                            //   height:
                            //       0.3 * cardWidth, // 30% da altura do container
                            //   color: Color(0xff894124)
                            //       .withOpacity(0.8), // Fundo laranja
                            //   padding: EdgeInsets.all(8.0),
                            //   child: Text(
                            //     posts[index].title ?? '',
                            //     style: TextStyle(
                            //       color: Colors.white,
                            //       fontFamily: 'GoogleSansMedium',
                            //       fontSize: 10,
                            //     ),
                            //   ),
                            // ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
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
