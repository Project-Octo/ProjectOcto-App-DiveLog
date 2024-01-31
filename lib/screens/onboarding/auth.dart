import 'package:flutter/material.dart';

// Auth screen, add sign in, sign up, and login with Google buttons
class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign In'),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Welcome to the Sign In Screen!',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            // Add your sign-in form here
          ],
        ),
      ),
    );
  }
}
