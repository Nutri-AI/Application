import 'package:demo/MainScreens/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:demo/custom_icon.dart';
import 'package:demo/MainScreens/food_log.dart';
import 'package:demo/MainScreens/analyze.dart';
import 'package:demo/MainScreens/recommend.dart';
import 'package:demo/MainScreens/mypage.dart';
// import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  String email;
  HomePage({Key? key, required this.email}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.black);

  final List<Widget> _children = [FoodLog(), Analyze(), Recommend(), MyPage()];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(DateFormat("MM-dd").format(DateTime.now())),
      // ),
      body: _children[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(CustomIcon.edit),
            label: '기록',
            backgroundColor: Colors.lightGreen,
          ),
          BottomNavigationBarItem(
            icon: Icon(CustomIcon.chart_bar),
            label: '분석',
            backgroundColor: Colors.lightGreen,
          ),
          BottomNavigationBarItem(
            icon: Icon(CustomIcon.thumbs_up),
            label: '추천',
            backgroundColor: Colors.lightGreen,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: '내 정보',
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
