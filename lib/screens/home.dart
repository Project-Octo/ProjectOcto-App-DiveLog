import 'package:flutter/material.dart';

//screens
import 'add_page.dart';
import 'dives_page.dart';
import 'animals_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  late String _appBarTitle; // AppBar 제목을 저장할 변수 추가

  final List<Widget> _pages = [
    const DivesPage(),
    AnimalsPage(),
  ];

  @override
  void initState() {
    super.initState();
    _appBarTitle = 'Dives'; // 초기 제목 설정
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_appBarTitle),
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
            // 바텀 네비게이션 아이템에 따라 AppBar 제목 변경
            _appBarTitle = index == 0 ? 'Dives' : 'Animals';
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.water),
            label: 'Dives',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.set_meal),
            label: 'Animals',
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddPage()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
