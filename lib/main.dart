import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:octo_app/screens/auth_gate.dart';
import 'package:octo_app/screens/onboarding/auth.dart';
import 'firebase_options.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:octo_app/screens/animals_page.dart';

final theme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    seedColor: const Color(0xFF0077C8),
    primary: const Color(0xFF0077C8),
    secondary: const Color(0xFFF4F8FB),
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
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: theme,
      // home: const AuthGate(),
      home: AnimalsPage(),
    );
  }
}
