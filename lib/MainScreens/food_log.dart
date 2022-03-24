import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:demo/json/nutriStat.dart';
import 'dart:async';
import 'dart:convert';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:image_picker/image_picker.dart';

import 'inference.dart';
// import 'package:provider/provider.dart';

Future<NutriStat> fetchUserData(String userid) async {
  String baseUrl = 'http://192.168.1.98:8000/log/today/homepage/'; // angwoo
  // String baseUrl = 'http://10.0.2.2:8000/log/today/homepage/'; // hhw
  final response = await http.get(
    Uri.parse(baseUrl + userid),
  );
  print("${response.statusCode}, ${utf8.decode(response.bodyBytes)}");
  if (response.statusCode == 200) {
    return NutriStat.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
  } else {
    throw Exception('Failed to load data');
  }
}

Future<dynamic> predictImg(String userid) async {
  try {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) {
      return;
    } else {
      final imageTemporary = File(image.path);
      // setState(() => this.image = imageTemporary);
      String result = '';
      // String baseUrl = 'http://10.0.2.2:8000/log/upload/image/'; // 혜원
      String baseUrl = 'http://192.168.1.98:8000/log/upload/image/'; // 영우
      var uri = Uri.parse(baseUrl + userid);
      var request = http.MultipartRequest('POST', uri);
      Map<String, String> headers = {"Content-type": "multipart/form-data"};
      request.files.add(http.MultipartFile(
        'image',
        imageTemporary.readAsBytes().asStream(),
        imageTemporary.lengthSync(),
        filename:
            "${userid}/${DateFormat.yMd().add_jm().format(DateTime.now())}",
      ));
      request.headers.addAll(headers);
      print("request: " + request.toString());

      var response = await request.send();
      result = await response.stream.bytesToString();
      // var response = Streamedresponse.stream.bytesToString();
      // response.stream.transform(utf8.decoder).listen((value) {
      //   result = value;
      // });
      return result;
    }
  } on PlatformException catch (e) {
    // Don't allow access to photos
    print('Failed to pick image: $e');
  }
}

class FoodLog extends StatefulWidget {
  String email;
  FoodLog({Key? key, required this.email}) : super(key: key);

  @override
  State<FoodLog> createState() => _FoodLogState();
}

class _FoodLogState extends State<FoodLog> {
  // late List<Nutridata> _chartData;
  late String userid;
  late Future<NutriStat> userData;
  File? image;
  late dynamic url;
  late List<dynamic> foodList;
  late dynamic key;
  late List<dynamic> classCategory;

