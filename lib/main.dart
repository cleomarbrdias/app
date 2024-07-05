import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:conass/bloc/biblioteca_bloc.dart';
import 'package:conass/bloc/favorito_bloc.dart';
import 'package:conass/bloc/menu_bloc.dart';
import 'package:conass/bloc/menu_home_bloc.dart';
import 'package:conass/bloc/pagina_bloc.dart';
import 'package:conass/bloc/pesquisa_bloc.dart';
import 'package:conass/bloc/post_bloc.dart';
import 'package:conass/paginas/home_page.dart';
import 'package:conass/util/connectionStatusSingleton.dart';
import 'package:flutter/material.dart';

void main() {
  ConnectionStatusSingleton connectionStatus =
      ConnectionStatusSingleton.getInstance();
  connectionStatus.initialize();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return BlocProvider(
      child: MaterialApp(
        debugShowCheckedModeBanner: true,
        title: "CONASS",
        theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch().copyWith(
            primary: Color(0xFF008979),
            secondary: Colors.white,
          ),
          fontFamily: 'GoogleSans',
          textTheme: ThemeData.light().textTheme.copyWith(
                titleLarge: const TextStyle(
                  fontSize: 20,
                  fontFamily: 'GoogleSans',
                ),
              ),
        ),
        home: HomePage(),
      ),
      blocs: [
        Bloc((i) => PesquisasBloc()),
        Bloc((i) => PostsBloc()),
        Bloc((i) => FavoritoBloc()),
        Bloc((i) => PaginaBloc()),
        Bloc((i) => BibliotecaBloc()),
        Bloc((i) => MenuBloc()),
        Bloc((i) => MenuCategoriaBloc()),
      ],
      dependencies: [],
    );
  }
}
