import 'dart:async';
import 'package:conass/componente/card_publicacao.dart';
import 'package:conass/componente/menu_categoria_biblioteca.dart';
import 'package:conass/util/rodape.dart';
import 'package:provider/provider.dart';
import 'package:conass/bloc/biblioteca_bloc.dart';
import 'package:conass/util/barra_menu.dart';
import 'package:conass/util/connectionStatusSingleton.dart';
import 'package:conass/util/cores.dart';
import 'package:conass/util/menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:conass/bloc/menu_bloc_biblioteca.dart';
import 'package:shimmer/shimmer.dart';

class PageBiblioteca extends StatefulWidget {
  PageBiblioteca({Key? key}) : super(key: key);

  @override
  _PageBibliotecaState createState() => _PageBibliotecaState();
}

class _PageBibliotecaState extends State<PageBiblioteca> {
  late StreamSubscription _connectionChangeStream;
  bool isOffline = false;

  @override
  void initState() {
    super.initState();

    ConnectionStatusSingleton connectionStatus =
        ConnectionStatusSingleton.getInstance();
    _connectionChangeStream =
        connectionStatus.connectionChange.listen(connectionChanged);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<MenuBlocBiblioteca>(context, listen: false)
          .initialize(); // Certifique-se de que o método seja chamado
    });
  }

  void connectionChanged(dynamic hasConnection) {
    setState(() {
      isOffline = !hasConnection;
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    });
  }

  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of<BibliotecaBloc>(context);

    return Scaffold(
      appBar: BarraMenu(context),
      drawer: MenuList(),
      bottomNavigationBar: Rodape(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 2, 10, 2),
            child: Text(
              'Biblioteca',
              style: TextStyle(
                color: Cores.LaranjaEscuro,
                fontFamily: 'GoogleSansItalic',
                fontSize: 24,
              ),
            ),
          ),
          Row(
            children: <Widget>[
              MenuCategoriaBiblioteca(),
            ],
          ),
          Expanded(
            child: StreamBuilder(
              stream: bloc.outPosts,
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.hasError) {
                  return Center(
                    child: Container(
                      padding: EdgeInsets.all(24),
                      child: Text(
                        snapshot.error.toString(),
                        style: TextStyle(fontSize: 20, color: Colors.grey),
                      ),
                    ),
                  );
                } else if (!snapshot.hasData ||
                    snapshot.data == null ||
                    (snapshot.data as List).isEmpty) {
                  return _buildShimmerEffect();
                } else {
                  return GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1,
                      childAspectRatio: 2.5,
                    ),
                    itemCount: (snapshot.data as List).length,
                    itemBuilder: (context, index) {
                      return CardPublicacao(snapshot.data![index]);
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildShimmerEffect() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1,
          childAspectRatio: 2.5,
        ),
        itemCount: 5, // Número de itens de carregamento falso
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: double.infinity,
              height: 100.0,
              color: Colors.white,
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _connectionChangeStream.cancel();
    super.dispose();
  }
}
