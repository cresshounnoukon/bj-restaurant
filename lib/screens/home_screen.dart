import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http_gelocalisation_futurebuilder/models/post.dart';
import 'package:http_gelocalisation_futurebuilder/screens/detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.title});

  final String title;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Post> posts = [];
  String title = "Home page";

  List<String> categories = ["Jazz", "hipp"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: [
            Expanded(
              child: Container(
                color: Colors.purple,
                child: Center(
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: Colors.white),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                  child: ListView(
                padding: EdgeInsets.zero,
                children: categories
                    .map(
                      (e) => ListTile(
                        title: Text("$e"),
                        onTap: () async {
                          Navigator.pop(context);
                          var result = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DetailScreen(),
                                  fullscreenDialog: true));
                          categories.add(result);
                          setState(() {});
                        },
                      ),
                    )
                    .toList(),
              )),
            ),
            Expanded(
              child: Container(
                color: Colors.green,
                child: Center(
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: Text(title),
      ),
      body: FutureBuilder(
        future: getPostsFromServer(),
        builder: (BuildContext context, AsyncSnapshot<List<Post>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return Center(child: Text("${snapshot.error}"));
            }
            if (snapshot.hasData) {
              return ListView(
                shrinkWrap: true,
                children: snapshot.data!
                    .map((post) => ListTile(
                          onTap: () {
                            print(post);
                          },
                          title: Text("${post.title}"),
                          subtitle: Text("${post.body}"),
                          leading: CircleAvatar(
                            child: Text("${post.getFirstCharacter()}"),
                          ),
                        ))
                    .toList(),
              );
            }
          }

          return Center(child: Text("data"));
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          posts = await getPostsFromServer();
          setState(() {});
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Future<List<Post>> getPostsFromServer() async {
    try {
      String url = "https://jsonplaceholder.typicode.com/posts";
      var response = await http.get(Uri.parse(url));
      print("${response.statusCode}");
      //print("${response.body}");
      List json = jsonDecode(response.body);
      return json.map((e) => Post.fromJson(e)).toList();
    } catch (e) {
      return Future.error("Impossible d'accéder à la donnée externe");
    }
  }
}
