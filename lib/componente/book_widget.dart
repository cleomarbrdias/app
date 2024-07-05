import 'package:conass/modelo/post.dart';
import 'package:conass/util/cores.dart';
import 'package:flutter/material.dart';

class BookWidget extends StatelessWidget {
  final Post post;

  BookWidget(this.post);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 190,
      margin: EdgeInsets.fromLTRB(24, 12, 24, 5),
      child: Stack(
        children: <Widget>[
          Align(
              alignment: Alignment.centerRight,
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(8)),
                child: Image.network(
                  post.img ?? '',
                  fit: BoxFit.fitHeight,
                  height: 162,
                ),
              )),
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              padding: EdgeInsets.all(24),
              width: 220,
              height: 130,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 15,
                    )
                  ]),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Text(
                    post.title,
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                        color: Cores.PrimaryVerde),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Icon(
                      Icons.arrow_forward,
                      color: Cores.PrimaryLaranja,
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
