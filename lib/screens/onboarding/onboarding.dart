import 'package:flutter/material.dart';

class OnboardingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Onboarding Screen'),
      ),
      body: Center(
        child: Text(
          'Welcome to the Onboarding Screen!',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
