import 'package:conass/bloc/auth_provider.dart';
import 'package:conass/bloc/biblioteca_bloc.dart';
import 'package:conass/componente/pagina.dart';
import 'package:conass/modelo/camaras_tecnicas.dart';
import 'package:conass/modelo/post.dart';
import 'package:conass/paginas/user_profile_screen.dart';
import 'package:conass/util/barra_menu.dart';
import 'package:conass/util/cores.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:conass/componente/login_screen.dart';
import 'package:transparent_image/transparent_image.dart';

class PageCamaraTecnica extends StatefulWidget {
  final CamarasTecnicas post;

  const PageCamaraTecnica(this.post);

  @override
  _PageCamaraTecnicaState createState() => _PageCamaraTecnicaState();
}

class _PageCamaraTecnicaState extends State<PageCamaraTecnica> {
  double fsize = 16.0;
  double fConteudo = 12.0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      int categoriaId = int.parse(widget.post.categoriaBiblioteca);
      final bibliotecaBloc =
          Provider.of<BibliotecaBloc>(context, listen: false);
      bibliotecaBloc.inCategoria.add(categoriaId);

      // Verifique o usuário autenticado ao iniciar
      Provider.of<AuthProvider>(context, listen: false).checkUser();
    });
  }

  @override
  Widget build(BuildContext context) {
    final bibliotecaBloc = Provider.of<BibliotecaBloc>(context);
    final authProvider = Provider.of<AuthProvider>(context);

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: BarraMenu(context),
        body: Column(
          children: [
            Container(
              padding: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.0),
              ),
              child: Row(
                children: <Widget>[
                  Container(
                    width: 100.0,
                    height: 100.0,
                    padding: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: FadeInImage.memoryNetwork(
                        fit: BoxFit.cover,
                        width: 100,
                        height: 100,
                        placeholder: kTransparentImage,
                        image: widget.post.imageDestaque,
                      ),
                    ),
                  ),
                  SizedBox(width: 15.0),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border(
                          left: BorderSide(
                            color: Cores.VerdeMedio,
                            width: 3.0,
                          ),
                        ),
                      ),
                      padding: EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.post.title,
                            style: TextStyle(
                              fontSize: 14.0,
                              fontFamily: 'GoogleSansMedium',
                              color: Cores.VerdeMedio,
                            ),
                            softWrap: true,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            TabBar(
              dividerColor: Cores.AzulEscuro,
              unselectedLabelColor: Cores.AzulEscuro,
              indicatorColor: Cores.LaranjaEscuro,
              labelColor: Cores.LaranjaEscuro,
              tabs: [
                Tab(text: 'Apresentação'),
                Tab(text: 'Publicações'),
                Tab(text: 'Área Restrita'),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: SingleChildScrollView(
                      child: HtmlWidget(
                        '''
                          <div style="text-align: left;">
                            ${widget.post.apresentacao}
                          </div>
                          ''',
                        textStyle: TextStyle(
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w400,
                          color: Cores.FonteConteudo,
                          fontSize: fConteudo,
                        ),
                      ),
                    ),
                  ),
                  StreamBuilder<List<Post>>(
                    stream: bibliotecaBloc.outPosts,
                    builder: (context, AsyncSnapshot<List<Post>> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                              Cores.VerdeEscuro,
                            ),
                          ),
                        );
                      } else if (snapshot.hasError) {
                        return Center(
                          child: Text("Erro ao carregar publicações"),
                        );
                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return Center(
                          child: Text("Nenhuma publicação encontrada"),
                        );
                      } else {
                        return GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            mainAxisSpacing: 8.0,
                            crossAxisSpacing: 8.0,
                            childAspectRatio: 0.75,
                          ),
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: PostCardPublicacao(
                                post: snapshot.data![index],
                              ),
                            );
                          },
                        );
                      }
                    },
                  ),
                  authProvider.user == null
                      ? LoginScreen()
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Bem-vindo, ${authProvider.user!.firstName}!'),
                            SizedBox(height: 20),
                            Text('Grupos:'),
                            authProvider.user!.groups.isNotEmpty
                                ? Column(
                                    children: authProvider.user!.groups
                                        .map((group) => Text(group))
                                        .toList(),
                                  )
                                : Text('Nenhum grupo encontrado'),
                            SizedBox(height: 20),
                            ElevatedButton(
                              onPressed: () {
                                authProvider.logout();
                              },
                              child: Text('Logout'),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => UserProfileScreen(),
                                  ),
                                );
                              },
                              child: Text('Ver Dados do Usuário'),
                            ),
                          ],
                        ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PostCardPublicacao extends StatelessWidget {
  final Post post;

  const PostCardPublicacao({required this.post});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        _onClickPost(context, post);
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10.0),
          child: Stack(
            children: [
              FadeInImage.memoryNetwork(
                placeholder: kTransparentImage,
                image: post.img ?? 'images/placeholder.gif',
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  decoration: BoxDecoration(
                    color: Cores.VerdeEscuro.withOpacity(0.8),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Text(
                          post.title ?? '',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                          ),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void _onClickPost(BuildContext context, Post post) {
  Navigator.push(
    context,
    PageTransition(
      type: PageTransitionType.rightToLeft,
      child: Pagina(post),
      duration: Duration(milliseconds: 500),
    ),
  );
}


// import 'package:conass/componente/pagina.dart';
// import 'package:conass/modelo/camaras_tecnicas.dart';
// import 'package:conass/util/barra_menu.dart';
// import 'package:conass/util/cores.dart';
// import 'package:flutter/material.dart';
// import 'package:page_transition/page_transition.dart';
// import 'package:transparent_image/transparent_image.dart';
// import 'package:provider/provider.dart';
// import 'package:conass/bloc/biblioteca_bloc.dart';
// import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
// import 'package:conass/modelo/post.dart';

// class PageCamaraTecnica extends StatefulWidget {
//   final CamarasTecnicas post;

//   const PageCamaraTecnica(this.post);

//   @override
//   _PageCamaraTecnicaState createState() => _PageCamaraTecnicaState();
// }

// class _PageCamaraTecnicaState extends State<PageCamaraTecnica> {
//   double fsize = 16.0;
//   double fConteudo = 12.0;
//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       int categoriaId = int.parse(widget.post.categoriaBiblioteca);
//       print("ID CategoriaBiblioteca");
//       print(categoriaId);
//       final bibliotecaBloc =
//           Provider.of<BibliotecaBloc>(context, listen: false);
//       bibliotecaBloc.inCategoria.add(categoriaId); // Load new posts
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final bibliotecaBloc = Provider.of<BibliotecaBloc>(context);

//     return DefaultTabController(
//       length: 2, // Número de abas
//       child: Scaffold(
//         appBar: BarraMenu(context),
//         body: Column(
//           children: [
//             // Parte superior da página (manter a primeira Row)
//             Container(
//               padding: EdgeInsets.all(10.0),
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(16.0),
//               ),
//               child: Row(
//                 children: <Widget>[
//                   Container(
//                     width: 100.0,
//                     height: 100.0,
//                     padding: EdgeInsets.all(10.0),
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(16.0),
//                     ),
//                     child: ClipRRect(
//                       borderRadius: BorderRadius.circular(8.0),
//                       child: FadeInImage.memoryNetwork(
//                         fit: BoxFit.cover,
//                         width: 100,
//                         height: 100,
//                         placeholder: kTransparentImage,
//                         image: widget.post.imageDestaque,
//                       ),
//                     ),
//                   ),
//                   SizedBox(width: 15.0),
//                   Expanded(
//                     child: Container(
//                       decoration: BoxDecoration(
//                         border: Border(
//                             left: BorderSide(
//                           color: Cores.VerdeMedio,
//                           width: 3.0,
//                         )),
//                       ),
//                       padding: EdgeInsets.all(10.0),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             widget.post.title,
//                             style: TextStyle(
//                               fontSize: 14.0,
//                               fontFamily: 'GoogleSansMedium',
//                               color: Cores.VerdeMedio,
//                             ),
//                             softWrap: true,
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             // Abas
//             TabBar(
//               dividerColor: Cores.AzulEscuro,
//               unselectedLabelColor: Cores.AzulEscuro,
//               indicatorColor: Cores.LaranjaEscuro,
//               labelColor: Cores.LaranjaEscuro,
//               tabs: [
//                 Tab(text: 'Apresentação'),
//                 Tab(text: 'Publicações'),
//               ],
//             ),
//             Expanded(
//               child: TabBarView(
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.all(10.0),
//                     child: SingleChildScrollView(
//                       child: HtmlWidget(
//                         '''
//           <div style="text-align: left;">
//             ${widget.post.apresentacao}
//           </div>
//           ''',
//                         customStylesBuilder: (element) {
//                           if (element.localName == 'figcaption') {
//                             return {'font-size': '8px'};
//                           } else if (element.className
//                               .contains('fundo_verde')) {
//                             return {
//                               'background-color': '#008979',
//                               'color': 'white'
//                             };
//                           }
//                           return null;
//                         },
//                         textStyle: TextStyle(
//                           fontStyle: FontStyle.normal,
//                           fontWeight: FontWeight.w400,
//                           color: Cores.FonteConteudo,
//                           fontSize: fConteudo,
//                         ),
//                       ),
//                     ),
//                   ),
//                   StreamBuilder<List<Post>>(
//                     stream: bibliotecaBloc.outPosts,
//                     builder: (context, AsyncSnapshot<List<Post>> snapshot) {
//                       print('Snapshot state: ${snapshot.connectionState}');
//                       print('Snapshot data: ${snapshot.data}');

//                       if (snapshot.connectionState == ConnectionState.waiting) {
//                         return Center(
//                           child: CircularProgressIndicator(
//                             valueColor: AlwaysStoppedAnimation<Color>(
//                                 Cores.VerdeEscuro),
//                           ),
//                         );
//                       } else if (snapshot.hasError) {
//                         return Center(
//                           child: Text("Erro ao carregar publicações"),
//                         );
//                       } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//                         return Center(
//                           child: Text("Nenhuma publicação encontrada"),
//                         );
//                       } else {
//                         return Expanded(
//                           child: GridView.builder(
//                             gridDelegate:
//                                 SliverGridDelegateWithFixedCrossAxisCount(
//                               crossAxisCount: 3,
//                               mainAxisSpacing: 8.0,
//                               crossAxisSpacing: 8.0,
//                               childAspectRatio:
//                                   0.75, // Ajuste a proporção conforme necessário
//                             ),
//                             itemCount: snapshot.data!.length,
//                             itemBuilder: (context, index) {
//                               return Padding(
//                                 padding: const EdgeInsets.all(8.0),
//                                 child: PostCardPublicacao(
//                                   post: snapshot.data![index],
//                                 ),
//                               );
//                             },
//                           ),
//                         );
//                       }
//                     },
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class PostCardPublicacao extends StatelessWidget {
//   final Post post;

//   const PostCardPublicacao({required this.post});

//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: () {
//         _onClickPost(context, post);
//       },
//       child: Container(
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(10.0),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.grey.withOpacity(0.3),
//               spreadRadius: 2,
//               blurRadius: 5,
//               offset: Offset(0, 3), // changes position of shadow
//             ),
//           ],
//         ),
//         child: ClipRRect(
//           borderRadius: BorderRadius.circular(10.0),
//           child: Stack(
//             children: [
//               FadeInImage.memoryNetwork(
//                 placeholder: kTransparentImage,
//                 image: post.img ?? 'images/placeholder.gif',
//                 fit: BoxFit.cover,
//                 width: double.infinity,
//                 height: double.infinity,
//               ),
//               Positioned(
//                 bottom: 0,
//                 left: 0,
//                 right: 0,
//                 child: Container(
//                   decoration: BoxDecoration(
//                     color: Cores.VerdeEscuro.withOpacity(0.8),
//                   ),
//                   padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Flexible(
//                         child: Text(
//                           post.title ?? '',
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontSize: 10,
//                           ),
//                           maxLines: 3,
//                           overflow: TextOverflow.ellipsis,
//                         ),
//                       ),
//                       // Icon(
//                       //   Icons.bookmark_border,
//                       //   color: Colors.white,
//                       // ),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// void _onClickPost(BuildContext context, Post post) {
//   Navigator.push(
//     context,
//     PageTransition(
//       type: PageTransitionType.rightToLeft,
//       child: Pagina(post),
//       duration: Duration(milliseconds: 500),
//     ),
//   );
// }
