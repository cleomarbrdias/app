import 'dart:async';
import 'package:conass/componente/card_publicacao.dart';
import 'package:conass/util/rodape.dart';
import 'package:provider/provider.dart';
import 'package:conass/bloc/biblioteca_bloc.dart';
import 'package:conass/componente/post_card_new.dart';
import 'package:conass/paginas/page_menu_biblioteca.dart';
import 'package:conass/util/barra_menu.dart';
import 'package:conass/util/connectionStatusSingleton.dart';
import 'package:conass/util/cores.dart';
import 'package:conass/util/menu.dart';
import 'package:conass/util/push.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
    print("Pagina Biblioteca");
    return Scaffold(
      appBar: BarraMenu(context),
      //bottomNavigationBar: Rodape(),
      drawer: MenuList(),
      bottomNavigationBar: Rodape(),
      body: StreamBuilder(
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
            return Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Cores.PrimaryVerde),
              ),
            );
          } else {
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                childAspectRatio:
                    2.5, // Ajuste de acordo com a proporção do card
              ),
              itemCount: (snapshot.data as List).length,
              itemBuilder: (context, index) {
                return CardPublicacao(snapshot.data![
                    index]); // Usando a notação ! para garantir que snapshot.data não seja nulo
              },
            );
          }
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
