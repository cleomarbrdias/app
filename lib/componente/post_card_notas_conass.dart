import 'package:conass/componente/pagina.dart';
import 'package:conass/modelo/post.dart';
import 'package:conass/util/cores.dart';
import 'package:conass/util/push.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:url_launcher/url_launcher.dart';

class PostCardNotasConass extends StatelessWidget {
  final Post p;
  PostCardNotasConass(this.p);

  @override
  Widget build(BuildContext context) {
    var dt = DateTime.parse(p.data ?? DateTime.now().toIso8601String());
    var forData = new DateFormat('dd/MM/yyyy');
    String resData = forData.format(dt);

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
      child: Container(
        padding: EdgeInsets.all(0.0),
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: InkWell(
          onTap: () {
            print("clicou");
            _onClickp(context, p);
            print(p);
          },
          child: Row(
            children: [
              Container(
                width: 100.0,
                height: 70.0,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: FadeInImage.memoryNetwork(
                    fit: BoxFit.cover,
                    width: double.infinity,
                    placeholder: kTransparentImage,
                    image: p.img,
                  ),
                ),
              ),
              SizedBox(
                width: 30.0,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      p.title != null
                          ? (p.title.length > 70
                              ? '${p.title.substring(0, 60)}...'
                              : p.title)
                          : '',
                      style: TextStyle(
                        fontSize: 13.0,
                        fontFamily: 'GoogleSansMedium',
                        color: Cores.AzulVerdeado,
                      ),
                      overflow: TextOverflow.clip,
                    ),
                    Text(
                      'Publicado em | ' + resData ?? '',
                      style: TextStyle(
                        fontSize: 8.0,
                        color: Colors.black54,
                        fontFamily: 'GoogleSansItalic',
                      ),
                      softWrap: true,
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _onClickp(BuildContext context, p) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Pagina(p)),
    );
  }
}
