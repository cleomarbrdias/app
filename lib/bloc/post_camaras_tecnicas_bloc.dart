import 'dart:async';
import 'dart:ui';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:conass/modelo/camaras_tecnicas.dart';
import 'package:conass/servicos/api_camaras_tecnicas.dart';
import 'package:conass/util/util.dart';
import 'package:rxdart/rxdart.dart';

class PostCamarasTecnicasBloc implements BlocBase {
  ApiCamarasTecnicas? postServices;

  //acionando a lista para armazenamento dos dados
  List<CamarasTecnicas> posts = [];

  //criando controles de saida de saida final _categoriaController = BehaviorSubject<int>(seedValue: 6);
  final BehaviorSubject<List<CamarasTecnicas>> _postsController =
      BehaviorSubject<List<CamarasTecnicas>>();
  //StreamController<List<Post>>();
  Stream get outPosts => _postsController.stream;

  //criando controles de entrada
  final BehaviorSubject<String?> _categoriaController =
      BehaviorSubject<String?>.seeded('camaras-tecnicas');
  StreamSink<String?> get inCategoria => _categoriaController.sink;

  PostCamarasTecnicasBloc() {
    postServices = ApiCamarasTecnicas();
    _categoriaController.stream.listen(_categoria);
    print(_categoriaController);
  }

  void _categoria(String? categoria) async {
    if (categoria != null) {
      print("Entrou na cetoria diferente de null");
      _postsController.sink.add([]);
      posts = await postServices!.getPostsCamarasTecnicas(categoria);

      if (posts == null) {
        _postsController.sink.addError(Util.erro);
      } else {
        _postsController.sink.add(posts);
      }
    } else {
      print("entrou no next pag");
      //final NewPosts = await getPostsCamarasTecnicas!.nextPage();
      //posts += NewPosts;

      //posts!.addAll(await getPostsCamarasTecnicas!.nextPage());

      if (posts == null) {
        _postsController.sink.addError(Util.erro);
      } else {
        _postsController.sink.add(posts);
      }
    }
    _postsController.sink.add(posts);
  }

  @override
  void dispose() {
    _postsController.close();
    _categoriaController.close();
  }

  @override
  // TODO: implement hasListeners
  bool get hasListeners => throw UnimplementedError();

  @override
  void notifyListeners() {
    // TODO: implement notifyListeners
  }

  @override
  void addListener(VoidCallback listener) {
    // TODO: implement addListener
  }

  @override
  void removeListener(VoidCallback listener) {
    // TODO: implement removeListener
  }
}
