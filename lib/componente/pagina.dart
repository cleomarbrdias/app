import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:conass/modelo/post.dart';
import 'package:conass/servicos/api_get_id.dart';
import 'package:conass/util/barra_menu.dart';
import 'package:conass/util/cores.dart';

class Pagina extends StatefulWidget {
  @override
  _PaginaState createState() => _PaginaState();

  final Post post;

  const Pagina(this.post);
  get p => post;

  static fromJson(Map<String, dynamic> pagMap) {}
}

class _PaginaState extends State<Pagina> {
  double fsize = 16.0;
  double fConteudo = 12.0;

  @override
  Widget build(BuildContext context) {
    var dt = DateTime.parse(widget.p.data ?? DateTime.now().toIso8601String());
    var forData = DateFormat('dd \'de\' MMMM \'de\' yyyy', 'pt_BR');
    String resData = forData.format(dt);

    String slug;
    ApiGetId get;
    get = ApiGetId();
    print("print ebook =>");
    print(widget.p.linkEbook);
    print("print pdf =>");
    print(widget.p.linkPdf);
    print("entrou na Pagina no Post");
    return Scaffold(
      appBar: BarraMenu(context),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
              child: Row(
                children: [
                  Expanded(
                    flex: 8,
                    child: Text(
                      widget.p.title,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontFamily: 'GoogleSansMediumItalic',
                        fontWeight: FontWeight.w700,
                        fontStyle: FontStyle.italic,
                        fontSize: 20,
                        letterSpacing: 0.5,
                        height: 1.2,
                        color: Cores.LaranjaTitulo,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Cores.LaranjaAmrelado,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: EdgeInsets.all(
                            4.0), // Ajuste para menos espaço ao redor do ícone
                        child: Icon(
                          Icons.bookmark_border,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
              child: Row(
                children: [
                  Text(
                    'Publicado em ' + resData,
                    //textAlign: TextAlign.left,
                    style: TextStyle(
                      fontFamily: 'GibsonMediumItalic',
                      color: Cores.FonteConteudo,
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
            ),
            if (widget.p.categoriaList != null &&
                widget.p.categoriaList!.isNotEmpty)
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 10, 0, 0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children:
                          widget.p.categoriaList!.map<Widget>((categoria) {
                        return Padding(
                          padding: const EdgeInsets.only(
                              right: 8.0), // Espaçamento entre os chips
                          child: Chip(
                            label: Text(
                              categoria.toUpperCase(),
                              style: TextStyle(
                                color: Cores.VerdeMedio,
                                fontWeight: FontWeight.w500,
                                fontSize: 10,
                                // Cor do texto
                              ),
                            ),
                            backgroundColor:
                                Colors.white, // Cor de fundo do Chip
                            shape: StadiumBorder(
                              side: BorderSide(
                                color: Cores.LaranjaAmrelado, // Cor da borda
                                width: 1, // Largura da borda
                              ),
                            ),
                          ),
                        );
                      }).toList(), // Convertendo para List<Widget>
                    ),
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
                        } else if (element.className.contains('fundo_verde')) {
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
                        fontSize: fConteudo,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                widget.p.linkPdf != "" && widget.p.linkPdf != null
                    ? Container(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: Cores.PrimaryVerde, // Cor do texto
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
                widget.p.linkEbook != "" && widget.p.linkEbook != null
                    ? Container(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: Color(0xfff008979), // Cor do texto
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
            SizedBox(height: 70),
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
