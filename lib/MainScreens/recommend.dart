import 'package:demo/json/nutriRecommend.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';

Future<Product> fetchRecommendations(String userid) async {
  String baseUrl = 'http://192.168.45.181:8000/log/today/homepage/'; // 영우 집
  final response = await http.get(
    Uri.parse(baseUrl + userid),
  );
  if (response.statusCode == 200) {
    return Product.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
  } else {
    throw Exception('Failed to load data');
  }
}

class Recommend extends StatefulWidget {
  String email;
  Recommend({Key? key, required this.email}) : super(key: key);

  @override
  State<Recommend> createState() => _RecommendState();
}

class _RecommendState extends State<Recommend> {
  late String userid;
  late Future<Product> recommendations;
  late dynamic url;
  late dynamic key;
  dynamic imgUrls;
  NumberFormat myFormat = NumberFormat.decimalPattern('en_us');
  launchBrower(String url) async {
    if (await canLaunch(url)) {
      await launch(url, forceSafariVC: true);
    }
  }

  Future loadImgUrls() async {
    var jsonText = await rootBundle.loadString('assets/logos.json');
    final logoUrls = jsonDecode(jsonText);
    setState(() {
      imgUrls = logoUrls;
    });
  }

  @override
  void initState() {
    userid = widget.email;
    recommendations = fetchRecommendations(userid);
    imgUrls = loadImgUrls();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder<Product>(
          future: recommendations,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              Image imgUrl(String name) {
                if (imgUrls.containsKey(name.split(',')[0])) {
                  return Image.network(
                    imgUrls[name.split(',')[0]],
                    width: 150,
                    height: 100,
                    errorBuilder: (context, exception, stackTrace) {
                      return Image.asset(
                        'assets/Iherb_logo.jpeg',
                        width: 150,
                        height: 100,
                      );
                    },
                  );
                } else {
                  return Image.asset(
                    'assets/Iherb_logo.jpeg',
                    width: 150,
                    height: 100,
                  );
                }
              }

              return SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Container(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            // 날짜
                            DateFormat("MM/dd").format(DateTime.now()),
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
                            "Only For You!",
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold),
                          ),
                          Expanded(child: Container()),
                        ],
                      ),
                      const SizedBox(height: 25),
                      Row(
                        children: [
                          const Text(
                            "Vitamins",
                            style: TextStyle(
                                fontSize: 22, fontWeight: FontWeight.bold),
                          ),
                          Expanded(child: Container()),
                        ],
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            children: [
                              Row(
                                children: <Widget>[
                                  for (var i = 0; i < 3; i++)
                                    Container(
                                      padding: EdgeInsets.all(10),
                                      width: MediaQuery.of(context).size.width /
                                          2.5,
                                      child: Column(
                                        children: [
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                2.5,
                                            child: OutlinedButton(
                                              onPressed: () {
                                                setState(() {
                                                  launchBrower(snapshot
                                                      .data!.vitamin[i].url);
                                                });
                                              },
                                              child: imgUrl(snapshot
                                                  .data!.vitamin[i].title),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            snapshot.data!.vitamin[i].title
                                                .split(",")
                                                .sublist(1, 3)
                                                .toString()
                                                .substring(
                                                    1,
                                                    snapshot.data!.vitamin[i]
                                                            .title
                                                            .split(",")
                                                            .sublist(1, 3)
                                                            .toString()
                                                            .length -
                                                        1)
                                                .trim(),
                                            style: TextStyle(
                                                fontWeight: FontWeight.w600),
                                          ),
                                          SizedBox(height: 5),
                                          Row(
                                            children: [
                                              Text(
                                                "${myFormat.format(snapshot.data!.vitamin[i].price).toString()}원",
                                                textAlign: TextAlign.start,
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w300,
                                                  color: Colors.black54,
                                                ),
                                              ),
                                              Expanded(child: Container()),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          const Text(
                            "Minerals",
                            style: TextStyle(
                                fontSize: 22, fontWeight: FontWeight.bold),
                          ),
                          Expanded(child: Container()),
                        ],
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  for (var i = 0; i < 3; i++)
                                    Container(
                                      padding: EdgeInsets.all(10),
                                      width: MediaQuery.of(context).size.width /
                                          2.5,
                                      child: Column(
                                        children: [
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                2.5,
                                            child: OutlinedButton(
                                              onPressed: () {
                                                setState(() {
                                                  launchBrower(snapshot
                                                      .data!.mineral[i].url);
                                                });
                                              },
                                              child: imgUrl(snapshot
                                                  .data!.mineral[i].title),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            snapshot.data!.mineral[i].title
                                                .split(",")
                                                .sublist(1, 3)
                                                .toString()
                                                .substring(
                                                    1,
                                                    snapshot.data!.mineral[i]
                                                            .title
                                                            .split(",")
                                                            .sublist(1, 3)
                                                            .toString()
                                                            .length -
                                                        1)
                                                .trim(),
                                            style: TextStyle(
                                                fontWeight: FontWeight.w600),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                "${myFormat.format(snapshot.data!.mineral[i].price).toString()}원",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w300,
                                                  color: Colors.black54,
                                                ),
                                              ),
                                              Expanded(child: Container()),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 25),
                      Row(
                        children: [
                          const Text(
                            "Amino Acids",
                            style: TextStyle(
                                fontSize: 22, fontWeight: FontWeight.bold),
                          ),
                          Expanded(child: Container()),
                        ],
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            children: [
                              Row(
                                children: <Widget>[
                                  for (var i = 0; i < 3; i++)
                                    Container(
                                      padding: EdgeInsets.all(10),
                                      width: MediaQuery.of(context).size.width /
                                          2.5,
                                      child: Column(
                                        children: [
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                2.5,
                                            child: OutlinedButton(
                                              onPressed: () {
                                                setState(() {
                                                  launchBrower(snapshot
                                                      .data!.aminoAcid[i].url);
                                                });
                                              },
                                              child: imgUrl(snapshot
                                                  .data!.aminoAcid[i].title),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            snapshot.data!.aminoAcid[i].title
                                                .split(",")
                                                .sublist(1, 3)
                                                .toString()
                                                .substring(
                                                    1,
                                                    snapshot.data!.aminoAcid[i]
                                                            .title
                                                            .split(",")
                                                            .sublist(1, 3)
                                                            .toString()
                                                            .length -
                                                        1)
                                                .trim(),
                                            style: TextStyle(
                                                fontWeight: FontWeight.w600),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                "${myFormat.format(snapshot.data!.aminoAcid[i].price).toString()}원",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w300,
                                                  color: Colors.black54,
                                                ),
                                              ),
                                              Expanded(child: Container()),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 25),
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
    );
  }
}
