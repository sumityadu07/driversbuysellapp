import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ScrapcarPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Scrap car'),
        centerTitle: true,
      ),
      body: Center(
        child: Text('Scrap car Page'),
      ),
    );
  }
}