import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MySearchDele extends SearchDelegate {
  final searchHint = "搜尋內容...";

  var suggestList = ["hello", "world", "hello world", "dont know do what"];

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      TextButton(
          child: Text("取消"),
          onPressed: () {
            Navigator.pop(context);
          })
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    //throw UnimplementedError();
    return Icon(Icons.search_rounded);
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    //throw UnimplementedError();
    return Icon(Icons.search_rounded);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions
    //throw UnimplementedError();
    if (this.query.isEmpty)
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "熱門",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Container(
              child: Wrap(
                spacing: 3.0,
                children: [
                  _hotChip("情人節2021"),
                  _hotChip("新年2021"),
                  _hotChip("盆菜2021"),
                  _hotChip("BNO"),
                  _hotChip("情人節2021"),
                  _hotChip("情人節2021"),
                ],
              ),
            ),
            Card(
              color: Colors.red,
              margin: EdgeInsets.symmetric(vertical: 15),
              child: SizedBox(
                height: 100,
                width: double.infinity,
                child: Text("the banner"),
              ),
            ),
            hotTopics(),
            hotTopics(),
          ],
        ),
      );
    else
      return Icon(Icons.search_rounded);
  }

  Widget _hotChip(String labelText) {
    return new Chip(
      label: Text(labelText),
    );
  }

  Widget hotTopics({no: String, title: String}) {
    return ListTile(
      leading: Icon(Icons.looks_one),
      title: Text(
        "hot 情人節2021情人節2021情人節2021情人節2021",
        overflow: TextOverflow.ellipsis,
      ),
      onTap: () {},
    );
  }
}
