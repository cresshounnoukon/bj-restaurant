import 'package:flutter/material.dart';

import 'package:http_gelocalisation_futurebuilder/screens/onbording_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,

      theme: ThemeData(

        primarySwatch: Colors.teal,
       useMaterial3: true,
      ),
      home:  OnbordingScreen(),
    );
  }
}


