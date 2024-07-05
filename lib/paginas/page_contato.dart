import 'package:conass/util/barra_menu.dart';
import 'package:conass/util/buttonIcon.dart';
import 'package:conass/util/menu_list.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class PageContato extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BarraMenu(context, "Contato"),
      drawer: MenuList(),
      body: Column(
        children: <Widget>[
          Container(
              padding: EdgeInsets.only(top: 30, bottom: 30),
              child: Image.asset("images/logo.png")),
          SizedBox(
            height: 10,
          ),
          ListTile(
              onTap: () {
                _launchURL("https://www.conass.org.br");
              },
              title: Text(
                "www.conass.org.br",
                style: TextStyle(
                  color: Color(0xff008979),
                ),
              ),
              trailing:
                  Icon(Icons.keyboard_arrow_right, color: Color(0xfff3902b)),
              leading: Icon(
                Icons.web,
                color: Color(0xff008979),
              )),
          ListTile(
              onTap: () {
                _launchURL("tel:  0613222-3000");
              },
              title: Text(
                "(061) 3222-3000",
                style: TextStyle(
                  color: Color(0xff008979),
                ),
              ),
              trailing:
                  Icon(Icons.keyboard_arrow_right, color: Color(0xfff3902b)),
              leading: Icon(
                Icons.phone,
                color: Color(0xff008979),
              )),
          ListTile(
              onTap: () {
                _launchURL("mailto:ascom@conass.org.br");
              },
              title: Text(
                "ascom@conass.org.br",
                style: TextStyle(
                  color: Color(0xff008979),
                ),
              ),
              trailing:
                  Icon(Icons.keyboard_arrow_right, color: Color(0xfff3902b)),
              leading: Icon(
                Icons.mail_outline,
                color: Color(0xff008979),
              )),
          ListTile(
              onTap: () {
                _launchURL(
                    "https://www.google.com/maps/search/?api=1&query=-15.7958662, -47.8937206");
              },
              title: Text(
                "Setor Comercial Sul Quadra 9 Torre C Edifício Parque Cidade Corporate Sala 1105 - Asa Sul, Brasília - DF, 70308-200",
                style: TextStyle(
                  color: Color(0xff008979),
                ),
              ),
              trailing:
                  Icon(Icons.keyboard_arrow_right, color: Color(0xfff3902b)),
              leading: Icon(
                Icons.place,
                color: Color(0xff008979),
              )),
          SizedBox(height: 40),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                ButtonTextIcon(
                  url: "http://pt.slideshare.net/CONASS/presentations",
                  img: "images/slideshare.png",
                  titulo: "SlideShare",
                  tamanho: 40,
                ),
                ButtonTextIcon(
                  url: "https://www.instagram.com/conassoficial/",
                  img: "images/instagram.png",
                  titulo: "Instagram",
                  tamanho: 40,
                ),
                ButtonTextIcon(
                  url: "http://www.flickr.com/photos/conass/",
                  img: "images/flick.png",
                  titulo: "Flick",
                  tamanho: 40,
                )
              ]),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              ButtonTextIcon(
                url: "http://www.youtube.com/conassoficial",
                img: "images/youtube.png",
                titulo: "Youtube",
                tamanho: 40,
              ),
              ButtonTextIcon(
                url: "http://www.facebook.com/conassoficial",
                img: "images/facebook.png",
                titulo: "Facebook",
                tamanho: 40,
              ),
              ButtonTextIcon(
                url: "https://twitter.com/CONASSoficial",
                img: "images/twitter.png",
                titulo: "Twitter",
                tamanho: 40,
              )
            ],
          )
        ],
      ),
    );
  }

  void _launchURL(String src) async {
    if (await canLaunch(src)) {
      await launch(src);
    } else {
      throw 'Could not launch $src';
    }
  }
}
