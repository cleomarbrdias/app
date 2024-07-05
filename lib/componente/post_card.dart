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

  PostCard(this.post, {required ScrollController scrollController});

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.getBloc<FavoritoBloc>();

    var dt = DateTime.parse(post.data);
    print(dt);
    var forData = new DateFormat('dd/MM/yyyy');
    String resData = forData.format(dt);

    if (post.nCategoria == null) {
      /* post.nCategoria = '';*/
    }

    return Card(
      child: Container(
        margin: const EdgeInsets.all(5),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: InkWell(
                  child: new Text(
                    post.title,
                    textAlign: TextAlign.center,
                    style: new TextStyle(
                      fontFamily: 'GoogleSans',
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                  onTap: () {
                    _onClickPost(context, post);
                  }),
            ),
            Stack(
              alignment: Alignment.bottomLeft,
              children: <Widget>[
                Center(
                  child: new FadeInImage.memoryNetwork(
                      fit: BoxFit.cover,
                      placeholder: kTransparentImage,
                      // ignore: unrelated_type_equality_checks
                      image:
                          // ignore: unrelated_type_equality_checks
                          post.img == 0 ? 'images/placeholder.gif' : post.img),
                ),
                post.nCategoria.isNotEmpty
                    ? Container(
                        decoration: new BoxDecoration(
                          color: Cores.PrimaryVerde.withOpacity(0.8),
                          borderRadius: new BorderRadius.only(
                              topLeft: const Radius.circular(3.0),
                              topRight: const Radius.circular(3.0),
                              bottomLeft: const Radius.circular(3.0),
                              bottomRight: const Radius.circular(3.0)),
                        ),

                        // color: Color(0xff009879),
                        width: double.tryParse(post.nCategoria),
                        height: 20,
                        child: Padding(
                          padding:
                              EdgeInsets.only(left: 8.0, top: 2.0, right: 8.0),
                          child: Text(
                            post.nCategoria.toUpperCase(),
                            style: TextStyle(color: Colors.white, fontSize: 10),
                          ),
                        ))
                    : SizedBox()
              ],
            ),
            Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 0),
                  child: Text(
                    'Publicado em | ' + resData,
                    textAlign: TextAlign.left,
                    style: TextStyle(fontSize: 9, color: Colors.grey),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5.0),
              child: Text(
                post.resumo ?? "",
                textAlign: TextAlign.justify,
                style: TextStyle(fontSize: 14),
              ),
            ),
            ButtonTheme(
              child: ButtonBar(
                children: <Widget>[
                  StreamBuilder<Map<String, Post>>(
                    stream: bloc.outFav,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Container(
                          width: 25,
                          height: 33,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.fromLTRB(0, 1, 0, 1),
                            ),
                            onPressed: () {
                              bloc.toggleFavorite(post);
                            },
                            child: Image.asset(
                              snapshot.data!.containsKey(post.id)
                                  ? "images/estrelaBordaP.png"
                                  : "images/estrelaBorda.png",
                              width: 25,
                              height: 25,
                              color: Cores.PrimaryVerde,
                            ),
                          ),
                        );
                      } else {
                        return CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Cores.PrimaryVerde),
                        );
                      }
                    },
                  ),
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
