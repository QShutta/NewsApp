import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class TestX extends StatefulWidget {
  const TestX({super.key});

  @override
  State<TestX> createState() => _TestXState();
}

class _TestXState extends State<TestX> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          CachedNetworkImage(
            imageUrl:
                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRXxKJ2zVImNcXmLsVfapxOqdjzKaB9QV3jmjhJfuBU&s",
            placeholder: (context, url) {
              return Center(
                child: CircularProgressIndicator(),
              );
            },
            errorWidget: (context, url, error) {
              return Icon(Icons.image);
            },
          )
        ],
      ),
    );
  }
}
