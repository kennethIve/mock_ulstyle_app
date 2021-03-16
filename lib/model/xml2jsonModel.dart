class Article {
  String id;
  String pos;
  String type;
  String title;
  String link;
  String thumbnail;
  String publishDate;
  List<String> tags = [];

  Article({
    this.title,
    this.thumbnail,
    this.link,
  });

  Article.fromJson(Map<String, dynamic> json) {
    //print(json);
    this.id = json['id'];
    this.pos = json['pos'];
    this.type = json['type'];
    this.title = json['title']["__cdata"];
    this.link = json['link']["_cdata"];
    this.thumbnail = json['thumbnail']['__cdata'];
    this.publishDate = json['publish_date']['__cdata'];
    if (json['tags'] != null) {
      if (json["tags"]["tag"] is List)
        (json['tags']['tag'] as List).forEach((element) {
          this.tags.add(element['__cdata']);
        });
      else
        this.tags.add(json['tags']["tag"]["__cdata"]);
    }
  }
}
