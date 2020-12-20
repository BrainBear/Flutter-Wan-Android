import 'package:flutter/material.dart';
import 'package:flutter_wan_android/data/model/article.dart';

class ArticleItemWidget extends StatelessWidget {
  final Article article;

  const ArticleItemWidget({Key key, this.article}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
      margin: EdgeInsets.fromLTRB(16, 0, 16, 0),
      decoration: BoxDecoration(
          border:
              Border(bottom: Divider.createBorderSide(context, width: 0.7))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildAuthorAndDateWidget(),
          _buildArticleTitle(),
          _buildArticleTag(),
        ],
      ),
    );
  }

  Widget _buildAuthorAndDateWidget() {
    return Row(
      children: [
        Expanded(
            child: Text(article.author, style: TextStyle(color: Colors.grey))),
        Text(article.niceDate, style: TextStyle(color: Colors.grey)),
      ],
    );
  }

  Widget _buildArticleTitle() {
    return Text(
      article.title,
      maxLines: 3,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _buildArticleTag() {
    return Text("${article.superChapterName ?? ""} · ${article.chapterName}",
        style: TextStyle(color: Colors.grey, fontSize: 12));
  }
}
