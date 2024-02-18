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
  late String _appBarTitle;

  final List<Widget> _pages = [
    const DivesPage(),
    AnimalsPage(),
  ];

  @override
  void initState() {
    super.initState();
    _appBarTitle = 'Dives';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _appBarTitle,
          style: const TextStyle(
            color: Color(0xFF0077C8),
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
            _appBarTitle = index == 0 ? 'Dives' : 'Animals';
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.water),
            label: 'Dives',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
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
