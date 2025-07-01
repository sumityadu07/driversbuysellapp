import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NewCarPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Car Page'),
      ),
      body: Center(
        child: Text("Comming Soon", textAlign: TextAlign.center, style: TextStyle(color: Colors.green, fontSize: 100),),
      ),

    );
  }
}