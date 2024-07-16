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
    // final blocB = BlocProvider.getBloc<BibliotecaBloc>();
    // final blocC = BlocProvider.getBloc<PostSecretariosBloc>();

    return Drawer(
      // Definindo a cor de fundo do Drawer
      backgroundColor: Cores.VerdeEscuro,
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(color: Cores.VerdeClaro),
            margin: EdgeInsets.zero,
            padding: EdgeInsets.zero,
            child: Center(
              child: Image.asset(
                "images/logo-mono.png",
                height: 50,
              ),
            ),
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
              final blocB = BlocProvider.getBloc<BibliotecaBloc>();
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
                      final blocC = BlocProvider.getBloc<PostSecretariosBloc>();
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
    );
  }
}


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
