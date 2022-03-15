import 'package:flutter/material.dart';

class FoodLog extends StatefulWidget {
  FoodLog({Key? key}) : super(key: key);

  @override
  State<FoodLog> createState() => _FoodLogState();
}

class _FoodLogState extends State<FoodLog> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: const Text("HI!"));
  }
}
