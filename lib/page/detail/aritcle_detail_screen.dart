import 'dart:io';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ArticleDetailScreen extends StatefulWidget {
  final String url;
  final String title;

  ArticleDetailScreen({Key key, @required this.url, @required this.title})
      : super(key: key);

  @override
  _ArticleDetailScreenState createState() => _ArticleDetailScreenState();
}

class _ArticleDetailScreenState extends State<ArticleDetailScreen> {
  var _loading = true;

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Stack(
          children: [
            WebView(
              onPageFinished: (url) {
                setState(() {
                  _loading = false;
                });
              },
              initialUrl: widget.url,
            ),
            _loading
                ? Center(child: CircularProgressIndicator())
                : SizedBox.shrink()
          ],
        ));
  }
}
