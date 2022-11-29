import 'package:flutter/material.dart';
import 'package:programing_contest/screen/top.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: '単語アプリ',
      home: topPage(),
    );
  }
}
