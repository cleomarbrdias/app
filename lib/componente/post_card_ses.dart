import 'package:conass/modelo/post_secretarios.dart';
import 'package:conass/util/cores.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:url_launcher/url_launcher.dart';

class PostCardSes extends StatelessWidget {
  final PostSecretarios post;
  PostCardSes(this.post);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Center(
                  child: FadeInImage.memoryNetwork(
                    fit: BoxFit.cover,
                    width: 50,
                    placeholder: kTransparentImage,
                    image: post.bandeira,
                  ),
                ),
                SizedBox(width: 10),
                Text(
                  post.estado ?? '',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            FadeInImage.memoryNetwork(
              fit: BoxFit.cover,
              width: double.infinity,
              placeholder: kTransparentImage,
              image: post.foto_secretario,
            ),
            SizedBox(height: 10),
            Text(
              post.nome_do_secretario ?? '',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              overflow: TextOverflow.clip,
            ),
            Text(
              post.nome_da_secretaria ?? '',
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
                            post.mini_curriculo ??
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
            Text(post.endereco_secretaria ?? ''),
            SizedBox(height: 10),
            Text('Telefone Gab.: ' + (post.telefone_gab ?? '')),
            Text('E-mail Gab.: ' + (post.e_mail_gab ?? '')),
            Text('Telefone ASCOM: ' + (post.telefone_ascom ?? '')),
            Text('E-mail ASCOM: ' + (post.e_mail_ascom ?? '')),
            SizedBox(height: 10),
            InkWell(
              child: Text(
                'Site: ' + (post.site_da_ses ?? ''),
                style: TextStyle(color: Cores.LaranjaEscuro),
              ),
              onTap: () async {
                final url = post.site_da_ses ?? '';
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
                final url = post.plano_estadual_de_saude ?? '';
                if (await canLaunchUrl(Uri.parse(url))) {
                  await launchUrl(Uri.parse(url));
                } else {
                  throw 'Could not launch $url';
                }
              },
              child: Row(
                children: <Widget>[
                  Icon(Icons.picture_as_pdf),
                  SizedBox(width: 10),
                  Text('Plano estadual de Saúde'),
                ],
              ),
            ),
            SizedBox(height: 10),
            InkWell(
              onTap: () async {
                final url = post.mapas_estrategicos_das_ses ?? '';
                if (await canLaunch(url)) {
                  await launch(url);
                } else {
                  throw 'Could not launch $url';
                }
              },
              child: Row(
                children: <Widget>[
                  Icon(Icons.picture_as_pdf),
                  SizedBox(width: 10),
                  Text('Mapa Estratégico da SES'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
