import 'package:conass/componente/pagina.dart';
import 'package:conass/servicos/api_get_id.dart';
import 'package:conass/util/barra_menu.dart';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Page extends StatefulWidget {
  @override
  _PageState createState() => _PageState();

  final Pagina pagina;

  const Page(this.pagina);

  get p => pagina;
}

class _PageState extends State<Page> {
  double fsize = 17.0;

  @override
  Widget build(BuildContext context) {
    String slug;
    ApiGetId get;
    get = ApiGetId();
    print("Entrou no componente page");
    return Scaffold(
      appBar: BarraMenu(context),
      // drawer: MenuList(),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  widget.p.title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'GoogleSansBold',
                    fontSize: fsize,
                    color: Colors.black54,
                  ),
                ),
              ),
              /*
              Html(
                data: widget.p.materia,
                padding: EdgeInsets.all(8.0),
                linkStyle: const TextStyle(
                  color: Cores.PrimaryVerde,
                ),
                onLinkTap: (url) async {
                  //_launchURL(url);
                  //print(url);
                  if (url.contains("www.conass.org.br")) {
                    // print("Url é do conass");
                    if (url.contains("category")) {
                      push(context, ViewPage(url));
                    } else if (url.contains("uploads") ||
                        url.contains("/pdf/") ||
                        url.contains("/eBook/")) {
                      _launchURL(url);
                    } else {
                      slug = url
                          .replaceAll('https://www.conass.org.br', '')
                          .replaceAll('/', '');

                      final int res = await get.getId(slug);

                      if (res != null) {
                        Util.pagina = res;
                        push(context, PagePagina());
                      }

                      // get.getId(slug);
                      //push(context, ViewPage(url));
                    }
                  } else {
                    //  print("Link não é do CONASS");
                    //_launchURL(url);

                    push(context, ViewPage(url));
                  }
                },
                onImageTap: (src) {
                  _mostraImagem(context, src);
                },
                customRender: (node, children) {
                  if (node is dom.Element) {
                    switch (node.localName) {
                      case "custom_tag":
                        return Column(children: children);
                    }
                  }
                  return null;
                },
                customTextAlign: (dom.Node node) {
                  if (node is dom.Element) {
                    switch (node.localName) {
                      case "p":
                        return TextAlign.justify;
                    }
                  }
                  return null;
                },
                customTextStyle: (dom.Node node, TextStyle baseStyle) {
                  if (node is dom.Element) {
                    switch (node.localName) {
                      case "p":
                        return baseStyle.merge(TextStyle(
                            height: 1.4,
                            fontSize: fsize,
                            color: Colors.black54));
                    }
                  }
                  return baseStyle;
                },
              )
*/
            ],
          ),
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
        /*
        ButtonTheme(
          child: ButtonBar(
            children: <Widget>[
              FlatButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.close,
                    color: Colors.white,
                  )),
            ],
          ),
        )
        */
      ],
    ),
  ));

  showDialog(context: context, builder: (context) => alert);
}
