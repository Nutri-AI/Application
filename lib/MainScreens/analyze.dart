import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class Analyze extends StatefulWidget {
  Analyze({Key? key}) : super(key: key);

  @override
  State<Analyze> createState() => _AnalyzeState();
}

class _AnalyzeState extends State<Analyze> {
  late List<Nutridata> _chartData;
  // late TooltipBehavior _tooltipBehavior;
  // late variable: has no value,
  //its value will be initialized in the Future

  @override
  void initState() {
    _chartData = getChartData();
    // _tooltipBehavior = TooltipBehavior(enable: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.only(top: 20, left: 30, right: 30, bottom: 50),
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
                    "총 섭취 영양소",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(height: 30),
              Container(
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width / 1.2,
                height: MediaQuery.of(context).size.height / 3,
                child: SfCartesianChart(
                  // legend: Legend(isVisible: true),
                  // tooltipBehavior: _tooltipBehavior,
                  series: <ChartSeries>[
                    StackedBar100Series<Nutridata, String>(
                        dataSource: _chartData,
                        xValueMapper: (Nutridata nut, _) => nut.nutriCategory,
                        yValueMapper: (Nutridata nut, _) => nut.nutriIntake,
                        name: '사용자 섭취량',
                        color: Colors.green),
                    StackedBar100Series<Nutridata, String>(
                        dataSource: _chartData,
                        xValueMapper: (Nutridata nut, _) => nut.nutriCategory,
                        yValueMapper: (Nutridata nut, _) => nut.nutriResidual,
                        name: '권장 섭취량',
                        color: Colors.grey)
                  ],
                  primaryXAxis: CategoryAxis(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Nutridata> getChartData() {
    // Display 되는 순서의 거꾸로 데이터를 입력해야함
    final List<Nutridata> chartData = [
      Nutridata("지방", 22, 10), // 32-10=22, 10(섭취량)
      Nutridata("단백질", 60, 90), // 150-90=60, 90(섭취량)
      Nutridata("탄수화물", 40, 160), // 200-160 = 40, 160(섭취량)
    ];
    return chartData;
  }
}

class Nutridata {
  Nutridata(this.nutriCategory, this.nutriResidual, this.nutriIntake);
  final String nutriCategory;
  final num nutriResidual;
  final num nutriIntake;
}
