import 'package:flutter/material.dart';
import 'package:demo/custom_icon.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.black);
  static const List<Widget> _widgetOptions = <Widget>[
    // Tab_0: MakeLog()
    Text(
      'Index 0: 기록!',
      style: optionStyle,
    ),
    // Tab_1: Analyze()
    Text(
      'Index 1: 분석',
      style: optionStyle,
    ),
    // Tab_2: Recommendation()
    Text(
      'Index 2: 추천',
      style: optionStyle,
    ),
    // Tab_3: UserInfo()
    Text(
      'Index 3: 마이페이지',
      style: optionStyle,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("식단 로그를 입력하세요!")),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
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
