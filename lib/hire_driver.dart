import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HiredriverPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
     return Scaffold(
       appBar: AppBar(
         title: Text('Hire Driver'),
         centerTitle: true,
       ),
       body: Center(
         child: Text('Hire Driver Page'),
       ),
     );
  }

}