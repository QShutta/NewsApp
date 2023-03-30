// import 'dart:convert';
import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;

class Article extends StatefulWidget {
  final imageUrl;
  final title;
  final description;
  final content;
  final author;
  final url;

  final publishedAt;

  Article(
      {required this.imageUrl,
      required this.title,
      this.description,
      this.content,
      this.author,
      this.url,
      this.publishedAt});
  // const Article({super.key});

  @override
  State<Article> createState() => _ArticleState();
}

class _ArticleState extends State<Article> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
      children: [
        Container(
          width: double.infinity,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Column(
                children: [
                  Container(
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "News",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      widget.title,
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[700]),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.network(
                      widget.imageUrl,
                      // height: 300,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      child: Text(
                        widget.url,
                        style: TextStyle(
                          height: 2,
                          fontSize: 20,
                          // fontWeight: FontWeight.bold,
                          // color: Colors.grey[700]
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ],
    ));
  }
}
