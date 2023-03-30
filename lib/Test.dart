import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';

class Test extends StatefulWidget {
  const Test({super.key});

  @override
  State<Test> createState() => _TestState();
}

late Future<List<dynamic>> _news;

class _TestState extends State<Test> {
  // late Future<List<dynamic>> _news;
  String? text;
  @override
  void initState() {
    super.initState();
    _news = featchNews();
  }

// String query
  Future<List<dynamic>> featchNews() async {
    // var client = HttpClient()
    //   ..badCertificateCallback =
    //       ((X509Certificate cert, String host, int port) => true);

    // var ioClient = IOClient(client);

    var apiKey = "0b09183ac44f4acf9372b62427c7f55a";
    var url = 'https://newsapi.org/v2/top-headlines?country=us&apiKey=$apiKey';
    // if (query != null) {
    //   url = 'https://newsapi.org/v2/everything?q=$query&apiKey=$apiKey';
    // }

    var res = await http.get(Uri.parse(url));
    if (res.statusCode == 200) {
      // ioClient.close();
      final parsed = jsonDecode(res.body);
      //Did the article is a map contain key:values?
      //Yes ,it return a list of key and values.
      return parsed['articles'];
    } else {
      throw Exception("Faild to load the data");
    }
  }

  int selectedTap = 0;
  List pages = [Page1(), Page2(), Page3()];
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
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
      future: _news,
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, i) {
                //قمنا بي انشاء متغير عشان نقدر عن طريق المتغير نتعامل مع الماب الجاينا من ال الأي بي  أي .
                //بي كدة المتغير دة هو  عبارة عن لست ,بتحتوي ليك علي كل الماب ,
                //xxxxxxxxxxxxxxxxx
                final article = snapshot.data![i];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    leading: article['urlToImage'] != null
                        ? Image.network(
                            article['urlToImage'],
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                          )
                        : Icon(Icons.image),
                    title: Text(article['title']),
                    subtitle: Text(article['description'] ?? ''),
                    onTap: () {},
                  ),
                );
              });
        }
        return Center(child: CircularProgressIndicator());
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
