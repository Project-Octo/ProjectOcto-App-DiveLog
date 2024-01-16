import 'package:flutter/material.dart';
// Firebase
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:google_fonts/google_fonts.dart';

final theme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    seedColor: const Color(0xFF0077C8),
    // Primary blue
    primary: const Color(0xFF0077C8),
    // See figma for reference
    secondary: const Color(0xFFFCFCFD),
    tertiary: const Color(0xFF009E81),
  ).copyWith(),
  textTheme: GoogleFonts.notoSansKrTextTheme(),
).copyWith();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: theme,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Material 3 This is a test'),
        ),
        body: const Center(
          child: Text(
            'Material 3',
            style: TextStyle(fontSize: 24),
          ),
        ),
      ),
    );
  }
}
