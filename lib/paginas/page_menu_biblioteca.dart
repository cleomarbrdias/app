import 'package:conass/modelo/menu.dart';
import 'package:conass/util/barra_menu.dart';
import 'package:conass/util/cores.dart';
import 'package:conass/util/util.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:conass/bloc/biblioteca_bloc.dart';
import 'package:conass/bloc/menu_bloc_biblioteca.dart';

class MenuBiblioteca extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of<MenuBlocBiblioteca>(context);
    final blocB = Provider.of<BibliotecaBloc>(context);

    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: BarraMenu(context),
      body: StreamBuilder<List<Menu>>(
        stream: bloc.outMenu,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text("Erro ao carregar menu"),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Cores.PrimaryVerde),
              ),
            );
          } else {
            final List<Menu> menus = snapshot.data!;
            return Container(
              width: screenWidth,
              height:
                  screenWidth * 0.15, // Altura proporcional à largura da tela
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: menus.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  Menu menu = menus[index];
                  bool isSelected = Util.catBiblioteca == menu.id;
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    child: GestureDetector(
                      onTap: () {
                        Util.catBiblioteca = menu.id as int;
                        blocB.inCategoria.add(menu.id as int);
                        print("Clicou");
                        Navigator.pop(context);
                        // push(context, PageBiblioteca());
                      },
                      child: Container(
                        child: Chip(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(30),
                            ),
                            side: BorderSide(
                              color: Colors.grey.shade400,
                              width: 1,
                            ),
                          ),
                          backgroundColor: isSelected
                              ? Cores.LaranjaEscuro
                              : Colors.grey.shade200,
                          label: Text(
                            menu.slug,
                            style: TextStyle(
                              color: isSelected
                                  ? Colors.white
                                  : Cores.LaranjaEscuro,
                              fontFamily: 'GoogleSans',
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          }
        },
      ),
    );
  }
}
