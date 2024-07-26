import 'package:conass/modelo/modelo_pagina.dart';
import 'package:conass/servicos/api_get_id.dart';
import 'package:conass/util/cores.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:url_launcher/url_launcher.dart';

class ComponentePage extends StatefulWidget {
  @override
  _ComponentePageState createState() => _ComponentePageState();

  final ModeloPagina pagina;

  const ComponentePage(this.pagina);

  get p => pagina;
}

class _ComponentePageState extends State<ComponentePage> {
  double fsize = 15.0;

  @override
  Widget build(BuildContext context) {
    String slug;
    ApiGetId get;
    get = ApiGetId();

    return Scaffold(
      //appBar: BarraMenu(context),
      // drawer: MenuList(),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                widget.p.title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'GoogleSansBoldItalic',
                  fontSize: fsize,
                  color: Cores.LaranjaEscuro,
                ),
              ),
            ),
            Container(
              child: Column(
                children: <Widget>[
                  Padding(
                      padding: const EdgeInsets.all(20),
                      child: HtmlWidget(
                        '''
  <div style="text-align: justify;">
    ${widget.p.materia}
  </div>
  ''',
                        customStylesBuilder: (element) {
                          if (element.localName == 'figcaption') {
                            return {'font-size': '8px'};
                          } else if (element.id == 'fundo_verde') {
                            return {
                              'background-color': '#008979', // VerdePrimario
                              'color': 'white'
                            };
                          }
                          return null;
                        },
                        textStyle: TextStyle(
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w400,
                          color: Cores.FonteConteudo,
                          fontSize: fsize,
                        ),
                      )),
                ],
              ),
            ),
          ],
        ),
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

void _mostraImagem(BuildContext context, String src) {
  var alert = new Center(
      child: Container(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        new Container(
          child: Image.network(
            src,
            fit: BoxFit.cover,
          ),
        ),
      ],
    ),
  ));

  showDialog(context: context, builder: (context) => alert);
}
