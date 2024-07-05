import 'package:conass/modelo/post.dart';
import 'package:conass/servicos/api_get_id.dart';
import 'package:conass/util/barra_menu.dart';
import 'package:conass/util/cores.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:html/dom.dart' as dom;
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class Pagina extends StatefulWidget {
  @override
  _PaginaState createState() => _PaginaState();

  final Post post;

  const Pagina(this.post);
  get p => post;
}

class _PaginaState extends State<Pagina> {
  double fsize = 16.0;

  @override
  Widget build(BuildContext context) {
    var dt = DateTime.parse(widget.p.data);
    print(dt);
    var forData = new DateFormat('dd/MM/yyyy');
    String resData = forData.format(dt);

    String slug;
    ApiGetId get;
    get = ApiGetId();
    print("print ebook");
    print(widget.p.linkEbook);
    print("print pdf");
    print(widget.p.linkPdf);
    return Scaffold(
      appBar: BarraMenu(context, widget.p.title),
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
                padding: EdgeInsets.all(11),
                linkStyle: const TextStyle(
                  color: Cores.PrimaryVerde,

                ),
                onLinkTap: (url) async {

                  if (url.contains("www.conass.org.br")) {
                    print("Url é do conass");
                    if (url.contains("biblioteca/download")) {
                      print("Entrou em Biblitoteca");
                      _launchURL(url);
                    } else if (url.contains("category")) {
                      push(context, ViewPage(url));
                    } else if (url.contains("uploads") ||
                        url.contains("/pdf/") ||
                        url.contains("/eBook/")) {
                      print("Verificando arquivo: $url");
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
                    }
                  } else {
                    print("Link não é do CONASS");

                    push(context, ViewPage(url));
                  }
                },
                onImageTap: (src) {
                  print("Verificando SRC: $src");
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
                          color: Colors.black54
                        ));
                    }
                  }
                  return baseStyle;
                },


              ),
*/

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  widget.p.linkPdf != " " && widget.p.linkPdf != null
                      ? Container(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor:
                                  Cores.PrimaryVerde, // Cor do texto
                              padding: EdgeInsets.all(0.0), // Padding
                              splashFactory:
                                  InkSplash.splashFactory, // Splash color
                            ),
                            child: const Text(
                              'PDF',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            onPressed: () {
                              _launchURL(widget.p.linkPdf ??
                                  ''); // Garantir que linkPdf não seja nulo
                              print(widget.p.linkPdf);
                            },
                          ),
                        )
                      : SizedBox.shrink(),
                  widget.p.linkEbook != " " && widget.p.linkEbook != null
                      ? Container(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor:
                                  Color(0xfff008979), // Cor do texto
                              padding: EdgeInsets.all(0.0), // Padding
                              splashFactory:
                                  InkSplash.splashFactory, // Splash color
                            ),
                            child: const Text(
                              'eBook',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            onPressed: () {
                              _launchURL(widget.p.linkEbook ??
                                  ''); // Garantir que linkEbook não seja nulo
                              print(widget.p.linkEbook);
                            },
                          ),
                        )
                      : SizedBox.shrink(),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5),
                child: Text(
                  'Publicado em | ' + resData,
                  textAlign: TextAlign.left,
                  style: TextStyle(color: Colors.grey),
                ),
              ),
              SizedBox(height: 70),
            ],
          ),
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          new FloatingActionButton(
              mini: true,
              heroTag: "btn1",
              child: Text("A+"),
              backgroundColor: Cores.PrimaryLaranja,
              onPressed: () {
                setState(() {
                  if (fsize < 25) {
                    fsize++;
                  }
                });
              }),
          SizedBox(
            width: 8,
            height: 8,
          ),
          new FloatingActionButton(
              mini: true,
              heroTag: "btn2",
              child: Text("A-"),
              backgroundColor: Cores.PrimaryLaranja,
              onPressed: () {
                setState(() {
                  if (fsize > 15) {
                    fsize--;
                  }
                });
              })
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
          ButtonTheme(
            child: ButtonBar(
              children: <Widget>[
                ElevatedButton(
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
        ],
      ),
    ));

    showDialog(context: context, builder: (context) => alert);
  }
}
