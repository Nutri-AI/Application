import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class FoodLog extends StatefulWidget {
  FoodLog({Key? key}) : super(key: key);

  @override
  State<FoodLog> createState() => _FoodLogState();
}

class _FoodLogState extends State<FoodLog> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(top: 80, left: 30, right: 30, bottom: 80),
        child: Column(
          children: [
            Row(
              // 날짜, name
              children: [
                Text(
                  DateFormat("MM-dd").format(DateTime.now()),
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Expanded(child: Container()),
                const Text(
                  "안녕하세요 지영우님!",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              children: [
                const Text(
                  "주요영양소",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Container(
              width: MediaQuery.of(context).size.width / 2.5,
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    // 탄수화물
                    children: [
                      const Text("탄수화물"),
                      Expanded(child: Container()),
                      const Text("160"),
                      const Text("/"),
                      const Text("235"),
                      const Text("g"),
                    ],
                  ),
                  SizedBox(height: 20), // 탄수화물 그래프
                  Row(
                    // 단백질
                    children: [
                      const Text("단백질"),
                      Expanded(child: Container()),
                      const Text("30"),
                      const Text("/"),
                      const Text("54"),
                      const Text("g"),
                    ],
                  ),
                  SizedBox(height: 20), // 탄수화물 그래프
                  Row(
                    // 지방
                    children: [
                      const Text("지방"),
                      Expanded(child: Container()),
                      const Text("25"),
                      const Text("/"),
                      const Text("32"),
                      const Text("g"),
                    ],
                  ),
                ], // 주요영양소의 children
              ),
            ),
          ],
        ),
      ),
    );
  }
}
