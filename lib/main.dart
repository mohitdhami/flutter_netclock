//developed by Mohit Singh Dhami
//instagram.com/mohitdhamii
//...
import 'package:flutter/material.dart';
import 'package:netclock/HomePage.dart';
void main()=> runApp(MyApp());
class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}