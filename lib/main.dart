import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: MaterialApp(
        title: '百姓生活+',
        home: Scaffold(
          appBar: AppBar(
            title: Text('百姓生活+'),
          ),
          body: Center(
            child: Text('百姓生活+'),
          ),
        ),
      ),
    );
  }
}
