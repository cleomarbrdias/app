import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:conass/bloc/pagina_bloc.dart';
import 'package:conass/util/util.dart';
import 'package:flutter/material.dart';
import 'package:conass/componente/pagina.dart';

class PagePagina extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;

  PagePagina({Key? key, required this.scaffoldKey}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.getBloc<PaginaBloc>();
    print("Entrou na Page Pagina");
    bloc.inPage.add(Util.pagina);

    return Scaffold(
      key: scaffoldKey,
      body: StreamBuilder<Pagina>(
        stream: bloc.outPage,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            print("Erro no snapshot: ${snapshot.error}");
            return Container(
              padding: EdgeInsets.all(24),
              child: Center(
                child: Text(
                  snapshot.error.toString(),
                  style: TextStyle(fontSize: 20, color: Colors.grey),
                ),
              ),
            );
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            print("Snapshot está aguardando dados");
            return Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Color(0xff008979)),
              ),
            );
          } else if (snapshot.hasData) {
            print("Dados do snapshot: ${snapshot.data}");
            final pagina = snapshot.data;
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [Text("Pagina")],
              ),
            );
          } else {
            print("Snapshot sem dados");
            return Container(
              child: Center(
                child: Text("Página não encontrada...."),
              ),
            );
          }
        },
      ),
    );
  }
}

/*
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:conass/bloc/pagina_bloc.dart';
import 'package:conass/util/util.dart';
import 'package:flutter/material.dart';

class PagePagina extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;

  PagePagina({Key? key, required this.scaffoldKey}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.getBloc<PaginaBloc>();
    print("Entrou na Page Pagina");
    bloc.inPage.add(Util.pagina);

    return Scaffold(
        body: StreamBuilder(
            stream: bloc.outPage,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Container(
                    padding: EdgeInsets.all(24),
                    child: Center(
                      child: Text(
                        snapshot.error.toString(),
                        style: TextStyle(fontSize: 20, color: Colors.grey),
                      ),
                    ));
              } else if (!snapshot.hasData) {
                return Center(
                  child: Container(
                    color: Colors.white,
                    child: CircularProgressIndicator(
                      valueColor:
                          AlwaysStoppedAnimation<Color>(Color(0xff008979)),
                    ),
                  ),
                );
              } else if (!snapshot.hasData) {
                //return Page(snapshot.data);
                return Container(
                  child: Center(
                    child: Text("Coorriginar apresentação de pagina."),
                  ),
                );
              } else {
                return Container(
                    child: Center(
                  child: Text("Pagina não encontrada...."),
                ));
              }
            }));
  }
}
*/
