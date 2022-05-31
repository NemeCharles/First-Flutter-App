import 'package:bitcoin_ticker_flutter/price_screen.dart';
import 'package:flutter/material.dart';
import 'package:bitcoin_ticker_flutter/price_screen_ios.dart';
import 'dart:io' show Platform;

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: Platform.isIOS ? const PriceScreenIOS() : const PriceScreen(),
    );
  }
  }