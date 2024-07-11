import 'package:conass/modelo/menu.dart';
import 'package:conass/util/barra_menu.dart';
import 'package:conass/util/cores.dart';
import 'package:conass/util/push.dart';
import 'package:conass/util/util.dart';
import 'package:flutter/material.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:conass/bloc/biblioteca_bloc.dart';
import 'package:conass/bloc/menu_bloc.dart';

class MenuBiblioteca extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.getBloc<MenuBloc>();
    final blocB = BlocProvider.getBloc<BibliotecaBloc>();

    return Scaffold(
      appBar: BarraMenu(context),
      body: StreamBuilder(
        stream: bloc.outMenu,
        builder: (context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Color(0xff008979)),
              ),
            );
          }
          if (snapshot.hasData) {
            int cor;
            var corTexto;
            var corIcone;
            List<Menu> menus = snapshot.data as List<Menu>; // Cast explícito

            return ListView.separated(
              itemBuilder: (context, index) {
                Menu menu = menus[index];
                if (menu.id == Util.catBiblioteca) {
                  cor = 0xfff3902b;
                  corTexto = Color(0xFFFFFFFF);
                  corIcone = Color(0xFFFFFFFF);
                } else {
                  cor = 0xffffff;
                  corTexto = Color(0xFF000000);
                  corIcone = Cores.PrimaryLaranja;
                }

                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: InkWell(
                    onTap: () {
                      Util.catBiblioteca = menu.id;
                      blocB.inCategoria.add(menu.id);
                      print(menu.id);
                      pop(context);
                      //push(context, PageBiblioteca());
                    },
                    child: Container(
                      color: Color(cor),
                      height: 50,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: Image.asset(
                              "images/estrelaconass.png",
                              color: corIcone,
                              width: 20,
                            ),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              menu.slug.toUpperCase(),
                              style: TextStyle(color: corTexto),
                              textAlign: TextAlign.left,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) => Divider(
                height: 4,
                color: Cores.PrimaryVerde,
              ),
              itemCount:
                  menus.length, // Acesso condicional ao comprimento da lista
            );
          } else {
            return Center(child: Text("Erro ao Carregar menu"));
          }
        },
      ),
    );
  }
}
