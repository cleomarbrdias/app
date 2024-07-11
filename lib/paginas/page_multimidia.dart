import 'package:conass/util/barra_menu.dart';
import 'package:conass/util/buttonIcon.dart';
import 'package:conass/util/menu.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class PageMultimidia extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BarraMenu(context),
      drawer: MenuList(),
      body: Column(
        children: <Widget>[
          Container(
              padding: EdgeInsets.only(top: 30, bottom: 4),
              child: Image.asset(
                "images/logo.png",
                width: 200,
              )),
          SizedBox(
            height: 20,
          ),
          Container(
              padding: EdgeInsets.only(bottom: 20, left: 20, right: 20),
              child: Text(
                "Acompanhe as mídias sociais do Conass e fique atualizado "
                "sobre as principais notícias, informações, apresentações, "
                "fotos e vídeos do Conass e da gestão do SUS:",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 17,
                  color: Colors.black54,
                  fontStyle: FontStyle.italic,
                ),
              )),
          SizedBox(height: 40),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                ButtonTextIcon(
                  url: "http://pt.slideshare.net/CONASS/presentations",
                  img: "images/slideshare.png",
                  titulo: "SlideShare",
                ),
                ButtonTextIcon(
                  url: "https://www.instagram.com/conassoficial/",
                  img: "images/instagram.png",
                  titulo: "Instagram",
                ),
                ButtonTextIcon(
                  url: "http://www.flickr.com/photos/conass/",
                  img: "images/flick.png",
                  titulo: "Flickr",
                )
              ]),
          SizedBox(
            height: 50,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              ButtonTextIcon(
                url: "http://www.youtube.com/conassoficial",
                img: "images/youtube.png",
                titulo: "Youtube",
              ),
              ButtonTextIcon(
                url: "http://www.facebook.com/conassoficial",
                img: "images/facebook.png",
                titulo: "Facebook",
              ),
              ButtonTextIcon(
                url: "https://twitter.com/CONASSoficial",
                img: "images/twitter.png",
                titulo: "Twitter",
              )
            ],
          )
        ],
      ),
    );
  }
}
