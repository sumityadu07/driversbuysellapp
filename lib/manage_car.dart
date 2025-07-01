import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ManageCarPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
     return Scaffold(
       appBar: AppBar(
         title: Text('Manage Your Car'),
         centerTitle: true,
       ),
      body: Text("Comming Soon", textAlign: TextAlign.center, style: TextStyle(color: Colors.green, fontSize: 100),),
     );
  }
  
}