import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:recipe_app/article.dart';

class Test2 extends StatefulWidget {
  const Test2({super.key});

  @override
  State<Test2> createState() => _Test2State();
}

// Future<List<Map<dynamic, dynamic>>>?
dynamic _news;

class _Test2State extends State<Test2> {
  @override
  void initState() {
    super.initState();
    _news = featch();
  }

  // Future<List<Map<dynamic, dynamic>>>
  featch() async {
    var apiKey = "0b09183ac44f4acf9372b62427c7f55a";
    final apiUrl =
        'https://newsapi.org/v2/top-headlines?country=us&apiKey=$apiKey';

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
            BottomNavigationBarItem(icon: Icon(Icons.topic), label: "Top News"),
            BottomNavigationBarItem(
                icon: Icon(Icons.sports_football), label: "Sport"),
            BottomNavigationBarItem(
                icon: Icon(Icons.sports_esports), label: "Technology")
          ],
        ),
        appBar: AppBar(
          // title: Text("News"),
          actions: [
            IconButton(
                onPressed: () {
                  showSearch(context: context, delegate: search());
                },
                icon: Icon(Icons.search))
          ],
        ));
  }
}

class search extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    // TODO: implement buildActions
    return [IconButton(onPressed: () {}, icon: Icon(Icons.cancel))];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    return IconButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        icon: Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    return Text("");
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions
    return Center(
      child: Text("محتوي البحث"),
    );
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
                  child: ListTile(
                    // onTap: () {
                    //   Navigator.push(context,
                    //       MaterialPageRoute(builder: (context) {
                    //     return Article(imageUrl:article['urlToImage']);
                    //   }));
                    // },
                    // con
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
                                )),
                      );
                    },
                    leading: article['urlToImage'] == null
                        ? Container(
                            width: 100, height: 100, child: Icon(Icons.image))
                        : Image.network(
                            article['urlToImage'],
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                          ),
                    title: Text(article['title']),
                    subtitle: Text(article['description'] ?? ''),
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
      body: ListView(
        children: [Text("Page2")],
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
      body: ListView(
        children: [Text("Page3")],
      ),
    );
  }
}
