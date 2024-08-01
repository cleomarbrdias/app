import 'package:provider/provider.dart';
import 'package:conass/modelo/menu.dart';
import 'package:conass/util/cores.dart';
import 'package:flutter/material.dart';
import 'package:conass/bloc/menu_bloc_biblioteca.dart';
import 'package:conass/bloc/biblioteca_bloc.dart';
import 'package:shimmer/shimmer.dart';

class MenuCategoriaBiblioteca extends StatefulWidget {
  @override
  _MenuCategoriaBibliotecaState createState() =>
      _MenuCategoriaBibliotecaState();
}

class _MenuCategoriaBibliotecaState extends State<MenuCategoriaBiblioteca> {
  String? selectedCategoryId;

  @override
  Widget build(BuildContext context) {
    final menubloc = Provider.of<MenuBlocBiblioteca>(context);
    final bibliotecaBloc = Provider.of<BibliotecaBloc>(context, listen: false);
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
            return _buildShimmerEffect();
          } else {
            final List<Menu> menus = snapshot.data!;
            return ListView.builder(
              shrinkWrap: true,
              itemCount: menus.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                Menu menu = menus[index];
                bool isSelected = menu.id == selectedCategoryId;
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  child: GestureDetector(
                    onTap: () {
                      int categoryId = int.tryParse(menu.id) ?? -1;
                      if (categoryId != -1) {
                        bibliotecaBloc.inCategoria.add(categoryId);
                        setState(() {
                          selectedCategoryId = menu.id;
                        });
                      }
                    },
                    child: Container(
                      child: Chip(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(30),
                          ),
                          side: BorderSide(
                            color: isSelected
                                ? Cores.LaranjaEscuro
                                : Colors.grey.shade400,
                            width: 1,
                          ),
                        ),
                        backgroundColor: isSelected
                            ? Cores.LaranjaEscuro
                            : Colors.grey.shade200,
                        label: Text(
                          menu.slug,
                          style: TextStyle(
                            color: isSelected ? Colors.white : Cores.VerdeClaro,
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

  Widget _buildShimmerEffect() {
    double screenWidth = MediaQuery.of(context).size.width;
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 5, // Número de itens de carregamento falso
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
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
              label: Container(
                width: screenWidth * 0.2,
                height: screenWidth * 0.05,
                color: Colors.grey[300],
              ),
            ),
          );
        },
      ),
    );
  }
}
