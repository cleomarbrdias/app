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
      body: Container(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                spreadRadius: 0,
                                blurRadius: 10,
                                offset:
                                    Offset(0, 1), // changes position of shadow
                              ),
                            ],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8.0),
                                child: FadeInImage.memoryNetwork(
                                  fit: BoxFit.cover,
                                  width: 50,
                                  placeholder: kTransparentImage,
                                  image: widget.post.bandeira,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 10),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              widget.post.estado ?? '',
                              style: TextStyle(
                                  fontFamily: 'GoogleSansMediumItalic',
                                  fontSize: 20,
                                  color: Cores.LaranjaEscuro),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Center(
                      child: Container(
                        width: 300,
                        child: Stack(
                          children: [
                            Container(
                              width: double.infinity,
                              height: 200, // define a altura da imagem
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30.0),
                                color: Colors.grey[200], // cor do placeholder
                              ),
                            ),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(30.0),
                              child: FadeInImage.memoryNetwork(
                                fit: BoxFit.cover,
                                width: double.infinity,
                                height: 200, // define a altura da imagem
                                placeholder: kTransparentImage,
                                image: widget.post.imageDestaque,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Center(
                      child: Text(
                        widget.post.nome_do_secretario ?? '',
                        style: TextStyle(
                            fontFamily: 'GoogleSansMediumItalic',
                            fontSize: 18,
                            color: Cores.AzulVerdeado),
                        overflow: TextOverflow.clip,
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Container(
                        width: MediaQuery.of(context).size.width *
                            0.5, // 30% da largura da tela
                        child: Center(
                          child: Text(
                            widget.post.nome_da_secretaria ?? '',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: 'GoogleSans',
                              fontSize: 13,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Center(
                      child: Container(
                        width: 138,
                        height: 30,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Cores.LaranjaEscuro,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
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
                                        fontSize: 13,
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
                          child: Text(
                            "+ Minicurrículo",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12, // Cor do texto do botão
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        color: Color(0xfffafafa),
                        border: Border.all(
                          color: Colors
                              .grey, // Substitua Colors.grey pela cor desejada para a borda
                          width:
                              0.2, // Ajuste a largura da borda conforme necessário
                        ),
                        borderRadius: BorderRadius.circular(
                            12.0), // Ajuste o raio da borda conforme necessário
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Container(
                          child: Column(
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: 'Endereço: ',
                                        style: TextStyle(
                                          color: Cores.FonteConteudoCardSES,
                                          fontSize: 13,
                                          fontFamily: 'GoogleSansMedium',
                                        ),
                                      ),
                                      TextSpan(
                                        text: widget.post.endereco_secretaria ??
                                            '',
                                        style: TextStyle(
                                          color: Cores.FonteConteudoCardSES,
                                          fontSize: 13,
                                          fontFamily: 'GoogleSans',
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(height: 5),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: 'Telefone Gab.: ',
                                        style: TextStyle(
                                          color: Cores.FonteConteudoCardSES,
                                          fontSize: 13,
                                          fontFamily: 'GoogleSansMedium',
                                        ),
                                      ),
                                      TextSpan(
                                        text: widget.post.telefone_gab ?? '',
                                        style: TextStyle(
                                          color: Cores.FonteConteudoCardSES,
                                          fontSize: 13,
                                          fontFamily: 'GoogleSans',
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(height: 5),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: 'E-mail Gab.: ',
                                        style: TextStyle(
                                          color: Cores.FonteConteudoCardSES,
                                          fontSize: 13,
                                          fontFamily: 'GoogleSansMedium',
                                        ),
                                      ),
                                      TextSpan(
                                        text: widget.post.e_mail_gab ?? '',
                                        style: TextStyle(
                                          color: Cores.FonteConteudoCardSES,
                                          fontSize: 13,
                                          fontFamily: 'GoogleSans',
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(height: 5),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: 'Telefone ASCOM: ',
                                        style: TextStyle(
                                          color: Cores.FonteConteudoCardSES,
                                          fontSize: 13,
                                          fontFamily: 'GoogleSansMedium',
                                        ),
                                      ),
                                      TextSpan(
                                        text: widget.post.telefone_ascom ?? '',
                                        style: TextStyle(
                                          color: Cores.FonteConteudoCardSES,
                                          fontSize: 13,
                                          fontFamily: 'GoogleSans',
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(height: 5),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: 'E-mail ASCOM: ',
                                        style: TextStyle(
                                          color: Cores.FonteConteudoCardSES,
                                          fontSize: 13,
                                          fontFamily: 'GoogleSansMedium',
                                        ),
                                      ),
                                      TextSpan(
                                        text: widget.post.e_mail_ascom ?? '',
                                        style: TextStyle(
                                          color: Cores.FonteConteudoCardSES,
                                          fontSize: 13,
                                          fontFamily: 'GoogleSans',
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(height: 5),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: InkWell(
                                  child: RichText(
                                    text: TextSpan(
                                      children: [
                                        TextSpan(
                                          text: 'Site: ',
                                          style: TextStyle(
                                            color: Cores.FonteConteudoCardSES,
                                            fontSize: 13,
                                            fontFamily: 'GoogleSansMedium',
                                          ),
                                        ),
                                        TextSpan(
                                          text: widget.post.site_da_ses ?? '',
                                          style: TextStyle(
                                            color: Cores.LaranjaEscuro,
                                            fontSize: 13,
                                            fontFamily: 'GoogleSansItalic',
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                      ],
                                    ),
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
                              ),
                              SizedBox(height: 5),
                              InkWell(
                                onTap: () async {
                                  final url =
                                      widget.post.plano_estadual_de_saude ?? '';
                                  if (await canLaunchUrl(Uri.parse(url))) {
                                    await launchUrl(Uri.parse(url));
                                  } else {
                                    throw 'Could not launch $url';
                                  }
                                },
                                child: Row(
                                  children: <Widget>[
                                    Icon(
                                      Icons.picture_as_pdf_outlined,
                                      color: Cores.AnalogasVerdeClaro,
                                      size: 14,
                                    ),
                                    SizedBox(width: 10),
                                    Text(
                                      'Plano estadual de Saúde',
                                      style: TextStyle(
                                        color: Cores.FonteConteudoCardSES,
                                        fontSize: 13,
                                        fontFamily: 'GoogleSansMedium',
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 5),
                              InkWell(
                                onTap: () async {
                                  final url =
                                      widget.post.mapas_estrategicos_das_ses ??
                                          '';
                                  if (await canLaunch(url)) {
                                    await launch(url);
                                  } else {
                                    throw 'Could not launch $url';
                                  }
                                },
                                child: Row(
                                  children: <Widget>[
                                    Icon(
                                      Icons.picture_as_pdf_outlined,
                                      color: Cores.AnalogasVerdeClaro,
                                      size: 14,
                                    ),
                                    SizedBox(width: 5),
                                    Text(
                                      'Mapa Estratégico da SES',
                                      style: TextStyle(
                                        color: Cores.FonteConteudoCardSES,
                                        fontSize: 13,
                                        fontFamily: 'GoogleSansMedium',
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
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
