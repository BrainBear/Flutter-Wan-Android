// To parse this JSON data, do
//
//     final articlePage = articlePageFromJson(jsonString);

import 'dart:convert';

import 'package:flutter_wan_android/data/model/article.dart';

ArticlePage articlePageFromJson(String str) => ArticlePage.fromJson(json.decode(str));

String articlePageToJson(ArticlePage data) => json.encode(data.toJson());

class ArticlePage {
  ArticlePage({
    this.curPage,
    this.datas,
    this.offset,
    this.over,
    this.pageCount,
    this.size,
    this.total,
  });

  int curPage;
  List<Article> datas;
  int offset;
  bool over;
  int pageCount;
  int size;
  int total;

  factory ArticlePage.fromJson(Map<String, dynamic> json) => ArticlePage(
    curPage: json["curPage"],
    datas: List<Article>.from(json["datas"].map((x) => Article.fromJson(x))),
    offset: json["offset"],
    over: json["over"],
    pageCount: json["pageCount"],
    size: json["size"],
    total: json["total"],
  );

  Map<String, dynamic> toJson() => {
    "curPage": curPage,
    "datas": List<dynamic>.from(datas.map((x) => x.toJson())),
    "offset": offset,
    "over": over,
    "pageCount": pageCount,
    "size": size,
    "total": total,
  };
}