  @override
  void initState() {
    userid = widget.email;
    userData = fetchUserData(userid);
    // _chartData = getChartData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        // width: MediaQuery.of(context).size.width,
        // height: MediaQuery.of(context).size.height,
        // padding: EdgeInsets.all(30),
        child: FutureBuilder<NutriStat>(
          future: userData,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final List<Nutridata> _chartData = [
                // (category, 권장-섭취, 섭취량)
                Nutridata(
                    "지방",
                    max(snapshot.data?.rdi.Fat - snapshot.data?.nutrStatus.Fat,
                        0),
                    snapshot.data?.nutrStatus.Fat), // 32-10=22, 10(섭취량)
                Nutridata(
                    "단백질",
                    max(
                        snapshot.data?.rdi.Protein -
                            snapshot.data?.nutrStatus.Protein,
                        0),
                    snapshot.data?.nutrStatus.Protein), // 150-90=60, 90(섭취량)
                Nutridata(
                    "탄수화물",
                    max(
                        snapshot.data?.rdi.Carbohydrate -
                            snapshot.data?.nutrStatus.Carbohydrate,
                        0),
                    snapshot.data?.nutrStatus
                        .Carbohydrate), // 200-160 = 40, 160(섭취량)
              ];
              return SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Container(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            // 날짜
                            DateFormat("MM-dd").format(DateTime.now()),
                            style: const TextStyle(
                              fontSize: 23,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Expanded(child: Container()),
                          Text(
                            // 이름
                            "Hello ${snapshot.data!.username}!",
                            style: const TextStyle(
                              fontSize: 23,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 25),
                      Row(
                        children: [
                          const Text(
                            "Total Calorie Intake",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          Expanded(child: Container()),
                          Text(
                            "${snapshot.data!.nutrStatus.Calories}", // 섭취 칼로리
                            style: const TextStyle(fontSize: 18),
                          ),
                          const Text(
                            "/",
                            style: TextStyle(fontSize: 18),
                          ),
                          Text(
                            "${snapshot.data!.rdi.Calories}", // 기초대사량
                            style: const TextStyle(fontSize: 18),
                          ),
                          const Text(
                            "kcal",
                            style: TextStyle(fontSize: 18),
                          ),
                        ],
                      ),
                      const SizedBox(height: 25),
                      Row(
                        children: [
                          const Text(
                            "Macronutrients",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          Expanded(child: Container())
                        ],
                      ),
                      SizedBox(height: 20),
                      Container(
                        padding: EdgeInsets.only(right: 15),
                        height: MediaQuery.of(context).size.height / 4.5,
                        decoration: BoxDecoration(
                          color: Colors.green.withAlpha(100),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Row(
                          children: [
                            SfCartesianChart(
                              enableAxisAnimation: true,
                              series: <ChartSeries>[
                                StackedBar100Series<Nutridata, String>(
                                  dataSource: _chartData,
                                  xValueMapper: (Nutridata nut, _) =>
                                      nut.nutriCategory,
                                  yValueMapper: (Nutridata nut, _) =>
                                      nut.nutriIntake,
                                  name: '사용자 섭취량',
                                  color: Colors.green,
                                  width: 0.5,
                                  borderRadius: BorderRadius.circular(5),
                                  spacing: 2,
                                ),
                                StackedBar100Series<Nutridata, String>(
                                  dataSource: _chartData,
                                  xValueMapper: (Nutridata nut, _) =>
                                      nut.nutriCategory,
                                  yValueMapper: (Nutridata nut, _) =>
                                      nut.nutriResidual,
                                  name: '권장 섭취량',
                                  color: Colors.grey,
                                  width: 0.5,
                                  borderRadius: BorderRadius.circular(5),
                                  spacing: 2,
                                )
                              ],
                              primaryXAxis: CategoryAxis(),
                            ),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    // 탄수화물
                                    children: [
                                      Text(
                                          "${snapshot.data!.nutrStatus.Carbohydrate}"), // 탄수화물 섭취량
                                      const Text("/"),
                                      Text(
                                          "${snapshot.data!.rdi.Carbohydrate}"), // 탄수화물 권장 섭취량
                                      const Text("g"), // 탄수화물 단위
                                    ],
                                  ),
                                  const SizedBox(height: 35),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    // 단백질
                                    children: [
                                      Text(
                                          "${snapshot.data!.nutrStatus.Protein}"), // 단백질 섭취량
                                      const Text("/"),
                                      Text(
                                          "${snapshot.data!.rdi.Protein}"), // 단백질 권장 섭취량
                                      const Text("g"), // 단백질 단위
                                    ],
                                  ),
                                  const SizedBox(height: 35),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    // 지방
                                    children: [
                                      Text(
                                          "${snapshot.data!.nutrStatus.Fat}"), // 지방 섭취량
                                      const Text("/"),
                                      Text(
                                          "${snapshot.data!.rdi.Fat}"), // 지방 권장 섭취량
                                      const Text("g"), // 지방 단위
                                    ],
                                  ),
                                  const SizedBox(height: 30),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(height: 25),
                      Row(
                        children: [
                          const Text(
                            "Please Log your Meal!",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          Expanded(child: Container())
                        ],
                      ),
                      const SizedBox(height: 25),
                      Text(snapshot.data!.meal.toString())
                    ],
                  ),
                ),
              );
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }
            return const CircularProgressIndicator();
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          dynamic res = await predictImg(userid);
          url = jsonDecode(res)['link'];
          foodList = jsonDecode(res)['food_list'];
          key = jsonDecode(res)['Origin_S3_key'];
          classCategory = jsonDecode(res)['Class_type'];
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Inference(
                uri: url,
                subcat: foodList,
                s3Key: key,
                classCat: classCategory,
                email: userid,
              ),
            ),
          ).then((value) => setState(() {
                userData;
              }));
        },
        child: const Icon(Icons.add),
        backgroundColor: Colors.green[600],
      ),
    );
  }
}

class Nutridata {
  Nutridata(this.nutriCategory, this.nutriResidual, this.nutriIntake);
  final String nutriCategory;
  final num nutriResidual;
  final num nutriIntake;
}
