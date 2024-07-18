import 'package:conass/modelo/post_secretarios.dart';
import 'package:conass/util/barra_menu.dart';
import 'package:conass/util/cores.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:url_launcher/url_launcher.dart';

class PaginaSecretaria extends StatefulWidget {
  final PostSecretarios post;

  const PaginaSecretaria(this.post);

  @override
  _PaginaSecretariaState createState() => _PaginaSecretariaState();
}

class _PaginaSecretariaState extends State<PaginaSecretaria> {
  double fsize = 16.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BarraMenu(context),
      body: Center(
        child: SingleChildScrollView(
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      ClipRRect(
                        borderRadius: BorderRadius.circular(0.0),
                        child: FadeInImage.memoryNetwork(
                          fit: BoxFit.cover,
                          width: 50,
                          placeholder: kTransparentImage,
                          image: widget.post.bandeira,
                        ),
                      ),
                      SizedBox(width: 10),
                      Text(
                        widget.post.estado ?? '',
                        style: TextStyle(
                          fontFamily: 'GoogleSans',
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: FadeInImage.memoryNetwork(
                      fit: BoxFit.cover,
                      width: double.infinity,
                      placeholder: kTransparentImage,
                      image: widget.post.imageDestaque,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    widget.post.nome_do_secretario ?? '',
                    style: TextStyle(
                      fontFamily: 'GoogleSans',
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.clip,
                  ),
                  Text(
                    widget.post.nome_da_secretaria ?? '',
                    overflow: TextOverflow.clip,
                    maxLines: 2,
                  ),
                  SizedBox(height: 20),
                  Container(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              backgroundColor: Colors.white,
                              title: Text("Minicurrículo"),
                              content: SingleChildScrollView(
                                child: HtmlWidget(
                                  widget.post.mini_curriculo ??
                                      "Minicurrículo não disponível.",
                                  textStyle: TextStyle(
                                    fontFamily: 'GoogleSans',
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                              actions: <Widget>[
                                TextButton(
                                  style: TextButton.styleFrom(
                                      foregroundColor: Colors.white,
                                      backgroundColor: Cores.LaranjaClaro,
                                      side: BorderSide(
                                        width: 3.0,
                                        color: Cores.LaranjaClaro,
                                      )),
                                  child: Text("Fechar"),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: Text("+ Minicurrículo"),
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(widget.post.endereco_secretaria ?? ''),
                  SizedBox(height: 10),
                  Text('Telefone Gab.: ' + (widget.post.telefone_gab ?? '')),
                  Text('E-mail Gab.: ' + (widget.post.e_mail_gab ?? '')),
                  Text('Telefone ASCOM: ' + (widget.post.telefone_ascom ?? '')),
                  Text('E-mail ASCOM: ' + (widget.post.e_mail_ascom ?? '')),
                  SizedBox(height: 10),
                  InkWell(
                    child: Text(
                      'Site: ' + (widget.post.site_da_ses ?? ''),
                      style: TextStyle(color: Cores.LaranjaEscuro),
                    ),
                    onTap: () async {
                      final url = widget.post.site_da_ses ?? '';
                      if (await canLaunchUrl(Uri.parse(url))) {
                        await launchUrl(Uri.parse(url));
                      } else {
                        throw 'Could not launch $url';
                      }
                    },
                  ),
                  SizedBox(height: 20),
                  InkWell(
                    onTap: () async {
                      final url = widget.post.plano_estadual_de_saude ?? '';
                      if (await canLaunchUrl(Uri.parse(url))) {
                        await launchUrl(Uri.parse(url));
                      } else {
                        throw 'Could not launch $url';
                      }
                    },
                    child: Row(
                      children: <Widget>[
                        Icon(
                          Icons.picture_as_pdf,
                          color: Cores.LaranjaClaro,
                        ),
                        SizedBox(width: 10),
                        Text(
                          'Plano estadual de Saúde',
                          style: TextStyle(color: Cores.LaranjaClaro),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  InkWell(
                    onTap: () async {
                      final url = widget.post.mapas_estrategicos_das_ses ?? '';
                      if (await canLaunch(url)) {
                        await launch(url);
                      } else {
                        throw 'Could not launch $url';
                      }
                    },
                    child: Row(
                      children: <Widget>[
                        Icon(
                          Icons.picture_as_pdf,
                          color: Cores.LaranjaClaro,
                        ),
                        SizedBox(width: 10),
                        Text(
                          'Mapa Estratégico da SES',
                          style: TextStyle(color: Cores.LaranjaClaro),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
