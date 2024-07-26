import 'package:conass/paginas/pagina_secretaria.dart';
import 'package:conass/modelo/post.dart';
import 'package:conass/modelo/post_secretarios.dart';
import 'package:conass/util/cores.dart';
import 'package:conass/util/push.dart';
import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:url_launcher/url_launcher.dart';

class PostCardGestores extends StatelessWidget {
  final PostSecretarios post;
  PostCardGestores(this.post);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(30, 20, 30, 2),
      child: Container(
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: InkWell(
          onTap: () {
            print("clicou");
            _onClickPost(context, post);
            print(post);
          },
          child: Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      spreadRadius: 0,
                      blurRadius: 10,
                      offset: Offset(0, 1), // changes position of shadow
                    ),
                  ],
                ),
                width: 100.0,
                height: 70.0,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: FadeInImage.memoryNetwork(
                    fit: BoxFit.cover,
                    width: double.infinity,
                    placeholder: kTransparentImage,
                    image: post.bandeira,
                  ),
                ),
              ),
              SizedBox(
                width: 30.0,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      post.estado ?? '',
                      style: TextStyle(
                        fontSize: 14.0,
                        fontFamily: 'GoogleSansMedium',
                        color: Cores.AzulVerdeado,
                      ),
                      overflow: TextOverflow.clip,
                    ),
                    Text(
                      post.nome_do_secretario ?? '',
                      style: TextStyle(
                        fontSize: 12.0,
                        fontFamily: 'GoogleSans',
                        color: Color(0xff646464),
                      ),
                      softWrap: true,
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _onClickPost(BuildContext context, PostSecretarios post) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => PaginaSecretaria(post)),
    );
  }
}
