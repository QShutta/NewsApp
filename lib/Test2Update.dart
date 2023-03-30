import 'dart:convert';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:recipe_app/articleUpdate.dart';
import 'package:recipe_app/InternetCheck.dart';

// import 'package:recipe_app/article.dart';
import 'package:cached_network_image/cached_network_image.dart';

class Test2 extends StatefulWidget {
  const Test2({super.key});

  @override
  State<Test2> createState() => _Test2State();
}

// Future<List<Map<dynamic, dynamic>>>?
dynamic _news;
dynamic _newsSport;
dynamic _newsTech;

class _Test2State extends State<Test2> {
  @override
  void initState() {
    super.initState();
    _news = featch();
    _newsSport = featchSport();
    _newsTech = featchTech();
  }

  // Future<List<Map<dynamic, dynamic>>>
  featch() async {
    try {
      var apiKey = "0b09183ac44f4acf9372b62427c7f55a";
      final apiUrl =
          'https://newsapi.org/v2/top-headlines?country=in&category=entertainment&apiKey=$apiKey';

      var res = await http.get(Uri.parse(apiUrl));
      if (res.statusCode == 200) {
        var parsed = jsonDecode(res.body);
        return parsed['articles'];
      } else {
        throw Exception("Faild to load the data from the internet");
      }
    } catch (e) {
      setState(() {
        _news = null;
        _newsSport = null;
        _newsTech = null;
      });
    }
  }

  featchSport() async {
    try {
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
    } catch (e) {
      setState(() {
        _news = null;
        _newsSport = null;
        _newsTech = null;
      });
    }
  }

  featchTech() async {
    try {
      var apiKey = "0b09183ac44f4acf9372b62427c7f55a";
      final apiUrl =
          'https://newsapi.org/v2/top-headlines?country=in&category=technology&apiKey=$apiKey';

      var res = await http.get(Uri.parse(apiUrl));
      if (res.statusCode == 200) {
        var parsed = jsonDecode(res.body);
        return parsed['articles'];
      } else {
        throw Exception("Faild to load the data from the internet");
      }
    } catch (e) {
      setState(() {
        _news = null;
        _newsSport = null;
        _newsTech = null;
      });
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
            BottomNavigationBarItem(icon: Icon(Icons.topic), label: "Top News"),
            BottomNavigationBarItem(
                icon: Icon(Icons.sports_football), label: "Sport"),
            BottomNavigationBarItem(
                icon: Icon(Icons.sports_esports), label: "Technology")
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
  final connection = Connectivity().checkConnectivity();
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
                              : Image.network(
                                  article['urlToImage'],
                                  loadingBuilder: (context, child,
                                      ImageChunkEvent? loadingProgress) {
                                    if (loadingProgress == null) return child;

                                    return Center(
                                        // CircularProgressIndicator
                                        // widget that shows the progress of the image loading. The value of
                                        //the CircularProgressIndicator will be based on how much of the image
                                        // has been loaded compared to its expected total size.
                                        child: SizedBox(
                                      width: double.infinity,
                                      height: 200,
                                      child: Center(
                                        child: CircularProgressIndicator(
                                          value: loadingProgress
                                                      .expectedTotalBytes !=
                                                  null
                                              ? loadingProgress
                                                      .cumulativeBytesLoaded /
                                                  loadingProgress
                                                      .expectedTotalBytes!
                                              : null,
                                        ),
                                      ),
                                    ));
                                  },
                                  width: double.infinity,
                                  height: 200,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Icon(Icons.image);
                                  },
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
      body:  FutureBuilder(
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
                                                    articles['urlToImage'] ??
                                                        '',
                                                title: articles['title'],
                                                description:
                                                    articles['description'] ??
                                                        '',
                                                content: articles['content'],
                                                author: articles['author'],
                                                publishedAt:
                                                    articles['publishedAt'],
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
                                            child: Image.network(
                                              articles['urlToImage'],
                                              loadingBuilder: (context,
                                                  child,
                                                  ImageChunkEvent?
                                                      loadingProgress) {
                                                if (loadingProgress == null)
                                                  return child;

                                                return Center(
                                                    // CircularProgressIndicator
                                                    // widget that shows the progress of the image loading. The value of
                                                    //the CircularProgressIndicator will be based on how much of the image
                                                    // has been loaded compared to its expected total size.

                                                    child:
                                                        CircularProgressIndicator(
                                                  value: loadingProgress
                                                              .expectedTotalBytes !=
                                                          null
                                                      ? loadingProgress
                                                              .cumulativeBytesLoaded /
                                                          loadingProgress
                                                              .expectedTotalBytes!
                                                      : null,
                                                ));
                                              },
                                              fit: BoxFit.cover,
                                              errorBuilder:
                                                  (context, error, stackTrace) {
                                                return Icon(Icons.image);
                                              },
                                            )),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        articles['title'],
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child:
                                          Text(articles['description'] ?? ''),
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
                                      child: Image.network(
                                        articles['urlToImage'],
                                        loadingBuilder: (context, child,
                                            ImageChunkEvent? loadingProgress) {
                                          if (loadingProgress == null)
                                            return child;
                                          return Center(
                                              // CircularProgressIndicator
                                              // widget that shows the progress of the image loading. The value of
                                              //the CircularProgressIndicator will be based on how much of the image
                                              // has been loaded compared to its expected total size.
                                              child: CircularProgressIndicator(
                                            value: loadingProgress
                                                        .expectedTotalBytes !=
                                                    null
                                                ? loadingProgress
                                                        .cumulativeBytesLoaded /
                                                    loadingProgress
                                                        .expectedTotalBytes!
                                                : null,
                                          ));
                                        },
                                        fit: BoxFit.cover,
                                        errorBuilder:
                                            (context, error, stackTrace) {
                                          return Icon(Icons.image);
                                        },
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
