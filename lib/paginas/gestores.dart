import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';
/*
class PostGestores extends StatefulWidget {
  _PostGestores createState() => _PostGestores();

}

class _PostGestores extends State<PostGestores>
    with SingleTickerProviderStateMixin<PostGestores> {
  _PostGestores();

  Widget build(BuildContext context) {
    return Scaffold(

      appBar: BarraMenu(context, "Gestores Estaduais"),
      drawer: MenuList(),
      body: _body(),
    );
  }

  _body() {
    Future future = PostServiceGestores.getPosts();

    return Container(
      child: FutureBuilder<List<Post>>(
          future: future,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text(
                  "Nenhum post encontrado",
                  style: TextStyle(fontSize: 26, color: Colors.grey),
                ),
              );
            } else if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(
                  valueColor:
                  AlwaysStoppedAnimation<Color>(Color(0xff008979)),
                ),
              );
            } else {
           return _listView(snapshot.data);
            }
          }),
    );
  }

  _listView(List<Post> posts) {
    return GridView.builder(
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
        itemCount: posts.length,
        itemBuilder: (ctx, idx) {
          final p = posts[idx];

          return Container(
            //height: 50,
            child: InkWell(
              onTap: () {
                _onClickPost(ctx, p);
              },
              child: Padding(
                padding: const EdgeInsets.all(6.0),
                child: Stack(
                  fit: StackFit.expand,
                  children: <Widget>[
                    new FadeInImage.memoryNetwork(
                        placeholder: kTransparentImage,
                        // ignore: unrelated_type_equality_checks
                        image: p.img == 0
                            ? 'assets/images/placeholder.gif'
                            : p.img),
                    // Image.network(
                    //    p.img
                    //),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        width: double.infinity,
                        color: Colors.black45,
                        child: Text(
                          p.title,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  void _onClickPost(BuildContext context, Post p) {
    push(context, Pagina(p));
  }
}
*/