import 'package:conass/bloc/bloc_agenda_cit.dart';
import 'package:conass/paginas/page_agenda_cit.dart';
import 'package:provider/provider.dart';
import 'package:conass/bloc/biblioteca_bloc.dart';
import 'package:conass/bloc/post_bloc.dart';
import 'package:conass/bloc/post_camaras_tecnicas_bloc.dart';
import 'package:conass/bloc/post_presidentes_bloc.dart';
import 'package:conass/bloc/post_secretarios_bloc.dart';
import 'package:conass/paginas/home_page.dart';
import 'package:conass/paginas/page_biblioteca.dart';
import 'package:conass/paginas/page_camaras_tecnicas.dart';
import 'package:conass/paginas/page_pagina.dart';
import 'package:conass/paginas/page_presidentes.dart';
import 'package:conass/paginas/page_secretarios.dart';
import 'package:conass/util/cores.dart';
import 'package:conass/util/push.dart';
import 'package:conass/util/util.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class MenuList extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of<PostsBloc>(context, listen: false);
    final blocP = Provider.of<PostPresidentesBloc>(context, listen: false);
    final blocC = Provider.of<PostCamarasTecnicasBloc>(context, listen: false);
    final blocS = Provider.of<PostSecretariosBloc>(context, listen: false);
    final blocB = Provider.of<BibliotecaBloc>(context, listen: false);
    final blocCit = Provider.of<BlocAgendaCit>(context, listen: false);

    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Cores.PrimaryVerde,
        toolbarHeight: screenHeight * 0.03,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Container(
        color: Cores.VerdeMedio,
        child: Column(
          children: <Widget>[
            Container(
              color: Cores.PrimaryVerde,
              height: screenHeight * 0.10, // Altura ajustada
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: Image.asset(
                    "images/logo-conass-branco.png",
                    height: screenHeight * 0.50,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: <Widget>[
                  _buildExpansionTile(
                    context: context,
                    title: "Institucional",
                    children: [
                      _buildListTile(
                        context: context,
                        title: "Sobre o Conass",
                        onTap: () {
                          Navigator.of(context).pop();
                          Util.pagina = 43742;
                          push(context, PagePagina(scaffoldKey: scaffoldKey));
                        },
                      ),
                      _buildListTile(
                        context: context,
                        title: "Notas Conass",
                        trailing: Icons.keyboard_arrow_right_outlined,
                        onTap: () {
                          Navigator.of(context).pop();
                          Util.cat = 6;
                          bloc.inCategoria.add(Util.cat = 118);
                          pushReplacement(context, HomePage());
                        },
                      ),
                      _buildListTile(
                        context: context,
                        title: "Presidentes",
                        onTap: () {
                          Navigator.of(context).pop();
                          blocP.inCategoria.add('presidentes');
                          pushReplacement(context, PagePresidentes());
                        },
                      ),
                    ],
                  ),
                  _buildDivider(),
                  _buildListTile(
                    context: context,
                    title: "Secretarias Estaduais de Saúde",
                    trailing: Icons.keyboard_arrow_right_outlined,
                    onTap: () {
                      Navigator.of(context).pop();
                      blocS.inCategoria.add('secretarias-estaduai');
                      pushReplacement(context, PageSecretarios());
                    },
                  ),
                  _buildDivider(),
                  _buildListTile(
                    context: context,
                    title: "Câmaras Técnicas",
                    onTap: () {
                      Navigator.of(context).pop();
                      blocC.inCategoria.add('camaras-tecnicas');
                      pushReplacement(context, PageCamarasTecnicas());
                    },
                  ),
                  _buildDivider(),
                  _buildListTile(
                    context: context,
                    title: "Conass Informa",
                    trailing: Icons.keyboard_arrow_right_outlined,
                    onTap: () {
                      Navigator.of(context).pop();
                      int cat = 5;
                      bloc.inCategoria.add(cat);
                      pushReplacement(context, HomePage());
                    },
                  ),
                  _buildDivider(),
                  _buildListTile(
                    context: context,
                    title: "Biblioteca Digital",
                    trailing: Icons.keyboard_arrow_right_outlined,
                    onTap: () {
                      Navigator.of(context).pop();
                      Util.cat = 2;
                      blocB.inCategoria.add(Util.catBiblioteca);
                      pushReplacement(context, PageBiblioteca());
                    },
                  ),
                  _buildDivider(),
                  _buildExpansionTile(
                    context: context,
                    title: "CIT - Comissão Intergestores Tripartite",
                    children: [
                      _buildListTile(
                        context: context,
                        title: "Sobre a CIT",
                        onTap: () {
                          Navigator.of(context).pop();
                          Util.pagina = 43891;
                          push(context, PagePagina(scaffoldKey: scaffoldKey));
                        },
                      ),
                      _buildListTile(
                        context: context,
                        title: "Agenda",
                        onTap: () {
                          Navigator.of(context).pop();
                          blocCit.inCategoria.add('cit-agenda');
                          pushReplacement(context, PageAgendaCit());
                        },
                      ),
                      _buildListTile(
                        context: context,
                        title: "Pautas e Resumos",
                        onTap: () {
                          Navigator.of(context).pop();
                          Util.pagina = 6055;
                          push(context, PagePagina(scaffoldKey: scaffoldKey));
                        },
                      ),
                      _buildListTile(
                        context: context,
                        title: "Resoluções",
                        onTap: () {
                          Navigator.of(context).pop();
                          Util.pagina = 5744;
                          push(context, PagePagina(scaffoldKey: scaffoldKey));
                        },
                      ),
                    ],
                  ),
                  _buildDivider(),
                ],
              ),
            ),
            Container(
              color: Cores.PrimaryVerde,
              padding: EdgeInsets.zero,
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        _buildSocialMediaIcon(
                          url: 'http://www.facebook.com/conassoficial',
                          asset: 'images/facebook_app.png',
                        ),
                        _buildSocialMediaIcon(
                          url: 'https://twitter.com/CONASSoficial',
                          asset: 'images/x_app.png',
                        ),
                        _buildSocialMediaIcon(
                          url: 'http://www.youtube.com/conassoficial',
                          asset: 'images/youtube_app.png',
                        ),
                        _buildSocialMediaIcon(
                          url: 'https://www.instagram.com/conassoficial/',
                          asset: 'images/instagram_app.png',
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 5, 10, 25),
                    child: InkWell(
                      onTap: () => _launchURL(
                          'https://maps.app.goo.gl/ZUuwG54hnbHVdE628'),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(Icons.location_on_outlined,
                              color: Colors.orange),
                          SizedBox(width: 8),
                          Text(
                            'Setor Comercial Sul, Quadra 9, Torre C, Sala 1105, Edifício\n'
                            'Parque Cidade Corporate Brasília/DF CEP: 70308-200',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.normal,
                              fontSize: 8,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildListTile({
    required BuildContext context,
    required String title,
    IconData? trailing,
    required VoidCallback onTap,
  }) {
    return ListTile(
      onTap: onTap,
      title: Text(
        title,
        style: TextStyle(
          color: Colors.white,
        ),
      ),
      trailing: trailing != null
          ? Icon(
              trailing,
              color: Colors.white,
              size: 30,
            )
          : null,
    );
  }

  Widget _buildExpansionTile({
    required BuildContext context,
    required String title,
    required List<Widget> children,
  }) {
    return ExpansionTile(
      trailing: Icon(
        Icons.keyboard_arrow_down,
        color: Colors.white,
        size: 30,
      ),
      title: Text(
        title,
        style: TextStyle(
          color: Colors.white,
        ),
      ),
      children: children,
    );
  }

  Widget _buildDivider() {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0),
      child: Divider(
        color: Cores.VerdeEscuro,
        thickness: 1,
      ),
    );
  }

  Widget _buildSocialMediaIcon({
    required String url,
    required String asset,
  }) {
    return InkWell(
      onTap: () => _launchURL(url),
      child: Image.asset(
        asset,
        width: 40,
        height: 40,
      ),
    );
  }

  void _launchURL(String res) async {
    final Uri uri = Uri.parse(res);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $res';
    }
  }
}




// import 'package:conass/bloc/bloc_agenda_cit.dart';
// import 'package:conass/paginas/page_agenda_cit.dart';
// import 'package:conass/paginas/page_multimidia.dart';
// import 'package:provider/provider.dart';
// import 'package:conass/bloc/biblioteca_bloc.dart';
// import 'package:conass/bloc/post_bloc.dart';
// import 'package:conass/bloc/post_camaras_tecnicas_bloc.dart';
// import 'package:conass/bloc/post_presidentes_bloc.dart';
// import 'package:conass/bloc/post_secretarios_bloc.dart';
// import 'package:conass/paginas/home_page.dart';
// import 'package:conass/paginas/page_biblioteca.dart';
// import 'package:conass/paginas/page_camaras_tecnicas.dart';
// import 'package:conass/paginas/page_pagina.dart';
// import 'package:conass/paginas/page_presidentes.dart';
// import 'package:conass/paginas/page_secretarios.dart';
// import 'package:conass/util/cores.dart';
// import 'package:conass/util/push.dart';
// import 'package:conass/util/util.dart';
// import 'package:flutter/material.dart';
// import 'package:url_launcher/url_launcher.dart';

// class MenuList extends StatelessWidget {
//   final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

//   @override
//   Widget build(BuildContext context) {
//     final bloc = Provider.of<PostsBloc>(context, listen: false);
//     final blocP = Provider.of<PostPresidentesBloc>(context, listen: false);
//     final blocC = Provider.of<PostCamarasTecnicasBloc>(context, listen: false);
//     final blocS = Provider.of<PostSecretariosBloc>(context, listen: false);
//     final blocB = Provider.of<BibliotecaBloc>(context, listen: false);
//     final blocCit = Provider.of<BlocAgendaCit>(context, listen: false);

//     double screenHeight = MediaQuery.of(context).size.height;

//     return Drawer(
//       child: Column(
//         children: <Widget>[
//           Container(
//             color: Cores.PrimaryVerde,
//             height: screenHeight * 0.25,
//             child: Center(
//               child: Padding(
//                 padding: const EdgeInsets.fromLTRB(0, 90.0, 0, 0),
//                 child: Image.asset(
//                   "images/logo-conass-branco.png",
//                   height: 70,
//                   fit: BoxFit.contain,
//                 ),
//               ),
//             ),
//           ),
//           Expanded(
//             child: ListView(
//               padding: EdgeInsets.zero,
//               children: <Widget>[
//                 _buildExpansionTile(
//                   context: context,
//                   title: "Institucional",
//                   children: [
//                     _buildListTile(
//                       context: context,
//                       title: "Sobre o Conass",
//                       onTap: () {
//                         pop(context);
//                         Util.pagina = 43742;
//                         push(context, PagePagina(scaffoldKey: scaffoldKey));
//                       },
//                     ),
//                     _buildListTile(
//                       context: context,
//                       title: "Notas Conass",
//                       trailing: Icons.keyboard_arrow_right_outlined,
//                       onTap: () {
//                         pop(context);
//                         Util.cat = 6;
//                         bloc.inCategoria.add(Util.cat = 118);
//                         pushReplacement(context, HomePage());
//                       },
//                     ),
//                     _buildListTile(
//                       context: context,
//                       title: "Presidentes",
//                       onTap: () {
//                         pop(context);
//                         blocP.inCategoria.add('presidentes');
//                         pushReplacement(context, PagePresidentes());
//                       },
//                     ),
//                   ],
//                 ),
//                 _buildDivider(),
//                 _buildListTile(
//                   context: context,
//                   title: "Secretarias Estaduais de Saúde",
//                   trailing: Icons.keyboard_arrow_right_outlined,
//                   onTap: () {
//                     pop(context);
//                     blocS.inCategoria.add('secretarias-estaduai');
//                     pushReplacement(context, PageSecretarios());
//                   },
//                 ),
//                 _buildDivider(),
//                 _buildListTile(
//                   context: context,
//                   title: "Câmaras Técnicas",
//                   onTap: () {
//                     pop(context);
//                     blocC.inCategoria.add('camaras-tecnicas');
//                     pushReplacement(context, PageCamarasTecnicas());
//                   },
//                 ),
//                 _buildDivider(),
//                 _buildListTile(
//                   context: context,
//                   title: "Conass Informa",
//                   trailing: Icons.keyboard_arrow_right_outlined,
//                   onTap: () {
//                     pop(context);
//                     int cat = 5;
//                     bloc.inCategoria.add(cat);
//                     pushReplacement(context, HomePage());
//                   },
//                 ),
//                 _buildDivider(),
//                 _buildListTile(
//                   context: context,
//                   title: "Biblioteca Digital",
//                   trailing: Icons.keyboard_arrow_right_outlined,
//                   onTap: () {
//                     pop(context);
//                     Util.cat = 2;
//                     blocB.inCategoria.add(Util.catBiblioteca);
//                     pushReplacement(context, PageBiblioteca());
//                   },
//                 ),
//                 _buildDivider(),
//                 _buildExpansionTile(
//                   context: context,
//                   title: "CIT - Comissão Intergestores Tripartite",
//                   children: [
//                     _buildListTile(
//                       context: context,
//                       title: "Sobre a CIT",
//                       onTap: () {
//                         pop(context);
//                         Util.pagina = 43891;
//                         push(context, PagePagina(scaffoldKey: scaffoldKey));
//                       },
//                     ),
//                     _buildListTile(
//                       context: context,
//                       title: "Agenda",
//                       onTap: () {
//                         pop(context);
//                         blocCit.inCategoria.add('cit-agenda');
//                         pushReplacement(context, PageAgendaCit());
//                       },
//                     ),
//                     _buildListTile(
//                       context: context,
//                       title: "Pautas e Resumos",
//                       onTap: () {
//                         pop(context);
//                         Util.pagina = 6055;
//                         push(context, PagePagina(scaffoldKey: scaffoldKey));
//                       },
//                     ),
//                     _buildListTile(
//                       context: context,
//                       title: "Resoluções",
//                       onTap: () {
//                         pop(context);
//                         Util.pagina = 5744;
//                         push(context, PagePagina(scaffoldKey: scaffoldKey));
//                       },
//                     ),
//                   ],
//                 ),
//                 _buildDivider(),
//               ],
//             ),
//           ),
//           Container(
//             color: Cores.PrimaryVerde,
//             padding: EdgeInsets.zero,
//             child: Column(
//               children: <Widget>[
//                 Padding(
//                   padding: const EdgeInsets.all(16.0),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: <Widget>[
//                       _buildSocialMediaIcon(
//                         url: 'http://www.facebook.com/conassoficial',
//                         asset: 'images/facebook_app.png',
//                       ),
//                       _buildSocialMediaIcon(
//                         url: 'https://twitter.com/CONASSoficial',
//                         asset: 'images/x_app.png',
//                       ),
//                       _buildSocialMediaIcon(
//                         url: 'http://www.youtube.com/conassoficial',
//                         asset: 'images/youtube_app.png',
//                       ),
//                       _buildSocialMediaIcon(
//                         url: 'https://www.instagram.com/conassoficial/',
//                         asset: 'images/instagram_app.png',
//                       ),
//                     ],
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.fromLTRB(10, 5, 10, 25),
//                   child: InkWell(
//                     onTap: () =>
//                         _launchURL('https://maps.app.goo.gl/ZUuwG54hnbHVdE628'),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: <Widget>[
//                         Icon(Icons.location_on_outlined, color: Colors.orange),
//                         SizedBox(width: 8),
//                         Text(
//                           'Setor Comercial Sul, Quadra 9, Torre C, Sala 1105, Edifício\n'
//                           'Parque Cidade Corporate Brasília/DF CEP: 70308-200',
//                           textAlign: TextAlign.center,
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontWeight: FontWeight.normal,
//                             fontSize: 8,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildListTile({
//     required BuildContext context,
//     required String title,
//     IconData? trailing,
//     required VoidCallback onTap,
//   }) {
//     return ListTile(
//       onTap: onTap,
//       title: Text(
//         title,
//         style: TextStyle(
//           color: Colors.white,
//         ),
//       ),
//       trailing: trailing != null
//           ? Icon(
//               trailing,
//               color: Colors.white,
//               size: 30,
//             )
//           : null,
//     );
//   }

//   Widget _buildExpansionTile({
//     required BuildContext context,
//     required String title,
//     required List<Widget> children,
//   }) {
//     return ExpansionTile(
//       trailing: Icon(
//         Icons.keyboard_arrow_down,
//         color: Colors.white,
//         size: 30,
//       ),
//       title: Text(
//         title,
//         style: TextStyle(
//           color: Colors.white,
//         ),
//       ),
//       children: children,
//     );
//   }

//   Widget _buildDivider() {
//     return Padding(
//       padding: const EdgeInsets.only(left: 16.0),
//       child: Divider(
//         color: Cores.VerdeEscuro,
//         thickness: 1,
//       ),
//     );
//   }

//   Widget _buildSocialMediaIcon({
//     required String url,
//     required String asset,
//   }) {
//     return InkWell(
//       onTap: () => _launchURL(url),
//       child: Image.asset(
//         asset,
//         width: 40,
//         height: 40,
//       ),
//     );
//   }

//   void _launchURL(String res) async {
//     final Uri uri = Uri.parse(res);
//     if (await canLaunchUrl(uri)) {
//       await launchUrl(uri);
//     } else {
//       throw 'Could not launch $res';
//     }
//   }
// }
