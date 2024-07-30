import 'package:conass/delegates/pesquisa.dart';
import 'package:conass/modelo/post.dart';
import 'package:conass/paginas/favoritos_pages.dart';
import 'package:conass/paginas/home_pesquisa.dart';
import 'package:conass/util/cores.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:conass/bloc/favorito_bloc.dart';
import 'package:conass/paginas/new_home.dart';
import 'package:conass/util/push.dart';

class Rodape extends StatefulWidget {
  @override
  _RodapeState createState() => _RodapeState();
}

class _RodapeState extends State<Rodape> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    if (index == 0) {
      pushReplacement(context, NewHome());
    } else if (index == 1) {
      _showSearch(context);
    } else if (index == 2) {
      push(context, Favoritos());
    }
  }

  Future<void> _showSearch(BuildContext context) async {
    String? result = await showSearch(context: context, delegate: Pesquisa());
    if (result != null && result.isNotEmpty) {
      _onClickPesquisa(context, result);
    }
  }

  @override
  Widget build(BuildContext context) {
    final favoritoBloc = Provider.of<FavoritoBloc>(context);

    return BottomNavigationBar(
      items: [
        BottomNavigationBarItem(
          label: '',
          icon: Icon(Icons.home_outlined),
        ),
        BottomNavigationBarItem(
          label: '',
          icon: Icon(Icons.search),
        ),
        BottomNavigationBarItem(
          label: '',
          icon: Stack(
            children: [
              Icon(Icons.bookmark_outline_outlined),
              StreamBuilder<Map<String, Post>>(
                stream: favoritoBloc.outFav,
                builder: (context, snapshot) {
                  if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                    return Positioned(
                      right: 0,
                      child: Container(
                        padding: EdgeInsets.all(1),
                        decoration: BoxDecoration(
                          color: Cores.LaranjaEscuro,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        constraints: BoxConstraints(
                          minWidth: 14,
                          minHeight: 14,
                        ),
                        child: Text(
                          '${snapshot.data!.length}',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 8,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    );
                  } else {
                    return SizedBox.shrink();
                  }
                },
              ),
            ],
          ),
        ),
      ],
      currentIndex: _selectedIndex,
      onTap: _onItemTapped,
    );
  }

  void _onClickPesquisa(BuildContext context, String result) {
    push(context, HomePesquisa(result));
  }
}
