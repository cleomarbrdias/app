import 'package:flutter/material.dart';

class MenuList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //final bloc = BlocProvider.getBloc<PostsBloc>();
    //final blocB = BlocProvider.getBloc<BibliotecaBloc>();

    return SafeArea(
      child: Container(
        width: 300,
        color: Color(0xFF009879),
        child: ListView(
          children: <Widget>[
            DrawerHeader(
                child: Container(
              width: 200,
              height: 100,
              decoration: BoxDecoration(
                image: new DecorationImage(
                  image: AssetImage("images/logo-mono.png"),
                  fit: BoxFit.cover,
                ),
              ),
            )),
            /*
            DrawerHeader(
              child: Image.asset('images/logo-mono.png'),
              decoration: BoxDecoration(
                  //color: Colors.white,
                  ),
            ),
            */
            ExpansionTile(
              trailing: Icon(
                Icons.keyboard_arrow_down,
                color: Color(0xfff3902b),
                size: 30,
              ),
              title: Text(
                "INSTITUCIONAL",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              /*
              leading: Image.asset(
                "images/estrelaconass.png",
                width: 30,
                height: 30,
              ),
              */
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                  child: Column(
                    children: <Widget>[
                      ListTile(
                        onTap: () {
                          //pop(context);
                          //Util.pagina = 5384;
                          //push(context, PagePagina());
                          //push(context, PagePagina(5384));
                        },
                        title: Text(
                          "Quem Somos",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        /*
                        leading: Image.asset(
                          "images/estrelaconass.png",
                          width: 18,
                          height: 18,
                        ),
                        */
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
                        /*
                        leading: Image.asset(
                          "images/estrelaconass.png",
                          width: 18,
                          height: 18,
                        ),
                        */
                      ),
                    ],
                  ),
                ),
              ],
            ),
            ListTile(
              onTap: () {
                //pop(context);
                //Util.cat = 6;
                //bloc.inCategoria.add(Util.cat);
                //pushReplacement(context, HomePage());
              },
              title: Text(
                "NOTICIAS",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              /*
              leading: Image.asset(
                "images/noticias.png",
                width: 28,
                height: 28,
              ),
              */
            ),
            ListTile(
              onTap: () {
                //pop(context);

                //Util.cat = 5;
                //bloc.inCategoria.add(Util.cat);
                //pushReplacement(context, HomePage());
              },
              title: Text(
                "CONASS INFORMA",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              /*
              leading: Image.asset(
                "images/conassinforma.png",
                width: 28,
                height: 28,
              ),
              */
            ),
            ListTile(
              onTap: () {
                //pop(context);
                //Util.cat = 2;
                //blocB.inCategoria.add(Util.catBiblioteca);
                //pushReplacement(context, PageBiblioteca());
              },
              title: Text(
                "BIBLIOTECA DIGITAL",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              /*
              leading: Image.asset(
                "images/biblioteca.png",
                width: 28,
                height: 28,
              ),
              */
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
              /*
              leading: Image.asset(
                "images/iconcit.png",
                width: 35,
                height: 35,
              ),
              */
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
                      /*
                      leading: Image.asset(
                        "images/iconcit.png",
                        width: 20,
                        height: 20,
                      ),
                      */
                    ),
                    ListTile(
                      onTap: () {
                        //pop(context);
                        //Util.pagina = 6055;
                        //push(context, PagePagina());
                      },
                      title: Text(
                        "Pautas e Resumos",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      /*
                      leading: Image.asset(
                        "images/iconcit.png",
                        width: 20,
                        height: 20,
                      ),
                      */
                    ),
                    ListTile(
                      onTap: () {
                        //pop(context);
                        //Util.pagina = 5744;
                        //push(context, PagePagina());
                      },
                      title: Text(
                        "Resoluções",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      /*
                      leading: Image.asset(
                        "images/iconcit.png",
                        width: 20,
                        height: 20,
                      ),
                      */
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
                "SECRETARIAS ESTADUAIS",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              /*
              leading: Image.asset(
                "images/mapa.png",
                width: 30,
                height: 30,
              ),
              */
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                  child: Column(children: <Widget>[
                    ListTile(
                      onTap: () {
                        //pop(context);
                        //Util.pagina = 5740;
                        //push(context, PagePagina());
                        // push(context, PagePagina(5740));
                      },
                      title: Text(
                        "Secretarias Estaduais de Saúde",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      /*
                      leading: Image.asset(
                        "images/mapa.png",
                        width: 18,
                        height: 18,
                      ),
                      */
                    ),
                    ListTile(
                      onTap: () {
                        //pop(context);

                        /*push(context, PostGestores());*/
                      },
                      title: Text(
                        "Gestores Estaduais",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      /*
                      leading: Image.asset(
                        "images/mapa.png",
                        width: 18,
                        height: 18,
                      ),
                      */
                    ),
                  ]),
                ),
              ],
            ),
            ListTile(
              onTap: () {
                //pop(context);

                //pushReplacement(context, PageMultimidia());
              },
              title: Text(
                "MULTIMÍDIA",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              /*
              leading: Image.asset(
                "images/multimidia.png",
                width: 25,
                height: 25,
              ),
              */
            ),
            ListTile(
              onTap: () {
                //pop(context);

                //pushReplacement(context, PageContato());
              },
              title: Text(
                "CONTATO",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              /*
                leading: Icon(
                  Icons.perm_contact_calendar,
                  color: Colors.white,
                )
                */
            ),
          ],
        ),
      ),
    );
  }
}
