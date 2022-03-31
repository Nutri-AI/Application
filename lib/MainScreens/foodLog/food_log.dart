import 'dart:io';
import 'dart:math';
import 'package:demo/CustomDesign/customColor.dart';
import 'package:flutter/cupertino.dart';
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

import 'package:demo/MainScreens/foodLog/inference.dart';

Future<NutriStat> fetchUserData(String userid) async {
  String baseUrl = 'http://52.78.143.49:8000/log/today/homepage/'; // angwoo
  // String baseUrl = 'http://192.168.1.7:8000/log/today/homepage/'; // angwoo
  // String baseUrl = 'http://10.0.2.2:8000/log/today/homepage/'; // hhw
  // String baseUrl = 'http://192.168.219.107:8000/log/today/homepage/'; // 영우 집
  final response = await http.get(
    Uri.parse(baseUrl + userid),
  );
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
      String baseUrl = 'http://52.78.143.49:8000/log/upload/image/'; // 혜원
      // String baseUrl = 'http://10.0.2.2:8000/log/upload/image/'; // 혜원
      // String baseUrl = 'http://192.168.1.7:8000/log/upload/image/'; // 영우
      //String baseUrl = 'http://192.168.219.107:8000/log/upload/image/';
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
              final List<dynamic> _mealData = snapshot.data!.meal.toList();

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
                            DateFormat("yy-MM-dd").format(DateTime.now()),
                            style: const TextStyle(
                              fontSize: 20,
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
                          color: Color.fromRGBO(255, 247, 226, 1),
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
                                  color: Color.fromARGB(255, 62, 165, 65),
                                  borderColor: Colors.green[100],
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
                                  color: Color.fromARGB(255, 92, 92, 92),
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
                                        "${snapshot.data!.nutrStatus.Carbohydrate}/${snapshot.data!.rdi.Carbohydrate}",
                                        style: TextStyle(
                                          fontSize: 12,
                                        ),
                                      ), // 탄수화물 섭취량
                                      const Text(
                                        "g",
                                        style: TextStyle(
                                          fontSize: 12,
                                        ),
                                      ), // 탄수화물 단위
                                    ],
                                  ),
                                  const SizedBox(height: 40),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    // 단백질
                                    children: [
                                      Text(
                                        "${snapshot.data!.nutrStatus.Protein}/${snapshot.data!.rdi.Protein}",
                                        style: TextStyle(
                                          fontSize: 12,
                                        ),
                                      ), // 단백질 섭취량
                                      const Text(
                                        "g",
                                        style: TextStyle(
                                          fontSize: 12,
                                        ),
                                      ), // 단백질 단위
                                    ],
                                  ),
                                  const SizedBox(height: 40),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    // 지방
                                    children: [
                                      Text(
                                        "${snapshot.data!.nutrStatus.Fat}/${snapshot.data!.rdi.Fat}",
                                        style: TextStyle(
                                          fontSize: 12,
                                        ),
                                      ), // 지방 섭취량
                                      const Text(
                                        "g",
                                        style: TextStyle(
                                          fontSize: 12,
                                        ),
                                      ), // 지방 단위
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
                      for (var i = 0; i < _mealData.length; i++)
                        Container(
                          padding: EdgeInsets.all(5),
                          child: ListTile(
                            title: Text(
                              _mealData[i][0].substring(11, 16),
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                            subtitle: Text(
                              _mealData[i][1].toString().substring(
                                  1, (_mealData[i][1].toString().length - 1)),
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                              ),
                            ),
                            leading: Icon(
                              Icons.food_bank_outlined,
                              color: Color.fromRGBO(245, 118, 21, 1),
                              size: 30,
                            ),
                            tileColor: Color.fromRGBO(223, 247, 202, 1),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              );
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }
            return const CupertinoActivityIndicator();
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

          if (classCategory.isEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text('Oops! 유료계정으로 전환해주세요! :)'),
            ));
          } else {
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
                  userData = fetchUserData(userid);
                }));
          }
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
