import 'package:conass/bloc/bloc_agenda_cit.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:conass/bloc/biblioteca_bloc.dart';
import 'package:conass/bloc/bloc_menu-estados.dart';
import 'package:conass/bloc/bloc_post_destaque.dart';
import 'package:conass/bloc/bloc_post_mais_noticias.dart';
import 'package:conass/bloc/favorito_bloc.dart';
import 'package:conass/bloc/menu_bloc_biblioteca.dart';
import 'package:conass/bloc/menu_home_bloc.dart';
import 'package:conass/bloc/pagina_bloc.dart';
import 'package:conass/bloc/pesquisa_bloc.dart';
import 'package:conass/bloc/post_bloc.dart';
import 'package:conass/bloc/post_camaras_tecnicas_bloc.dart';
import 'package:conass/bloc/post_presidentes_bloc.dart';
import 'package:conass/bloc/post_secretarios_bloc.dart';
import 'package:conass/paginas/new_home.dart';
import 'package:conass/util/connectionStatusSingleton.dart';
import 'package:conass/util/cores.dart';
import 'package:flutter_localizations/flutter_localizations.dart'; // Certifique-se de adicionar esta linha
import 'package:intl/date_symbol_data_local.dart'; // Import para inicializar a formatação de data

void main() {
  WidgetsFlutterBinding.ensureInitialized(); // Adicione esta linha

  ConnectionStatusSingleton connectionStatus =
      ConnectionStatusSingleton.getInstance();
  connectionStatus.initialize();

  // Inicialize a formatação de data
  initializeDateFormatting('pt_BR', null).then((_) {
    runApp(MyApp());
  });
}

LinearGradient getAppGradient() {
  return LinearGradient(
    colors: [Cores.PrimaryVerde, Cores.VerdeEscuro],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MenuHomeBloc()),
        ChangeNotifierProvider(create: (_) => BlocPostDestaque()),
        ChangeNotifierProvider(create: (_) => BlocPostMaisNoticias()),
        ChangeNotifierProvider(create: (_) => PesquisasBloc()),
        ChangeNotifierProvider(create: (_) => MenuBlocBiblioteca()),
        ChangeNotifierProvider(create: (_) => PostsBloc()),
        ChangeNotifierProvider(create: (_) => FavoritoBloc()),
        ChangeNotifierProvider(create: (_) => PaginaBloc()),
        ChangeNotifierProvider(create: (_) => BibliotecaBloc()),
        ChangeNotifierProvider(create: (_) => PostSecretariosBloc()),
        ChangeNotifierProvider(create: (_) => PostPresidentesBloc()),
        ChangeNotifierProvider(create: (_) => PostCamarasTecnicasBloc()),
        ChangeNotifierProvider(create: (_) => BlocMenuEstados()),
        ChangeNotifierProvider(create: (_) => BlocAgendaCit()),
      ],
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
          fontFamily: 'GoogleSans', // Define a fonte padrão como 'Gibson'
          textTheme: ThemeData.light().textTheme.copyWith(
                titleLarge: const TextStyle(
                  fontSize: 20,
                  fontFamily: 'GoogleSans',
                  fontWeight: FontWeight.w500, // Correspondente ao 'Medium'
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
              fontFamily: 'GoogleSans',
              fontWeight: FontWeight.w700, // Correspondente ao 'Bold'
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
        home: NewHome(),
        // Adicione suporte a localizações
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: [
          const Locale('pt', 'BR'), // Adicione suporte ao Português do Brasil
        ],
      ),
    );
  }
}
