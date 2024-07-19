import 'package:conass/modelo/camaras_tecnicas.dart';
import 'package:conass/modelo/post_secretarios.dart';
import 'package:conass/util/barra_menu.dart';
import 'package:conass/util/cores.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:url_launcher/url_launcher.dart';

class PageCamaraTecnica extends StatefulWidget {
  final CamarasTecnicas post;

  const PageCamaraTecnica(this.post);

  @override
  _PageCamaraTecnicaState createState() => _PageCamaraTecnicaState();
}

class _PageCamaraTecnicaState extends State<PageCamaraTecnica> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BarraMenu(context),
      body: Container(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    color: Cores.VerdeClaro,
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  child: Row(
                    children: <Widget>[
                      Container(
                        width: 100.0,
                        height: 80.0,
                        padding: EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                          //color: Cores.VerdeClaro,
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: FadeInImage.memoryNetwork(
                            fit: BoxFit.contain,
                            width: double.infinity,
                            height: double.infinity,
                            placeholder: kTransparentImage,
                            image: widget.post.imageDestaque,
                          ),
                        ),
                      ),
                      SizedBox(width: 15.0),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.post.title ?? '',
                              style: TextStyle(
                                fontSize: 14.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                              softWrap: true,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding:
                            const EdgeInsets.fromLTRB(1.0, 10.0, 1.0, 10.0),
                        child: HtmlWidget(
                          widget.post.apresentacao,
                          textStyle: TextStyle(
                            fontFamily: 'GoogleSans',
                            fontSize: 12.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
