import 'package:conass/bloc/bloc_agenda_cit.dart';
import 'package:conass/paginas/page_agenda_cit.dart';
import 'package:conass/paginas/page_multimidia.dart';
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

    return Drawer(
      child: Column(
        children: <Widget>[
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                Container(
                  color: Cores.PrimaryVerde,
                  padding: EdgeInsets.zero,
                  height: 200,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 90.0, 0, 0),
                    child: Center(
                      child: Image.asset(
                        "images/logo-conass-branco.png",
                        height: 70,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
                ExpansionTile(
                  trailing: Icon(
                    Icons.keyboard_arrow_down,
                    color: Colors.white,
                    size: 30,
                  ),
                  title: Text(
                    "Institucional",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                      child: Column(
                        children: <Widget>[
                          ListTile(
                            onTap: () {
                              pop(context);
                              Util.pagina = 43742;
                              push(context,
                                  PagePagina(scaffoldKey: scaffoldKey));
                            },
                            title: Text(
                              "Sobre o Conass",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                          ListTile(
                            onTap: () {
                              pop(context);
                              Util.cat = 6;
                              bloc.inCategoria.add(Util.cat = 118);
                              pushReplacement(context, HomePage());
                            },
                            title: Text(
                              "Notas Conass",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            trailing: Icon(
                              Icons.keyboard_arrow_right_outlined,
                              color: Colors.white,
                              size: 30,
                            ),
                          ),
                          ListTile(
                            onTap: () {
                              pop(context);
                              blocP.inCategoria.add('presidentes');
                              pushReplacement(context, PagePresidentes());
                            },
                            title: Text(
                              "Presidentes",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: Divider(
                    color: Cores.VerdeEscuro,
                    thickness: 1,
                  ),
                ),
                ListTile(
                  onTap: () {
                    pop(context);
                    blocS.inCategoria.add('secretarias-estaduai');
                    pushReplacement(context, PageSecretarios());
                  },
                  title: Text(
                    "Secretarias Estaduais de Saúde",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  trailing: Icon(
                    Icons.keyboard_arrow_right_outlined,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: Divider(
                    color: Cores.VerdeEscuro,
                    thickness: 1,
                  ),
                ),
                ListTile(
                  onTap: () {
                    pop(context);
                    blocC.inCategoria.add('camaras-tecnicas');
                    pushReplacement(context, PageCamarasTecnicas());
                  },
                  title: Text(
                    "Câmaras Técnicas",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: Divider(
                    color: Cores.VerdeEscuro,
                    thickness: 1,
                  ),
                ),
                ListTile(
                  onTap: () {
                    pop(context);
                    int cat = 5;
                    bloc.inCategoria.add(cat);
                    pushReplacement(context, HomePage());
                  },
                  title: Text(
                    "Conass Informa",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  trailing: Icon(
                    Icons.keyboard_arrow_right_outlined,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: Divider(
                    color: Cores.VerdeEscuro,
                    thickness: 1,
                  ),
                ),
                ListTile(
                  onTap: () {
                    pop(context);
                    Util.cat = 2;
                    blocB.inCategoria.add(Util.catBiblioteca);
                    pushReplacement(context, PageBiblioteca());
                  },
                  title: Text(
                    "Biblioteca Digital",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  trailing: Icon(
                    Icons.keyboard_arrow_right_outlined,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: Divider(
                    color: Cores.VerdeEscuro,
                    thickness: 1,
                  ),
                ),
                ExpansionTile(
                  trailing: Icon(
                    Icons.keyboard_arrow_down,
                    color: Colors.white,
                    size: 30,
                  ),
                  title: Text(
                    "CIT - Comissão Intergestores Tripartite",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                      child: Column(children: <Widget>[
                        ListTile(
                          onTap: () {
                            pop(context);
                            Util.pagina = 43891;
                            push(context, PagePagina(scaffoldKey: scaffoldKey));
                          },
                          title: Text(
                            "Sobre a CIT",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                        ListTile(
                          onTap: () {
                            pop(context);
                            blocCit.inCategoria.add('cit-agenda');
                            pushReplacement(context, PageAgendaCit());
                          },
                          title: Text(
                            "Agenda",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                        ListTile(
                          onTap: () {
                            pop(context);
                            Util.pagina = 6055;
                            push(context, PagePagina(scaffoldKey: scaffoldKey));
                          },
                          title: Text(
                            "Pautas e Resumos",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                        ListTile(
                          onTap: () {
                            pop(context);
                            Util.pagina = 5744;
                            push(context, PagePagina(scaffoldKey: scaffoldKey));
                          },
                          title: Text(
                            "Resoluções",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ]),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: Divider(
                    color: Cores.VerdeEscuro,
                    thickness: 1,
                  ),
                ),
                // ListTile(
                //   onTap: () {
                //     pop(context);
                //     pushReplacement(context, PageMultimidia());
                //   },
                //   title: Text(
                //     "Multimídia",
                //     style: TextStyle(
                //       color: Colors.white,
                //     ),
                //   ),
                //   trailing: Icon(
                //     Icons.keyboard_arrow_right_outlined,
                //     color: Colors.white,
                //     size: 30,
                //   ),
                // ),
                // Padding(
                //   padding: const EdgeInsets.only(left: 16.0),
                //   child: Divider(
                //     color: Cores.VerdeEscuro,
                //     thickness: 1,
                //   ),
                // ),
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
                      InkWell(
                        onTap: () =>
                            _launchURL('http://www.facebook.com/conassoficial'),
                        child: Image.asset('images/facebook_app.png',
                            width: 40, height: 40),
                      ),
                      InkWell(
                          onTap: () =>
                              _launchURL('https://twitter.com/CONASSoficial'),
                          child: Image.asset('images/x_app.png',
                              width: 40, height: 40)),
                      InkWell(
                        onTap: () =>
                            _launchURL('http://www.youtube.com/conassoficial'),
                        child: Image.asset('images/youtube_app.png',
                            width: 40, height: 40),
                      ),
                      InkWell(
                        onTap: () => _launchURL(
                            'https://www.instagram.com/conassoficial/'),
                        child: Image.asset('images/instagram_app.png',
                            width: 40, height: 40),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 5, 10, 25),
                  child: Column(
                    children: <Widget>[
                      InkWell(
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
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

void _launchURL(String res) async {
  final Uri uri = Uri.parse(res);
  if (await canLaunchUrl(uri)) {
    await launchUrl(uri);
  } else {
    throw 'Could not launch $res';
  }
}



// import 'package:bloc_pattern/bloc_pattern.dart';
// import 'package:conass/bloc/biblioteca_bloc.dart';
// import 'package:conass/bloc/post_bloc.dart';
// import 'package:conass/bloc/post_camaras_tecnicas_bloc.dart';
// import 'package:conass/bloc/post_presidentes_bloc.dart';
// import 'package:conass/bloc/post_secretarios_bloc.dart';
// import 'package:conass/paginas/home_page.dart';
// import 'package:conass/paginas/page_biblioteca.dart';
// import 'package:conass/paginas/page_camaras_tecnicas.dart';
// import 'package:conass/paginas/page_contato.dart';
// import 'package:conass/paginas/page_multimidia.dart';
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
//     final bloc = BlocProvider.getBloc<PostsBloc>();
//     // final blocB = BlocProvider.getBloc<BibliotecaBloc>();
//     // final blocC = BlocProvider.getBloc<PostSecretariosBloc>();

//     return Drawer(
//       // Definindo a cor de fundo do Drawer
//       // backgroundColor: Cores.VerdeMedio,
//       child: ListView(
//         padding: EdgeInsets.zero,
//         children: <Widget>[
//           Container(
//             color: Cores.PrimaryVerde,
//             padding: EdgeInsets.zero,
//             height: 200,
//             child: Padding(
//               padding: const EdgeInsets.fromLTRB(0, 90.0, 0, 0),
//               child: Center(
//                 child: Image.asset(
//                   "images/logo-conass-branco.png",
//                   height: 70,
//                   fit: BoxFit.contain,
//                 ),
//               ),
//             ),
//           ),

//           ExpansionTile(
//             trailing: Icon(
//               Icons.keyboard_arrow_down,
//               color: Colors.white,
//               size: 30,
//             ),
//             title: Text(
//               "Institucional",
//               style: TextStyle(
//                 color: Colors.white,
//               ),
//             ),
//             children: <Widget>[
//               Padding(
//                 padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
//                 child: Column(
//                   children: <Widget>[
//                     ListTile(
//                       onTap: () {
//                         pop(context);
//                         Util.pagina = 43742;
//                         print("Sobre o Conass");
//                         push(context, PagePagina(scaffoldKey: scaffoldKey));
//                       },
//                       title: Text(
//                         "Sobre o Conass",
//                         style: TextStyle(
//                           color: Colors.white,
//                         ),
//                       ),
//                     ),
//                     ListTile(
//                       onTap: () {
//                         pop(context);
//                         Util.cat = 6;
//                         bloc.inCategoria.add(Util.cat = 118);
//                         pushReplacement(context, HomePage());
//                       },
//                       title: Text(
//                         "Notas Conass",
//                         style: TextStyle(
//                           color: Colors.white,
//                         ),
//                       ),
//                       trailing: Icon(
//                         Icons.keyboard_arrow_right_outlined,
//                         color: Colors.white,
//                         size: 30,
//                       ),
//                     ),
//                     ListTile(
//                       onTap: () {
//                         final blocP =
//                             BlocProvider.getBloc<PostPresidentesBloc>();
//                         pop(context);
//                         blocP.inCategoria.add('presidentes');
//                         pushReplacement(context, PagePresidentes());
//                       },
//                       title: Text(
//                         "Presidentes",
//                         style: TextStyle(
//                           color: Colors.white,
//                         ),
//                       ),
//                     ),
//                     ListTile(
//                       onTap: () {
//                         final blocC =
//                             BlocProvider.getBloc<PostCamarasTecnicasBloc>();
//                         pop(context);
//                         blocC.inCategoria.add('camaras-tecnicas');
//                         pushReplacement(context, PageCamarasTecnicas());
//                       },
//                       title: Text(
//                         "Câmaras Técnicas",
//                         style: TextStyle(
//                           color: Colors.white,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//           Padding(
//             padding: const EdgeInsets.only(left: 16.0),
//             child: Divider(
//               color: Cores.VerdeEscuro,
//               thickness: 1,
//             ),
//           ),
//           ListTile(
//             onTap: () {
//               pop(context);
//               Util.cat = 6;
//               bloc.inCategoria.add(Util.cat = 6);
//               pushReplacement(context, HomePage());
//             },
//             title: Text(
//               "Notícias",
//               style: TextStyle(
//                 color: Colors.white,
//               ),
//             ),
//             trailing: Icon(
//               Icons.keyboard_arrow_right_outlined,
//               color: Colors.white,
//               size: 30,
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.only(left: 16.0),
//             child: Divider(
//               color: Cores.VerdeEscuro,
//               thickness: 1,
//             ),
//           ),
//           ListTile(
//             onTap: () {
//               pop(context);

//               int cat = 5;
//               bloc.inCategoria.add(cat);
//               pushReplacement(context, HomePage());
//             },
//             title: Text(
//               "Conass Informa",
//               style: TextStyle(
//                 color: Colors.white,
//               ),
//             ),
//             trailing: Icon(
//               Icons.keyboard_arrow_right_outlined,
//               color: Colors.white,
//               size: 30,
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.only(left: 16.0),
//             child: Divider(
//               color: Cores.VerdeEscuro,
//               thickness: 1,
//             ),
//           ),
//           ListTile(
//             onTap: () {
//               final blocB = BlocProvider.getBloc<BibliotecaBloc>();
//               pop(context);
//               Util.cat = 2;
//               blocB.inCategoria.add(Util.catBiblioteca);
//               pushReplacement(context, PageBiblioteca());
//             },
//             title: Text(
//               "Biblioteca Digital",
//               style: TextStyle(
//                 color: Colors.white,
//               ),
//             ),
//             trailing: Icon(
//               Icons.keyboard_arrow_right_outlined,
//               color: Colors.white,
//               size: 30,
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.only(left: 16.0),
//             child: Divider(
//               color: Cores.VerdeEscuro,
//               thickness: 1,
//             ),
//           ),
//           ExpansionTile(
//             trailing: Icon(
//               Icons.keyboard_arrow_down,
//               color: Colors.white,
//               size: 30,
//             ),
//             title: Text(
//               "CIT - Comissão Intergestores Tripartite",
//               style: TextStyle(
//                 color: Colors.white,
//               ),
//             ),
//             children: <Widget>[
//               Padding(
//                 padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
//                 child: Column(children: <Widget>[
//                   ListTile(
//                     onTap: () {
//                       pop(context);
//                       Util.pagina = 6052;
//                       //push(context, PagePagina());
//                       push(context, PagePagina(scaffoldKey: scaffoldKey));
//                     },
//                     title: Text(
//                       "Agenda",
//                       style: TextStyle(
//                         color: Colors.white,
//                       ),
//                     ),
//                   ),
//                   ListTile(
//                     onTap: () {
//                       pop(context);
//                       Util.pagina = 6055;
//                       //push(context, PagePagina());
//                     },
//                     title: Text(
//                       "Pautas e Resumos",
//                       style: TextStyle(
//                         color: Colors.white,
//                       ),
//                     ),
//                   ),
//                   ListTile(
//                     onTap: () {
//                       pop(context);
//                       Util.pagina = 5744;
//                       //push(context, PagePagina());
//                     },
//                     title: Text(
//                       "Resoluções",
//                       style: TextStyle(
//                         color: Colors.white,
//                       ),
//                     ),
//                   ),
//                 ]),
//               ),
//             ],
//           ),
//           Padding(
//             padding: const EdgeInsets.only(left: 16.0),
//             child: Divider(
//               color: Cores.VerdeEscuro,
//               thickness: 1,
//             ),
//           ),
//           ListTile(
//             onTap: () {
//               final blocC = BlocProvider.getBloc<PostSecretariosBloc>();
//               pop(context);
//               blocC.inCategoria.add('secretarias-estaduai');
//               pushReplacement(context, PageSecretarios());
//             },
//             title: Text(
//               "Secretarias Estaduais de Saúde",
//               style: TextStyle(
//                 color: Colors.white,
//               ),
//             ),
//             trailing: Icon(
//               Icons.keyboard_arrow_right_outlined,
//               color: Colors.white,
//               size: 30,
//             ),
//           ),
//           // ExpansionTile(
//           //   trailing: Icon(
//           //     Icons.keyboard_arrow_down,
//           //     color: Colors.white,
//           //     size: 30,
//           //   ),
//           //   title: Text(
//           //     "Secretarias Estaduais",
//           //     style: TextStyle(
//           //       color: Colors.white,
//           //     ),
//           //   ),
//           //   children: <Widget>[
//           //     Padding(
//           //       padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
//           //       child: Column(children: <Widget>[
//           //         ListTile(
//           //           onTap: () {
//           //             final blocC = BlocProvider.getBloc<PostSecretariosBloc>();
//           //             pop(context);
//           //             blocC.inCategoria.add('secretarias-estaduai');
//           //             pushReplacement(context, PageSecretarios());
//           //           },
//           //           title: Text(
//           //             "Secretarias Estaduais de Saúde",
//           //             style: TextStyle(
//           //               color: Colors.white,
//           //             ),
//           //           ),
//           //         ),
//           //         /*
//           //         ListTile(
//           //           onTap: () {
//           //             pop(context);

//           //             /*push(context, PostGestores());*/
//           //           },
//           //           title: Text(
//           //             "Gestores Estaduais",
//           //             style: TextStyle(
//           //               color: Colors.white,
//           //             ),
//           //           ),
//           //         ),
//           //         */
//           //       ]),
//           //     ),
//           //   ],
//           // ),
//           Padding(
//             padding: const EdgeInsets.only(left: 16.0),
//             child: Divider(
//               color: Cores.VerdeEscuro,
//               thickness: 1,
//             ),
//           ),
//           ListTile(
//             onTap: () {
//               pop(context);

//               pushReplacement(context, PageMultimidia());
//             },
//             title: Text(
//               "Multimídia",
//               style: TextStyle(
//                 color: Colors.white,
//               ),
//             ),
//             trailing: Icon(
//               Icons.keyboard_arrow_right_outlined,
//               color: Colors.white,
//               size: 30,
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.only(left: 16.0),
//             child: Divider(
//               color: Cores.VerdeEscuro,
//               thickness: 1,
//             ),
//           ),
//           Container(
//               color: Cores.PrimaryVerde,
//               padding: EdgeInsets.zero,
//               child: Column(
//                 children: <Widget>[
//                   Padding(
//                     padding: const EdgeInsets.all(16.0),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       children: <Widget>[
//                         InkWell(
//                           onTap: () => _launchURL(
//                               'http://www.facebook.com/conassoficial'),
//                           child: Image.asset('images/facebook_app.png',
//                               width: 40, height: 40),
//                         ),
//                         InkWell(
//                             onTap: () =>
//                                 _launchURL('https://twitter.com/CONASSoficial'),
//                             child: Image.asset('images/x_app.png',
//                                 width: 40, height: 40)),
//                         InkWell(
//                           onTap: () => _launchURL(
//                               'http://www.youtube.com/conassoficial'),
//                           child: Image.asset('images/youtube_app.png',
//                               width: 40, height: 40),
//                         ),
//                         InkWell(
//                           onTap: () => _launchURL(
//                               'https://www.instagram.com/conassoficial/'),
//                           child: Image.asset('images/instagram_app.png',
//                               width: 40, height: 40),
//                         ),
//                       ],
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.fromLTRB(10, 5, 10, 25),
//                     child: Column(
//                       children: <Widget>[
//                         InkWell(
//                           onTap: () => _launchURL(
//                               'https://maps.app.goo.gl/ZUuwG54hnbHVdE628'),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: <Widget>[
//                               Icon(Icons.location_on_outlined,
//                                   color: Colors.orange),
//                               SizedBox(width: 8),
//                               Text(
//                                 'Setor Comercial Sul, Quadra 9, Torre C, Sala 1105, Edifício\n'
//                                 'Parque Cidade Corporate Brasília/DF CEP: 70308-200',
//                                 textAlign: TextAlign.center,
//                                 style: TextStyle(
//                                   color: Colors.white,
//                                   fontWeight: FontWeight.normal,
//                                   fontSize: 8,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               )),
//           // ListTile(
//           //   onTap: () {
//           //     pop(context);

//           //     pushReplacement(context, PageContato());
//           //   },
//           //   title: Text(
//           //     "Contato",
//           //     style: TextStyle(
//           //       color: Colors.white,
//           //     ),
//           //   ),
//           // ),
//         ],
//       ),
//     );
//   }
// }

// void _launchURL(String res) async {
//   final Uri uri = Uri.parse(res);
//   if (await canLaunchUrl(uri)) {
//     await launchUrl(uri);
//   } else {
//     throw 'Could not launch $res';
//   }
// }



/*
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:conass/bloc/biblioteca_bloc.dart';
import 'package:conass/bloc/post_bloc.dart';
import 'package:conass/bloc/post_secretarios_bloc.dart';
import 'package:conass/paginas/home_page.dart';
import 'package:conass/paginas/page_biblioteca.dart';
import 'package:conass/paginas/page_contato.dart';
import 'package:conass/paginas/page_multimidia.dart';
import 'package:conass/paginas/page_secretarios.dart';
import 'package:conass/util/cores.dart';
import 'package:conass/util/push.dart';
import 'package:conass/util/util.dart';
import 'package:flutter/material.dart';

class MenuList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.getBloc<PostsBloc>();
    final blocB = BlocProvider.getBloc<BibliotecaBloc>();
    final blocC = BlocProvider.getBloc<PostSecretariosBloc>();

    return SafeArea(
      child: Container(
        width: 300,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Cores.VerdeEscuro, Cores.VerdeMedio],
            begin: Alignment.bottomRight,
            end: Alignment.topLeft,
          ),
          borderRadius:
              BorderRadius.circular(10), // Se desejar cantos arredondados
        ),
        child: ListView(
          children: <Widget>[
            SizedBox(
              height: 100,
              child: DrawerHeader(
                  child: Image.asset(
                "images/logo-mono.png",
                height: 20,
              )),
            ),
            ExpansionTile(
              trailing: Icon(
                Icons.keyboard_arrow_down,
                color: Cores.PrimaryLaranja,
                size: 30,
              ),
              title: Text(
                "INSTITUCIONAL",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                  child: Column(
                    children: <Widget>[
                      ListTile(
                        onTap: () {
                          pop(context);
                          Util.pagina = 5384;
                          //push(context, PagePagina());
                          //push(context, PagePagina(5384));
                        },
                        title: Text(
                          "Quem Somos",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                      ListTile(
                        onTap: () {
                          //pop(context);
                          //pushReplacement(context, PagePresidentes());
                          //push(context, PagePresidentes());
                        },
                        title: Text(
                          "Presidentes",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            ListTile(
              onTap: () {
                pop(context);
                Util.cat = 6;
                bloc.inCategoria.add(Util.cat = 6);
                pushReplacement(context, HomePage());
              },
              title: Text(
                "Notícias",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            ListTile(
              onTap: () {
                pop(context);

                int cat = 5;
                bloc.inCategoria.add(cat);
                pushReplacement(context, HomePage());
              },
              title: Text(
                "Conass Informa",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            ListTile(
              onTap: () {
                pop(context);
                Util.cat = 2;
                blocB.inCategoria.add(Util.catBiblioteca);
                pushReplacement(context, PageBiblioteca());
              },
              title: Text(
                "Biblioteca Digital",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            ExpansionTile(
              trailing: Icon(
                Icons.keyboard_arrow_down,
                color: Color(0xfff3902b),
                size: 30,
              ),
              title: Text(
                "CIT - Comissão Intergestores Tripartite",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                  child: Column(children: <Widget>[
                    ListTile(
                      onTap: () {
                        //pop(context);
                        //Util.pagina = 6052;
                        //push(context, PagePagina());
                      },
                      title: Text(
                        "Agenda",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    ListTile(
                      onTap: () {
                        pop(context);
                        Util.pagina = 6055;
                        //push(context, PagePagina());
                      },
                      title: Text(
                        "Pautas e Resumos",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    ListTile(
                      onTap: () {
                        pop(context);
                        Util.pagina = 5744;
                        //push(context, PagePagina());
                      },
                      title: Text(
                        "Resoluções",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ]),
                ),
              ],
            ),
            ExpansionTile(
              trailing: Icon(
                Icons.keyboard_arrow_down,
                color: Color(0xfff3902b),
                size: 30,
              ),
              title: Text(
                "Secretarias Estaduais",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                  child: Column(children: <Widget>[
                    ListTile(
                      onTap: () {
                        pop(context);
                        blocC.inCategoria.add('secretarias-estaduai');
                        pushReplacement(context, PageSecretarios());
                      },
                      title: Text(
                        "Secretarias Estaduais de Saúde",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    ListTile(
                      onTap: () {
                        pop(context);

                        /*push(context, PostGestores());*/
                      },
                      title: Text(
                        "Gestores Estaduais",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ]),
                ),
              ],
            ),
            ListTile(
              onTap: () {
                pop(context);

                pushReplacement(context, PageMultimidia());
              },
              title: Text(
                "Multimídia",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            ListTile(
              onTap: () {
                pop(context);

                pushReplacement(context, PageContato());
              },
              title: Text(
                "Contato",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
*/
