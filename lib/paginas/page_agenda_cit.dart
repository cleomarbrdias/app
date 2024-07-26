import 'dart:async';
import 'package:conass/bloc/bloc_agenda_cit.dart';
import 'package:conass/modelo/post_agenda_cit.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:conass/util/barra_menu.dart';
import 'package:conass/util/connectionStatusSingleton.dart';
import 'package:conass/util/cores.dart';
import 'package:conass/util/menu.dart';
import 'package:conass/util/rodape.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PageAgendaCit extends StatefulWidget {
  PageAgendaCit({Key? key}) : super(key: key);
  @override
  _PageAgendaCitState createState() => _PageAgendaCitState();
}

class _PageAgendaCitState extends State<PageAgendaCit> {
  // ignore: unused_field, cancel_subscriptions
  StreamSubscription? _connectionChangeStream;

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
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    });
  }

  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    final bloc = Provider.of<BlocAgendaCit>(context);
    print("Agenda CIT");
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
      appBar: BarraMenu(context),
      drawer: MenuList(),
      bottomNavigationBar: Rodape(),
      body: StreamBuilder<List<PostAgendaCit>>(
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
                valueColor: AlwaysStoppedAnimation<Color>(Cores.LaranjaEscuro),
              ),
            );
          } else {
            return ListView(
              padding: EdgeInsets.all(10.0),
              children: [
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text(
                    'Agenda CIT',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'GoogleSansMediumItalic',
                      fontWeight: FontWeight.w600,
                      color: Cores.LaranjaEscuro,
                    ),
                  ),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    headingRowColor: MaterialStateColor.resolveWith((states) =>
                        Cores.VerdeEscuro), // Fundo verde escuro no cabeçalho
                    headingTextStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 12), // Texto branco no cabeçalho
                    columns: const <DataColumn>[
                      DataColumn(
                        label: Flexible(
                          flex: 2,
                          child: Text('Mês',
                              style: TextStyle(
                                fontFamily: 'GoogleSansMedium',
                                fontSize: 12,
                              )),
                        ),
                      ),
                      DataColumn(
                        label: Flexible(
                          flex: 1,
                          child: Text('Assembleia',
                              style: TextStyle(
                                fontFamily: 'GoogleSansMedium',
                                fontSize: 12,
                              )),
                        ),
                      ),
                      DataColumn(
                        label: Flexible(
                          flex: 2,
                          child: Text('CIT',
                              style: TextStyle(
                                fontFamily: 'GoogleSansMedium',
                                fontSize: 12,
                              )),
                        ),
                      ),
                      DataColumn(
                        label: Flexible(
                          flex: 3,
                          child: Text('CNS',
                              style: TextStyle(
                                fontFamily: 'GoogleSansMedium',
                                fontSize: 12,
                              )),
                        ),
                      ),
                    ],
                    rows: List<DataRow>.generate(
                      snapshot.data!.length,
                      (index) {
                        final post = snapshot.data![index];
                        return DataRow(
                          color: MaterialStateColor.resolveWith(
                            (states) => index % 2 == 0
                                ? Colors.grey[200]!
                                : Colors.white,
                          ), // Alterna as cores das linhas
                          cells: <DataCell>[
                            DataCell(Text(post.title,
                                style: TextStyle(fontSize: 12))),
                            DataCell(Text(post.dataAssembleia,
                                style: TextStyle(fontSize: 12))),
                            DataCell(Text(post.dataCit,
                                style: TextStyle(fontSize: 12))),
                            DataCell(Text(post.dataCns,
                                style: TextStyle(fontSize: 12))),
                          ],
                        );
                      },
                    ),
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    _connectionChangeStream?.cancel();
    super.dispose();
  }
}
