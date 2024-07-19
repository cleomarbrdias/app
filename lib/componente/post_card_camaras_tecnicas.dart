import 'package:conass/modelo/camaras_tecnicas.dart';
import 'package:conass/paginas/page_camara_tecnica.dart';
import 'package:conass/util/cores.dart';
import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

class PostCardCamarasTecnicas extends StatelessWidget {
  final CamarasTecnicas post;

  PostCardCamarasTecnicas(this.post);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        padding: EdgeInsets.all(0.0),
        decoration: BoxDecoration(
          //color: Color.fromARGB(182, 0, 184, 160),
          borderRadius: BorderRadius.circular(16.0),
          border: Border.all(color: Colors.grey.shade300, width: 1.0),
        ),
        child: InkWell(
          onTap: () {
            _onClickPost(context, post);
            //print(post);
          },
          child: Row(
            children: [
              Container(
                width: 100.0,
                height: 80.0,
                padding: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: Cores.VerdeClaro,
                  borderRadius: BorderRadius.circular(16.0),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: FadeInImage.memoryNetwork(
                    fit: BoxFit.contain,
                    width: double.infinity,
                    height: double.infinity,
                    placeholder: kTransparentImage,
                    image: post.imageDestaque,
                  ),
                ),
              ),
              SizedBox(width: 15.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      post.title ?? '',
                      style: TextStyle(
                        fontSize: 13.0,
                        fontWeight: FontWeight.bold,
                        color: Cores.VerdeEscuro,
                      ),
                      softWrap: true,
                    ),
                    SizedBox(height: 5.0),
                    Text(
                      'Responsável Técnico: Fulano de Tall',
                      style: TextStyle(
                        fontSize: 10.0,
                        fontWeight: FontWeight.normal,
                        color: Colors.black54,
                      ),
                      softWrap: true,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onClickPost(BuildContext context, CamarasTecnicas post) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => PageCamaraTecnica(post)),
    );
  }
}
