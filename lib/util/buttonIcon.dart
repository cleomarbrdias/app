import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ButtonTextIcon extends StatelessWidget {
  final String url;
  final String img;
  final String titulo;
  final double tamanho;

  const ButtonTextIcon(
      {Key? key,
      required this.url,
      required this.img,
      required this.titulo,
      this.tamanho = 60})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return InkWell(
        onTap: () {
          _launchURL(url);
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 0.0),
              height: tamanho,
              width: tamanho,
              decoration: BoxDecoration(
                boxShadow: <BoxShadow>[
                  BoxShadow(
                      color: Colors.black.withOpacity(0.5),
                      offset: Offset(3.0, 5.0),
                      blurRadius: 7),
                ],
                shape: BoxShape.circle,
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage(img),
                ),
              ),
            ),
            SizedBox(
              height: 7,
            ),
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(
                top: 0.0,
              ),
              height: 30,
              width: 110,
              child: Text(
                titulo,
                textAlign: TextAlign.center,
              ),
            )
          ],
        ));
  }

  void _launchURL(String src) async {
    if (await canLaunch(src)) {
      await launch(src);
    } else {
      throw 'Could not launch $src';
    }
  }
}
