import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:flutter_html/flutter_html.dart';

// ignore: must_be_immutable
class ViewPage extends StatelessWidget {
  String linkurl;
  ViewPage(this.linkurl);

  @override
  Widget build(BuildContext context) {
    return WebviewScaffold(
      appBar: AppBar(
        title: Text(linkurl),
      ),
      url: linkurl,
      withZoom: true,
    );
  }
}
