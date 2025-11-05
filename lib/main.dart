import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tugas_akhir/Screens/home.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(TugasAkhirApp());
}

class TugasAkhirApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);

    return MaterialApp(
      title: 'School Management System',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.green,
          elevation: 0,
        ),
        cardTheme: CardThemeData(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
      // Langsung ke Dashboard - NO LOGIN
      home: Home(),
    );
  }
}

