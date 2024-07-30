import 'package:conass/componente/pagina.dart';
import 'package:conass/modelo/post.dart';
import 'package:conass/util/cores.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';
import 'package:transparent_image/transparent_image.dart';

class NewPostCardNoticias extends StatelessWidget {
  final Post post;
  NewPostCardNoticias(this.post);

  @override
  Widget build(BuildContext context) {
    var dt = DateTime.parse(post.data ?? DateTime.now().toIso8601String());
    var forData = DateFormat('dd \'de\' MMMM \'de\' yyyy', 'pt_BR');
    String resData = forData.format(dt);
    bool shouldDisplayImage =
        post.img != "https://www.conass.org.br/padraoMobile/padrao.png";
    print(post.img);

    return InkWell(
      onTap: () {
        _onClickPost(context, post);
      },
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
        child: Container(
          width: double.infinity,
          margin: EdgeInsets.only(bottom: 20.0),
          padding: EdgeInsets.all(12.0),
          height: 130,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                spreadRadius: 0,
                blurRadius: 5,
                offset: Offset(0, 1), // changes position of shadow
              ),
            ],
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(26.0),
          ),
          child: Row(
            children: [
              if (shouldDisplayImage)
                Flexible(
                  flex: 3,
                  child: Hero(
                    tag: "${post.title}",
                    child: Container(
                      height: 100.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        image: DecorationImage(
                          image: NetworkImage(post.img),
                          fit: BoxFit.fitHeight,
                        ),
                      ),
                    ),
                  ),
                ),
              if (shouldDisplayImage)
                SizedBox(
                  width: 10.0,
                ),
              Flexible(
                flex: shouldDisplayImage ? 7 : 10,
                child: Column(
                  mainAxisAlignment:
                      MainAxisAlignment.center, // Centraliza verticalmente
                  crossAxisAlignment:
                      CrossAxisAlignment.start, // Alinha à esquerda
                  children: [
                    Text(
                      post.title.length > 100
                          ? post.title.substring(0, 100) + '...'
                          : post.title,
                      style: TextStyle(
                        fontSize: 13.0,
                        fontFamily: 'GoogleSansMedium',
                        color: Cores.AzulVerdeado,
                      ),
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text('Publicado em | ' + resData,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.black45,
                            fontSize: 10.0,
                            fontFamily: 'GoogleSansItalic',
                          )),
                    ),
                  ],
                ),
              ),
            ],
          ),
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
