import 'package:flutter/material.dart';
import 'main_page.dart';

void main() => runApp(const BitcoinTickerApp());

class BitcoinTickerApp extends StatelessWidget {
  const BitcoinTickerApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MainPage(),
    );
  }
}
