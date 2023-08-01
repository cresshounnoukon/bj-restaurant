import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedScreen extends StatefulWidget {
  const SharedScreen({super.key});

  @override
  State<SharedScreen> createState() => _SharedScreenState();
}

class _SharedScreenState extends State<SharedScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Shared "),
        actions: [
          IconButton(onPressed: () async{
           String?data= await readUserName();
           print(data);
          },
              icon: Icon(Icons.person))],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await writeUserName();
        },
      ),
    );
  }

  writeUserName() async {
    // Obtain shared preferences.
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('username', 'Charles le bon');
    print("Fait");
  }

  Future<String?> readUserName() async {
    // Obtain shared preferences.
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('username');
  }
}
