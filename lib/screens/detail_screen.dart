import 'package:flutter/material.dart';

class DetailScreen extends StatelessWidget {
    DetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return   Scaffold(
      appBar: AppBar(),
      body: Center(
        child: ElevatedButton(
          child: Text("Renvoyer une valeur", style: TextStyle(fontSize: 24),),
          onPressed: (){
            Navigator.pop(context, "BOnjour tout le monde");

          },
        ),
      ),

    );
  }
}
