import 'dart:async';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:conass/bloc/pesquisa_bloc.dart';
import 'package:flutter/material.dart';
/*
// ignore: must_be_immutable
class HomePesquisa extends StatefulWidget {
  String result;

  HomePesquisa(this.result);

  @override
  _HomePesquisaState createState() => _HomePesquisaState();
}

class _HomePesquisaState extends State<HomePesquisa> {
  // ignore: unused_field, cancel_subscriptions
  late StreamSubscription _connectionChangeStream;

  bool isOffline = false;

  @override
  initState() {
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

  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {

    final bloc = BlocProvider.of<PesquisasBloc>(context);

    if (widget.result != null) {
      bloc.inPesquisa.add(widget.result);
    }

    isOffline
        ? _scaffoldKey.currentState?showSnackBar(SnackBar(
            content: Text(
              "Sem Conexão",
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
            backgroundColor: Color(0xff008979),
            duration: Duration(seconds: 3),
          ))
        : SizedBox.shrink();

    return Scaffold(
        key: _scaffoldKey,
        appBar: BarraMenu(context, "Pesquisar"),
        /*    title: Container(
          child: Text("Pesquisar"),
        ),
        elevation: 0,
        backgroundColor: Color(0xff008979),
        actions: <Widget>[
          Align(
            //favoritos
            alignment: Alignment.center,
            child: StreamBuilder<Map<String, Post>>(
                stream: BlocProvider.of<FavoritoBloc>(context).outFav,
                builder: (context, snapshot) {
                  if (snapshot.hasData)
                    return Text("${snapshot.data.length}");
                  else
                    return Container();
                }),
          ),
          IconButton(
              icon: Image.asset(
                "images/estrelaconass.png",
                width: 20,
                height: 20,
              ),
              onPressed: () {
                push(context, Favoritos());
              }),
          IconButton(
              icon: Icon(Icons.search),
              onPressed: () async {
                String result1 =
                    await showSearch(context: context, delegate: Pesquisa());
                if (result1 != null) bloc.inPesquisa.add(result1);
              }),
        ],
      ),*/
        body: StreamBuilder(
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
                    ));
              } else if (!snapshot.hasData || snapshot.data.length == 0) {
                return Center(
                  child: CircularProgressIndicator(
                    valueColor:
                        AlwaysStoppedAnimation<Color>(Color(0xff008979)),
                  ),
                );
              } else if (snapshot.hasData) {
                print("qtd paginação");
                Util.paginacao = snapshot.data.length % 10;
                print(Util.paginacao);
                return ListView.builder(
                  itemBuilder: (context, index) {
                    if (index < snapshot.data.length) {
                      return PostCard(snapshot.data[index]);
                    } else if (index > 1) {
                      bloc.inPesquisa.add(null);
                      return Container(
                        height: 40,
                        width: 40,
                        alignment: Alignment.center,
                        child: CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Color(0xff008979)),
                        ),
                      );
                    } else {
                      return Center(
                        child: Text("erro"),
                      );
                    }
                  },
                  itemCount: snapshot.data.length + 1,
                );
              } else
                return Container(
                  child: Text("Nenhuma categoria carregada..."),
                );
            }));
  }

}

*/
