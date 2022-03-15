import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Analyze extends StatefulWidget {
  Analyze({Key? key}) : super(key: key);

  @override
  State<Analyze> createState() => _AnalyzeState();
}

class _AnalyzeState extends State<Analyze> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Text("분석 탭입니다!"),
    );
  }
}
