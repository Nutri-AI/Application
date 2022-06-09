import 'package:flutter/material.dart';
import 'package:demo/CustomDesign/customIcon.dart';
import 'package:demo/MainScreens/foodLog/food_log.dart';
import 'package:demo/MainScreens/analyze/analyze.dart';
import 'package:demo/MainScreens/recommend.dart';
import 'package:demo/MainScreens/mypage.dart';
import 'package:demo/MainScreens/searchTest/searchTest.dart';
// import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  String email;
  HomePage({Key? key, required this.email}) : super(key: key);
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  late String userid;

  @override
  void initState() {
    userid = widget.email;
    super.initState();
  }

  // static TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.black);

  List<Widget> _children() => [
        FoodLog(email: userid),
        Analyze(email: userid),
        Recommend(email: userid),
        MyPage(email: userid),
        SearchTest(email: userid),
      ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> pageChildren = _children();
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(DateFormat("MM-dd").format(DateTime.now())),
      // ),
      body: pageChildren[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(CustomIcon.edit),
            label: '기록',
            backgroundColor: Colors.lightGreen,
          ),
          BottomNavigationBarItem(
            icon: Icon(CustomIcon.chartBar),
            label: '분석',
            backgroundColor: Colors.lightGreen,
          ),
          BottomNavigationBarItem(
            icon: Icon(CustomIcon.thumbsUp),
            label: '추천',
            backgroundColor: Colors.lightGreen,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: '내 정보',
            backgroundColor: Colors.lightGreen,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: '검색 테스트',
            backgroundColor: Colors.lightGreen,
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.black,
        onTap: _onItemTapped,
        elevation: 0,
      ),
    );
  }
}
