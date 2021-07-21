import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:mock_back_home/model/xml2jsonModel.dart';
import 'package:xml2json/xml2json.dart';

class UFoodAPi {
  final xmlParser = Xml2Json();
  var dio = Dio();

  String url =
      "http://ulaappelb02-992914890.ap-east-1.elb.amazonaws.com/internal-api/list?signature-code=ufood&code=502";

  Future<List<Article>> getFoodNews({int pageIndex = 0, int limit = 8}) async {
    Response resp = await dio.get(url + "&page-index=$pageIndex&limit=$limit");
    print("To JSON (By GData)");
    xmlParser.parse(resp.data.toString());
    var json = xmlParser.toGData();
    Map<String, dynamic> foodArticles = jsonDecode(json);
    List<Article> articles = [];
    (foodArticles['root']['item'] as List).forEach((element) {
      articles.add(Article.fromJson(element));
    });
    return articles;
  }
}
