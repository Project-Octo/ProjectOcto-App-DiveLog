import 'package:flutter/material.dart';

//screens
import 'add_page.dart';
import 'dives_page.dart'; // dives_page.dart 파일을 import

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0; // 현재 선택된 탭 인덱스

  final List<Widget> _pages = [
    const DivesPage(), // DivesPage 위젯을 사용
    const AnimalsPage(),
  ]; // 탭 페이지 목록

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            // 뒤로 가기 버튼 동작
          },
        ),
        // title: const Center(
        //   child: Text('Home'),
        // ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
          const CircleAvatar(
            backgroundImage: AssetImage('assets/images/profile_image.png'),
          ),
          const SizedBox(width: 10)
        ],
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
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
          // TODO: 로그인 로직 구현
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddPage()),
          );

          // 기록 추가 버튼 동작
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class AnimalsPage extends StatelessWidget {
  const AnimalsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Animals Page'),
    );
  }
}
