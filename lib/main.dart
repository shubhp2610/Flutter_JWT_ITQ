import 'package:flutter/material.dart';

import './screen_a.dart';
import './screen_b.dart';
import './screen_c.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      // Hide the debug banner
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedScreenIndex = 0;
  final List _screens = [
    {"screen": const ScreenA(), "title": "JWT @ ITQ - Generator"},
    {"screen": const ScreenB(), "title": "JWT @ ITQ - Session Validator"},
    {"screen": const ScreenC(), "title": "JWT @ ITQ - User Validator"},
  ];

  void _selectScreen(int index) {
    setState(() {
      _selectedScreenIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_screens[_selectedScreenIndex]["title"]),
      ),
      body: _screens[_selectedScreenIndex]["screen"],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedScreenIndex,
        onTap: _selectScreen,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: "Generator"),
          BottomNavigationBarItem(icon: Icon(Icons.check_circle), label: 'Session Validator'),
          BottomNavigationBarItem(icon: Icon(Icons.account_box), label: 'User Validator')
        ],
      ),
    );
  }
}