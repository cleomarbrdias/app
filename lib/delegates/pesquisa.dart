import 'dart:convert';
import 'package:conass/util/cores.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class Pesquisa extends SearchDelegate<String> {
  @override
  String get searchFieldLabel => "Pesquisar";

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = "";
          showSuggestions(
              context); // Mostrar sugestões novamente após limpar o campo
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
          close(context, ""); // Retornar null em vez de uma string vazia
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    if (query.isEmpty) {
      return Center(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Opacity(
              opacity: 1.0, // Defina o nível de opacidade aqui (0.0 a 1.0)
              child: Image.asset("images/estrela.png"),
            ),
          ),
        ),
      );
    } else {
      Future.delayed(Duration.zero).then((_) => close(context, query));
      return Container();
    }
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      return Center(
        child: Container(
          child: Opacity(
            opacity: 0.5, // Defina o nível de opacidade aqui (0.0 a 1.0)
            child: Image.asset("images/estrela.png"),
          ),
        ),
      );
    } else {
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
  }

  Future<List> suggestions(String search) async {
    // Sugestões de pesquisa realizada pela API do Google
    Uri url = Uri.parse(
        "http://suggestqueries.google.com/complete/search?q=$search&client=chrome");

    http.Response response = await http.get(url);

    if (response.statusCode == 200) {
      return json.decode(response.body)[1].map((result) {
        return result;
      }).toList();
    } else {
      throw Exception('Falha ao carregar sugestões de pesquisa');
    }
  }
}
