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
