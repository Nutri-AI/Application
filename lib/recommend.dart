import 'package:flutter/material.dart';

class Recommend extends StatefulWidget {
  Recommend({Key? key}) : super(key: key);

  @override
  State<Recommend> createState() => _RecommendState();
}

class _RecommendState extends State<Recommend> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: const Text("영양제 추천 탭입니다"));
  }
}
