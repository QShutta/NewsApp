import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
// import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Article extends StatefulWidget {
  final imageUrl;
  final title;
  final description;
  final content;
  final author;
  final url;

  final publishedAt;

  Article({
    this.imageUrl,
    this.title,
    this.description,
    this.content,
    this.author,
    required this.url,
    this.publishedAt,
    // required article
  });
  // const Article({super.key});

  @override
  State<Article> createState() => _ArticleState();
}

class _ArticleState extends State<Article> {
  late final WebViewController controller;
  bool isLoading = true;
  @override
  void initState() {
    super.initState();
    // controller = WebViewController();

    controller = WebViewController()
      //The onPageFinished callback is called when the web page is fully loaded.
      //The defauld of the 'isLoading' var is true,and when the page finish loading it will become
      //false,in the body:we meke a condition that if the var is true display a circluer progressindicator,
      //else :display a web page.
      ..setNavigationDelegate(NavigationDelegate(onPageFinished: (finish) {
        setState(() {
          isLoading = false;
        });
      }))
      ..loadRequest(
        // Uri.parse('https://flutter.dev'),
        Uri.parse(widget.url),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        color:
            Color.fromRGBO(255, 255, 255, 1), // set background color to white
        child: isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : WebViewWidget(controller: controller),
      ),
    );
    // return isLoading
    //     ? Center(
    //         child: CircularProgressIndicator(),
    //       )
    //     : WebViewWidget(controller: controller);
  }
}
