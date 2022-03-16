import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.only(top: 80, left: 30, right: 30, bottom: 80),
        child: Column(
          // biggest column
          children: [
            Row(
              // 날짜, 이름
              children: [
                Text(
                  // 날짜
                  DateFormat("MM-dd").format(DateTime.now()),
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Expanded(child: Container()),
                const Text(
                  // 이름
                  "안녕하세요 지영우님!",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: 30),
            Row(
              // 총 섭취 칼로리
              children: [
                const Text(
                  "총 섭취 칼로리",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                Expanded(child: Container()),
                const Text(
                  "896", // 섭취 칼로리
                  style: TextStyle(fontSize: 18),
                ),
                const Text(
                  "/",
                  style: TextStyle(fontSize: 18),
                ),
                const Text(
                  "1500", // 기초대사량
                  style: TextStyle(fontSize: 18),
                ),
                const Text(
                  "kcal",
                  style: TextStyle(fontSize: 18),
                ),
              ],
            ),
            SizedBox(height: 30),
            Row(
              // 주요 영양소 title
              children: [
                const Text(
                  "주요영양소",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(height: 20),
            Container(
              // 주요 영양소 content
              padding: EdgeInsets.only(left: 10, right: 10),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 4,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Colors.amber[100],
              ),
              child: Row(
                children: [
                  // 탄단지 title, 그래프, 섭취량

                  Container(
                    // 탄단지 title
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          "탄수화물",
                          style: TextStyle(fontSize: 20),
                        ),
                        SizedBox(height: 30),
                        Text(
                          "단백질",
                          style: TextStyle(fontSize: 20),
                        ),
                        SizedBox(height: 30),
                        Text(
                          "지방",
                          style: TextStyle(fontSize: 20),
                        ),
                      ],
                    ),
                  ),
                  Expanded(child: Container()),

                  Container(
                    // 탄단지 그래프
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "탄수화물 그래프",
                          style: TextStyle(fontSize: 20),
                        ),
                        SizedBox(height: 30),
                        const Text(
                          "단백질 그래프",
                          style: TextStyle(fontSize: 20),
                        ),
                        SizedBox(height: 30),
                        const Text(
                          "지방 그래프",
                          style: TextStyle(fontSize: 20),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 15),

                  Container(
                    // 탄단지 섭취량
                    child: Column(
                      // 탄단지 섭취량, 권장섭취량
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          // 탄수화물
                          children: [
                            const Text("160"), // 탄수화물 섭취량
                            const Text("/"),
                            const Text("200"), // 탄수화물 권장 섭취량
                            const Text("g"), // 탄수화물 단위
                          ],
                        ),
                        SizedBox(height: 30),
                        Row(
                          // 단백질
                          children: [
                            const Text("160"), // 단백질 섭취량
                            const Text("/"),
                            const Text("200"), // 단백질 권장 섭취량
                            const Text("g"), // 단백질 단위
                          ],
                        ),
                        SizedBox(height: 30),
                        Row(
                          // 지방
                          children: [
                            const Text("170"), // 지방 섭취량
                            const Text("/"),
                            const Text("210"), // 지방 권장 섭취량
                            const Text("g"), // 지방 단위
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 30),
            // Expanded(child: Container()),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              // 식단 로그 stepper
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: Colors.amber[100],
                      borderRadius: BorderRadius.circular(30),
                      gradient: LinearGradient(
                        colors: [
                          Colors.green.withOpacity(0.5),
                          Color.fromARGB(180, 100, 205, 0),
                        ],
                        begin: Alignment.bottomLeft,
                        end: Alignment.centerRight,
                      )),
                  width: MediaQuery.of(context).size.width / 1.2,
                  height: MediaQuery.of(context).size.height / 4,
                ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
        backgroundColor: Colors.green[600],
      ),
    );
  }
}
