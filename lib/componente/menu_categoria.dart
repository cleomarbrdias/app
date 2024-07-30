import 'package:provider/provider.dart';
import 'package:conass/bloc/menu_home_bloc.dart';
import 'package:conass/bloc/post_bloc.dart';
import 'package:conass/modelo/menu.dart';
import 'package:conass/paginas/home_page.dart';
import 'package:conass/util/cores.dart';
import 'package:conass/util/util.dart';
import 'package:flutter/material.dart';

class MenuCategoria extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final menubloc = Provider.of<MenuHomeBloc>(context);
    final bloc = Provider.of<PostsBloc>(context, listen: false);
    double screenWidth = MediaQuery.of(context).size.width;

    return Container(
      width: screenWidth,
      height: screenWidth * 0.15, // Altura proporcional à largura da tela
      child: StreamBuilder<List<Menu>>(
        stream: menubloc.outMenu,
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
            return ListView.builder(
              shrinkWrap: true,
              itemCount: menus.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                Menu menu = menus[index];
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  child: InkWell(
                    onTap: () {
                      try {
                        // Certifique-se de que o ID da categoria seja um número válido
                        int categoryId = int.parse(menu.id);
                        Util.cat = categoryId;
                        bloc.inCategoria.add(Util.cat);

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HomePage(),
                          ),
                        );
                      } catch (e) {
                        print("Erro ao processar o ID da categoria: $e");
                      }
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
                        backgroundColor: Colors.grey.shade200,
                        label: Text(
                          menu.slug,
                          style: TextStyle(
                            color: Cores.VerdeClaro,
                            fontFamily: 'GoogleSans',
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
