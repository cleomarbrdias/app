import 'package:conass/modelo/camaras_tecnicas.dart';
import 'package:conass/paginas/page_camara_tecnica.dart';
import 'package:conass/util/cores.dart';
import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

class PostCardCamarasTecnicas extends StatelessWidget {
  final CamarasTecnicas post;

  PostCardCamarasTecnicas(this.post);

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
                      color: Colors.black.withOpacity(0.1),
                      spreadRadius: 0,
                      blurRadius: 30,
                      offset: Offset(0, 1), // changes position of shadow
                    ),
                  ],
                ),
                width: 100.0,
                height: 100.0,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: FadeInImage.memoryNetwork(
                    fit: BoxFit.cover,
                    width: double.infinity,
                    placeholder: kTransparentImage,
                    image: post.imageDestaque,
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
                      post.title ?? '',
                      style: TextStyle(
                        fontSize: 14.0,
                        fontFamily: 'GoogleSansMedium',
                        color: Cores.AzulVerdeado,
                      ),
                      overflow: TextOverflow.clip,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'Responsável Técnico: ',
                              style: TextStyle(
                                color: Cores.FonteConteudoCardSES,
                                fontSize: 13,
                                fontFamily: 'GoogleSansMedium',
                              ),
                            ),
                            TextSpan(
                              text: post.responsavel ?? '',
                              style: TextStyle(
                                color: Cores.FonteConteudoCardSES,
                                fontSize: 13,
                                fontFamily: 'GoogleSans',
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _onClickPost(BuildContext context, CamarasTecnicas post) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => PageCamaraTecnica(post)),
    );
  }
}
