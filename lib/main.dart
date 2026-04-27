import 'package:flutter/material.dart';
import 'pages/linterna_page.dart';

void main() {
  runApp(const LinternaApp());
}

class LinternaApp extends StatelessWidget {
  const LinternaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LinternaPage(),
    );
  }
}
