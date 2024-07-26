import 'package:conass/componente/pagina.dart';
import 'package:conass/util/cores.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:conass/modelo/post.dart';
import 'package:conass/util/push.dart';
import 'package:page_transition/page_transition.dart';

class CardPublicacao extends StatelessWidget {
  final Post post;
  CardPublicacao(this.post);

  @override
  Widget build(BuildContext context) {
    var dt = DateTime.parse(post.data ?? DateTime.now().toIso8601String());
    var forData = DateFormat('dd \'de\' MMMM \'de\' yyyy', 'pt_BR');
    String resData = forData.format(dt);

    double cardWidth =
        MediaQuery.of(context).size.width * 0.9; // Ajuste a largura do card
    double imageWidth =
        cardWidth * 0.3; // Proporção da imagem em relação ao card
    double cardHeight = imageWidth * 1.5; // Proporção da altura do card

    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: InkWell(
        onTap: () {
          _onClickPost(context, post);
        },
        child: Row(
          children: <Widget>[
            Container(
              width: imageWidth,
              height: cardHeight,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                image: DecorationImage(
                  image: NetworkImage(post.img!),
                  fit: BoxFit.cover,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    offset: Offset(3, 3),
                    blurRadius: 3,
                  ),
                ],
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20.0),
                    bottomRight: Radius.circular(20.0),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      post.title!,
                      style: TextStyle(
                        fontSize: 16.0,
                        fontFamily: 'GoogleSansMedium',
                        color: Cores.AzulVerdeado,
                      ),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Publicado em | $resData',
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.black45,
                        fontSize: 12.0,
                        fontFamily: 'GoogleSansItalic',
                      ),
                    ),
                  ],
                ),
              ),
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
