import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:conass/bloc/biblioteca_bloc.dart';
import 'package:conass/bloc/favorito_bloc.dart';
import 'package:conass/bloc/menu_bloc.dart';
import 'package:conass/bloc/menu_home_bloc.dart';
import 'package:conass/bloc/pagina_bloc.dart';
import 'package:conass/bloc/pesquisa_bloc.dart';
import 'package:conass/bloc/post_bloc.dart';
import 'package:conass/bloc/post_camaras_tecnicas_bloc.dart';
import 'package:conass/bloc/post_presidentes_bloc.dart';
import 'package:conass/bloc/post_secretarios_bloc.dart';
import 'package:conass/paginas/home_page.dart';
import 'package:conass/util/connectionStatusSingleton.dart';
import 'package:conass/util/cores.dart';
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
      blocs: [
        Bloc((i) => PesquisasBloc()),
        Bloc((i) => MenuBloc()),
        Bloc((i) => PostsBloc()),
        Bloc((i) => FavoritoBloc()),
        Bloc((i) => PaginaBloc()),
        Bloc((i) => BibliotecaBloc()),
        Bloc((i) => MenuCategoriaBloc()),
        Bloc((i) => PostSecretariosBloc()),
        Bloc((i) => PostPresidentesBloc()),
        Bloc((i) => PostCamarasTecnicasBloc()),
      ],
      dependencies: [],
      child: MaterialApp(
        debugShowCheckedModeBanner: true,
        title: "CONASS",
        theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch().copyWith(
            primary: Cores.PrimaryVerde, // Utilize sua cor definida
            primaryContainer: Colors.white,
            secondary: Colors.white,
          ),
          scaffoldBackgroundColor: Colors.white,
          fontFamily: 'GoogleSans',
          textTheme: ThemeData.light().textTheme.copyWith(
                titleLarge: const TextStyle(
                  fontSize: 20,
                  fontFamily: 'GoogleSans',
                ),
              ),
          appBarTheme: AppBarTheme(
            backgroundColor: Cores.PrimaryVerde,
            foregroundColor: Colors.white,
            iconTheme: IconThemeData(
              color: Colors.white,
            ),
            titleTextStyle: TextStyle(
              color: Colors.white,
              fontFamily: 'GoogleSansBold',
              fontSize: 20,
            ),
          ),
          bottomNavigationBarTheme: BottomNavigationBarThemeData(
            backgroundColor: Cores.PrimaryVerde,
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.white,
          ),
          drawerTheme: DrawerThemeData(backgroundColor: Cores.VerdeMedio),
        ),

        /*
        ThemeData(
          colorScheme: ColorScheme.fromSwatch().copyWith(
            primary: Color(0xFF008979),
            secondary: Colors.white,
          ),
          scaffoldBackgroundColor: Colors.white,
          fontFamily: 'GoogleSans',
          textTheme: ThemeData.light().textTheme.copyWith(
                titleLarge: const TextStyle(
                  fontSize: 20,
                  fontFamily: 'GoogleSans',
                ),
              ),
          appBarTheme: AppBarTheme(
            backgroundColor: Color(0xFF008979), // Fundo do AppBar
            foregroundColor: Colors.white, // Cor do título e ícones do AppBar
            iconTheme: IconThemeData(
              color: Colors.white, // Cor dos ícones
            ),
            titleTextStyle: TextStyle(
              color: Colors.white, // Cor do título
              fontFamily: 'GoogleSansBold', // Fonte do título
              fontSize: 20,
            ),
          ),
        ),
*/
        /*
        theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch().copyWith(
            primary: Color(0xFF008979),
            secondary: Colors.white,
          ),
          scaffoldBackgroundColor: Colors.white,
          fontFamily: 'GoogleSans',
          textTheme: ThemeData.light().textTheme.copyWith(
                titleLarge: const TextStyle(
                  fontSize: 20,
                  fontFamily: 'GoogleSans',
                ),
              ),
          appBarTheme: AppBarTheme(
            backgroundColor: Color(0xFF008979), // Fundo do AppBar
            foregroundColor: Colors.white, // Cor do título e ícones do AppBar
            iconTheme: IconThemeData(
              color: Colors.white, // Cor dos ícones
            ),
            titleTextStyle: TextStyle(
              color: Colors.white, // Cor do título
              fontFamily: 'GoogleSansBold', // Fonte do título
              fontSize: 20,
            ),
          ),
        ),

        */
        home: HomePage(),
      ),
    );
  }
}
