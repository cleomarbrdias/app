import 'package:conass/modelo/post_presidentes.dart';
import 'package:conass/util/cores.dart';
import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

class PostCardPresidentes extends StatelessWidget {
  final PostPresidentes post;
  PostCardPresidentes(this.post);

  @override
  Widget build(BuildContext context) {
    print(post.bandeira);
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
            // color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(16.0),
            border: Border.all(color: Colors.grey.shade300, width: 1.0)),
        child: Row(
          children: [
            Container(
              width: 150.0,
              height: 110.0,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: FadeInImage.memoryNetwork(
                  fit: BoxFit.cover,
                  width: double.infinity,
                  placeholder: kTransparentImage,
                  image: post.imageDestaque,
                ),
              ),
            ),
            SizedBox(
              width: 20.0,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    post.title ?? '',
                    style: TextStyle(
                      fontSize: 13.0,
                      fontFamily: 'GoogleSansMedium',
                      color: Cores.AzulVerdeado,
                    ),
                    softWrap: true,
                  ),
                  SizedBox(height: 20.0),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // FadeInImage.memoryNetwork(
                      //   fit: BoxFit.cover,
                      //   width: 40,
                      //   height: 30,
                      //   placeholder: kTransparentImage,
                      //   image: post.bandeira,
                      // ),
                      Container(
                        width: 40,
                        height: 30,
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              spreadRadius: 0,
                              blurRadius: 10,
                              offset:
                                  Offset(0, 1), // changes position of shadow
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: FadeInImage.memoryNetwork(
                            fit: BoxFit.cover,
                            width: 40,
                            height: 30,
                            placeholder: kTransparentImage,
                            image: post.bandeira,
                          ),
                        ),
                      ),

                      SizedBox(width: 10.0),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              post.nomeEstado ?? '',
                              style: TextStyle(
                                fontSize: 10.0,
                                color: Colors.black,
                              ),
                              softWrap: true,
                            ),
                            Text(
                              'Gestão: ${post.anoDeGestao ?? ''}',
                              style: TextStyle(
                                fontSize: 10.0,
                                fontFamily: 'GoogleSansItalic',
                                color: Colors.black54,
                              ),
                              softWrap: true,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}


/*
    Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: FadeInImage.memoryNetwork(
                fit: BoxFit.cover,
                width: double.infinity,
                placeholder: kTransparentImage,
                image: post.imageDestaque,
              ),
            ),
            SizedBox(height: 10),
            Text(
              post.title ?? '',
              style: TextStyle(
                fontFamily: 'GoogleSans',
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              overflow: TextOverflow.clip,
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.circular(0.0),
                  child: FadeInImage.memoryNetwork(
                    fit: BoxFit.cover,
                    width: 50,
                    placeholder: kTransparentImage,
                    image: post.bandeira,
                  ),
                ),
                SizedBox(width: 10),
                Text(
                  post.nomeEstado ?? '',
                  style: TextStyle(
                    fontFamily: 'GoogleSans',
                    fontSize: 16,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              children: <Widget>[
                Text(
                  'Gestão: ',
                  style: TextStyle(
                    fontFamily: 'GoogleSans',
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                SizedBox(width: 10),
                Text(
                  post.anoDeGestao ?? '',
                  style: TextStyle(
                    fontFamily: 'GoogleSans',
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );

    */