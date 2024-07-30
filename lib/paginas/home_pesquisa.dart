import 'dart:async';
import 'package:conass/componente/new_post_card_noticias.dart';
import 'package:conass/modelo/post.dart';
import 'package:provider/provider.dart';
import 'package:conass/bloc/pesquisa_bloc.dart';
import 'package:conass/componente/post_card.dart';
import 'package:conass/util/barra_menu.dart';
import 'package:conass/util/connectionStatusSingleton.dart';
import 'package:conass/util/cores.dart';
import 'package:conass/util/util.dart';
import 'package:flutter/material.dart';

class HomePesquisa extends StatefulWidget {
  final String result;

  HomePesquisa(this.result);

  @override
  _HomePesquisaState createState() => _HomePesquisaState();
}

class _HomePesquisaState extends State<HomePesquisa> {
  late StreamSubscription _connectionChangeStream;
  bool isOffline = false;
  bool _initialSearchDone = false;

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
    });
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of<PesquisasBloc>(context, listen: false);

    if (!_initialSearchDone && widget.result.isNotEmpty) {
      bloc.inPesquisa.add(widget.result);
      _initialSearchDone = true;
    }

    if (isOffline) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              "Parece que você está offline. Verifique sua conexão com a internet e tente novamente.",
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
            backgroundColor: Cores.LaranjaEscuro,
            duration: Duration(seconds: 3),
          ),
        );
      });
    }

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Pesquisar'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Resultados da Pesquisa por: ${widget.result}',
              style: TextStyle(
                fontSize: 14,
                fontFamily: 'GoogleSansMediumItalic',
                fontWeight: FontWeight.w600,
                color: Cores.LaranjaEscuro,
              ),
            ),
          ),
          Expanded(
            child: StreamBuilder<List<Post>>(
              stream: bloc.outPosts,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Container(
                    padding: EdgeInsets.all(24),
                    child: Center(
                      child: Text(
                        snapshot.error.toString(),
                        style: TextStyle(fontSize: 20, color: Colors.grey),
                      ),
                    ),
                  );
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(
                    child: CircularProgressIndicator(
                      valueColor:
                          AlwaysStoppedAnimation<Color>(Color(0xff008979)),
                    ),
                  );
                } else {
                  Util.paginacao = snapshot.data!.length % 10;
                  return ListView.builder(
                    itemBuilder: (context, index) {
                      if (index < snapshot.data!.length) {
                        return NewPostCardNoticias(snapshot.data![index]);
                      } else if (index > 1) {
                        bloc.inPesquisa.add('');
                        return Container(
                          height: 40,
                          width: 40,
                          alignment: Alignment.center,
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                                Cores.LaranjaEscuro),
                          ),
                        );
                      } else {
                        // Não exibir "erro" quando há apenas um item
                        return SizedBox.shrink();
                      }
                    },
                    itemCount: snapshot.data!.length + 1,
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _connectionChangeStream.cancel();
    super.dispose();
  }
}
