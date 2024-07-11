import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:conass/bloc/favorito_bloc.dart';
import 'package:conass/componente/pagina.dart';
import 'package:conass/modelo/post.dart';
import 'package:conass/util/push.dart';
import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

class CardPost extends StatelessWidget {
  final Post post;
  CardPost(this.post);

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    final bloc = BlocProvider.getBloc<FavoritoBloc>();
    return Container(
      height: double.infinity,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
            padding: const EdgeInsets.all(6.0),
            child: Container(
              height: double.infinity,
              alignment: Alignment.center,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(right: 2, left: 2, bottom: 5),
                    child: InkWell(
                      onTap: () {
                        _onClickPost(context, post);
                      },
                      child: Container(
                          alignment: Alignment.center,
                          height: 80,
                          child: Center(
                            child: Text(
                              (post.title == null || post.title!.isEmpty)
                                  ? ''
                                  : post.title!,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: 'GoogleSans',
                                fontWeight: FontWeight.w500,
                                fontSize: 13,
                                color: Colors.black,
                              ),
                            ),
                          )),
                    ),
                  ),
                  Expanded(
                      flex: 7,
                      child: Container(
                        decoration: BoxDecoration(),
                        child: InkWell(
                          onTap: () {
                            _onClickPost(context, post);
                          },
                          child: FadeInImage.memoryNetwork(
                            fit: BoxFit.cover,
                            placeholder: kTransparentImage,
                            image: post.img == null || post.img == "0"
                                ? 'assets/images/placeholder.gif'
                                : post.img!,
                          ),
                        ),
                      )),
                ],
              ),
            )),
      ),
    );
  }

  // ignore: unused_element
  void _onClickPost(BuildContext context, Post post) {
    push(context, Pagina(post));
  }
}
