import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:recipe_app/articleUpdate.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:cached_network_image/cached_network_image.dart';

class Test2 extends StatefulWidget {
  const Test2({super.key});

  @override
  State<Test2> createState() => _Test2State();
}

dynamic _news;
dynamic _newsSport;
dynamic _newsTech;

class _Test2State extends State<Test2> {
  @override
  void initState() {
    // final connectivityResult = await (Connectivity().checkConnectivity());

    super.initState();
    _news = featch();
    _newsSport = featchSport();
    _newsTech = featchTech();
  }

  // Future<List<Map<dynamic, dynamic>>>
  featch() async {
    // I am connected to a mobile network.
    var apiKey = "0b09183ac44f4acf9372b62427c7f55a";
    final apiUrl =
        'https://newsapi.org/v2/top-headlines?country=in&category=health&apiKey=$apiKey';

    var res = await http.get(Uri.parse(apiUrl));
    if (res.statusCode == 200) {
      var parsed = jsonDecode(res.body);
      return parsed['articles'];
    } else {
      throw Exception("Faild to load the data from the internet");
    }
  }

  featchSport() async {
    var apiKey = "0b09183ac44f4acf9372b62427c7f55a";
    final apiUrl =
        'https://newsapi.org/v2/top-headlines?country=in&category=sports&apiKey=$apiKey';

    var res = await http.get(Uri.parse(apiUrl));
    if (res.statusCode == 200) {
      var parsed = jsonDecode(res.body);
      return parsed['articles'];
    } else {
      throw Exception("Faild to load the data from the internet");
    }
  }

  featchTech() async {
    var apiKey = "0b09183ac44f4acf9372b62427c7f55a";
    final apiUrl =
        'https://newsapi.org/v2/top-headlines?country=in&category=business&apiKey=$apiKey';

    var res = await http.get(Uri.parse(apiUrl));
    if (res.statusCode == 200) {
      var parsed = jsonDecode(res.body);
      return parsed['articles'];
    } else {
      throw Exception("Faild to load the data from the internet");
    }
  }

  List pages = [Page1(), Page2(), Page3()];
  int selectedTap = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: pages.elementAt(selectedTap),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: selectedTap,
          onTap: (value) {
            setState(() {
              selectedTap = value;
            });
          },
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.topic), label: "Health"),
            BottomNavigationBarItem(
                icon: Icon(Icons.sports_football), label: "Sport"),
            BottomNavigationBarItem(
                icon: Icon(Icons.sports_esports), label: "Business")
          ],
        ),
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Flutter ",
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold)),
              Text(
                "News",
                style:
                    TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ));
  }
}

class Page1 extends StatefulWidget {
  const Page1({super.key});

  @override
  State<Page1> createState() => _Page1State();
}

class _Page1State extends State<Page1> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
      future: _news,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, i) {
                //In this code:what did the snapshot.data[i] should containe?
                //the article variable will contain a single article object from the list of articles returned from the API,
                //depending on the current index i of the ListView.builder.
                final article = snapshot.data[i];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Article(
                                    imageUrl: article['urlToImage'] ?? '',
                                    title: article['title'],
                                    description: article['description'] ?? '',
                                    content: article['content'],
                                    author: article['author'],
                                    publishedAt: article['publishedAt'],
                                    url: article['url'],
                                  )));
                    },
                    child: Card(
                      child: Column(
                        children: [
                          article['urlToImage'] == null ||
                                  article['urlToImage'] == ''
                              ? SizedBox(
                                  width: double.infinity,
                                  height: 200,
                                  child: Icon(Icons.image))
                              : CachedNetworkImage(
                                  placeholder: (context, url) => SizedBox(
                                    width: double.infinity,
                                    height: 200,
                                    child: Center(
                                        child: CircularProgressIndicator()),
                                  ),
                                  errorWidget: (context, url, error) =>
                                      Icon(Icons.error),
                                  fit: BoxFit.cover,
                                  imageUrl: article['urlToImage'],
                                ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              article['title'],
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(article['description'] ?? ''),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              });
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    ));
  }
}

class Page2 extends StatefulWidget {
  const Page2({super.key});

  @override
  State<Page2> createState() => _Page2State();
}

class _Page2State extends State<Page2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: _newsSport,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            try {
              return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, i) {
                    final articles = snapshot.data[i];
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Article(
                                          imageUrl:
                                              articles['urlToImage'] ?? '',
                                          title: articles['title'],
                                          description:
                                              articles['description'] ?? '',
                                          content: articles['content'],
                                          author: articles['author'],
                                          publishedAt: articles['publishedAt'],
                                          url: articles['url'],
                                        )));
                          },
                          child: Column(
                            children: [
                              articles['urlToImage'] == null ||
                                      articles['urlToImage'] == ''
                                  ? Container(
                                      width: double.infinity,
                                      height: 200,
                                      child: Icon(Icons.image))
                                  : Container(
                                      width: double.infinity,
                                      height: 200,
                                      child: CachedNetworkImage(
                                        fit: BoxFit.cover,
                                        imageUrl: articles['urlToImage'],
                                        placeholder: (context, url) => SizedBox(
                                          child: Center(
                                              child:
                                                  CircularProgressIndicator()),
                                        ),
                                        errorWidget: (context, url, error) =>
                                            Icon(Icons.error),
                                      )),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  articles['title'],
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(articles['description'] ?? ''),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  });
            } catch (e) {
              print(e);
            }
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

class Page3 extends StatefulWidget {
  const Page3({super.key});

  @override
  State<Page3> createState() => _Page3State();
}

class _Page3State extends State<Page3> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: _newsTech,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            try {
              return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, i) {
                    final articles = snapshot.data[i];
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Article(
                                          imageUrl:
                                              articles['urlToImage'] ?? '',
                                          title: articles['title'],
                                          description:
                                              articles['description'] ?? '',
                                          content: articles['content'],
                                          author: articles['author'],
                                          publishedAt: articles['publishedAt'],
                                          url: articles['url'],
                                        )));
                          },
                          child: Column(
                            children: [
                              articles['urlToImage'] == null ||
                                      articles['urlToImage'] == ''
                                  ? Container(
                                      width: double.infinity,
                                      height: 200,
                                      child: Icon(Icons.image))
                                  : Container(
                                      width: double.infinity,
                                      height: 200,
                                      child: CachedNetworkImage(
                                        placeholder: (context, url) => Center(
                                            child: CircularProgressIndicator()),
                                        errorWidget: (context, url, error) =>
                                            Icon(Icons.error),
                                        fit: BoxFit.cover,
                                        imageUrl: articles['urlToImage'],
                                      )),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  articles['title'],
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(articles['description'] ?? ''),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  });
            } catch (e) {
              print(e);
            }
          }
          return CircularProgressIndicator();
        },
      ),
    );
  }
}
