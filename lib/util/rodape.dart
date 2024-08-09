import 'package:conass/bloc/auth_provider.dart';
import 'package:conass/componente/login_screen.dart';
import 'package:conass/delegates/pesquisa.dart';
import 'package:conass/modelo/post.dart';
import 'package:conass/paginas/favoritos_pages.dart';
import 'package:conass/paginas/home_pesquisa.dart';
import 'package:conass/paginas/user_profile_screen.dart';
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

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final favoritoBloc = Provider.of<FavoritoBloc>(context, listen: false);
      favoritoBloc.loadFav();

      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      authProvider.checkUser(); // Verifica se o usuário está logado ao iniciar
    });
  }

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
    } else if (index == 3) {
      _handleUserIconTap(context);
    }
  }

  Future<void> _showSearch(BuildContext context) async {
    String? result = await showSearch(context: context, delegate: Pesquisa());
    if (result != null && result.isNotEmpty) {
      _onClickPesquisa(context, result);
    }
  }

  void _handleUserIconTap(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    if (authProvider.user != null) {
      // Usuário já está logado, exibir a tela de perfil
      push(context, UserProfileScreen());
    } else {
      // Usuário não está logado, exibir a tela de login
      push(context, LoginScreen());
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
                          color: Cores
                              .LaranjaEscuro, // Cor do indicador de favoritos
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
                  }
                  return SizedBox.shrink();
                },
              ),
            ],
          ),
        ),
        BottomNavigationBarItem(
          label: '',
          icon: Icon(Icons.person_outline), // Ícone para o usuário
        ),
      ],
      currentIndex: _selectedIndex,
      onTap: _onItemTapped,
      selectedItemColor: Colors.white, // Cor do item selecionado
      unselectedItemColor: Colors.white, // Cor do item não selecionado
      backgroundColor:
          Cores.PrimaryVerde, // Cor de fundo do BottomNavigationBar
      type: BottomNavigationBarType.fixed, // Mantém todos os itens visíveis
    );
  }

  void _onClickPesquisa(BuildContext context, String result) {
    push(context, HomePesquisa(result));
  }
}
