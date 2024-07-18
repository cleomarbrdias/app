import 'dart:async';

import 'package:bloc_pattern/bloc_pattern.dart';
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
    final bloc = BlocProvider.getBloc<BibliotecaBloc>();
    print("Pagina Biblioteca");
    return Scaffold(
      appBar: BarraMenu(context),
      bottomNavigationBar: rodape(),
      drawer: MenuList(),
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
                crossAxisCount: 2,
                childAspectRatio: 0.7,
              ),
              itemCount: (snapshot.data as List).length,
              itemBuilder: (context, index) {
                return CardPost(snapshot.data![
                    index]); // Usando a notação ! para garantir que snapshot.data não seja nulo
              },
            );
          }
        },
      ),
    );
  }

  Widget rodape() {
    return Stack(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(width: 0.3, color: Cores.PrimaryLaranja),
            ),
          ),
          width: MediaQuery.of(context).size.width,
          height: 40,
          child: Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ElevatedButton(
                  onPressed: () {
                    push(context, MenuBiblioteca());
                  },
                  child: Text(
                    "+Linhas Editoriais".toUpperCase(),
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Cores.PrimaryVerde,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.horizontal(
                        left: Radius.circular(3.0),
                        right: Radius.circular(3.0),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _connectionChangeStream.cancel();
    super.dispose();
  }
}
