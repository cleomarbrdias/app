import 'package:conass/modelo/post.dart';
import 'package:conass/util/cores.dart';
import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

class SlideScreem extends StatelessWidget {
  final Post post;

  SlideScreem(this.post, {required ScrollController scrollController});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 16 / 2),
              child: Text(
                "Categories",
                style: Theme.of(context).textTheme.titleSmall,
              ),
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
                Container(
                    decoration: new BoxDecoration(
                      color: Cores.PrimaryVerde.withOpacity(0.8),
                      borderRadius: new BorderRadius.only(
                          topLeft: const Radius.circular(3.0),
                          topRight: const Radius.circular(3.0),
                          bottomLeft: const Radius.circular(3.0),
                          bottomRight: const Radius.circular(3.0)),
                    ),
                    width: 50,
                    height: 20,
                    child: Padding(
                      padding: EdgeInsets.only(left: 8.0, top: 2.0, right: 8.0),
                      child: Text(
                        post.categoria.toString(),
                        style: TextStyle(color: Colors.white, fontSize: 10),
                      ),
                    ))
              ],
            )
          ],
        ),
      ),
    );
  }
}
