import 'package:flutter/material.dart';

//screens
import 'home.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final ScrollController _scrollController = ScrollController();
  bool _isKeyboardVisible = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      setState(() {
        _isKeyboardVisible = _scrollController.position.maxScrollExtent > 0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Dive in',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        controller: _isKeyboardVisible ? null : _scrollController,
        child: Padding(
          padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(
                  vertical: MediaQuery.of(context).size.height * 0.05,
                ),
                child: Image.asset(
                  'assets/images/Icons/logo.png',
                  height: MediaQuery.of(context).size.height * 0.2,
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.05,
                ),
                child: const TextField(
                  decoration: InputDecoration(
                    labelText: 'Email address',
                  ),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              Container(
                margin: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.05,
                ),
                child: const TextField(
                  decoration: InputDecoration(
                    labelText: 'Password',
                  ),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              ElevatedButton(
                onPressed: () {
                  // TODO: 로그인 로직 구현
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const HomePage()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Text(
                    'Login',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              Container(
                margin: EdgeInsets.symmetric(
                  vertical: MediaQuery.of(context).size.height * 0.01,
                ),
                height: 1.0,
                color: Colors.grey.withOpacity(0.5),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              Image.asset(
                'assets/images/Icons/google_login.png',
                height: MediaQuery.of(context).size.height *
                    0.07, // 이미지 높이를 화면 높이의 일정 비율로 설정
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              TextButton(
                onPressed: () {
                  // TODO: 가입하기 로직 구현
                },
                child: const Text('Or Sign In'),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.2),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
