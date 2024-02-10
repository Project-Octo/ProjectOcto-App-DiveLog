import 'package:flutter/material.dart';

//screens
import 'home.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Dive in',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(top: 35, bottom: 45),
              child: Image.asset('assets/images/Icons/logo.png', height: 250),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16.0),
              child: const TextField(
                decoration: InputDecoration(
                  labelText: 'Email address',
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16.0),
              child: const TextField(
                decoration: InputDecoration(
                  labelText: 'Password',
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                // TODO: 로그인 로직 구현
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage()),
                );
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.blue, // 버튼의 배경색
                onPrimary: Colors.white, // 텍스트 색상
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0), // 버튼 모서리의 곡률 정도
                ),
              ),
              child: const Text(
                'Login',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              height: 1.0,
              color: Colors.grey.withOpacity(0.5),
            ),
            const SizedBox(height: 16.0),
            Image.asset(
              'assets/images/Icons/google_login.png',
              width: 200.0,
            ),
            const SizedBox(height: 16.0),
            TextButton(
              onPressed: () {
                // TODO: 가입하기 로직 구현
              },
              child: const Text('Or Sign In'),
            ),
          ],
        ),
      ),
    );
  }
}
