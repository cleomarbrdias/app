import 'dart:convert';
import 'package:conass/util/cores.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class Pesquisa extends SearchDelegate<String> {
  @override
  String get searchFieldLabel => "Pesquisar";

  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = "";
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: AnimatedIcon(
            icon: AnimatedIcons.menu_arrow, progress: transitionAnimation),
        onPressed: () {
          close(context, 'null');
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    Future.delayed(Duration.zero).then((_) => close(context, query));

    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty)
      return Center(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Image.asset("images/estrela.png"),
          ),
        ),
      );
    else
      return FutureBuilder<List>(
          future: suggestions(query),
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
            } else if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Cores.PrimaryVerde),
                ),
              );
            } else {
              return ListView.builder(
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(snapshot.data![index]),
                    leading: Icon(Icons.play_arrow),
                    onTap: () {
                      close(context, snapshot.data![index]);
                    },
                  );
                },
                itemCount: snapshot.data!.length,
              );
            }
          });
  }

  Future<List> suggestions(String search) async {
    //sugestoes de pesquisa realizada pelo API da Goggle
    http.Response response = await http.get(
        "http://suggestqueries.google.com/complete/search?q=$search&client=chrome"
            as Uri);

    if (response.statusCode == 200) {
      return json.decode(response.body)[1].map((result) {
        return result;
      }).toList();
    } else {
      throw Exception("Falha ao carregar sugestões de pesquisa");
    }
  }
}
