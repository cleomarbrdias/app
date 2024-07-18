import 'package:conass/modelo/camaras_tecnicas.dart';
import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

class PostCardCamarasTecnicas extends StatelessWidget {
  final CamarasTecnicas post;
  PostCardCamarasTecnicas(this.post);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.amber,
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 50.0,
              height: 50.0,
              child: FadeInImage.memoryNetwork(
                placeholder: kTransparentImage,
                image: post.imageDestaque,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 10),
            Text(
              post.title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
