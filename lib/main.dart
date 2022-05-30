import 'package:bitcoin_ticker_flutter/price_screen.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
        //   .copyWith(
        // appBarTheme: const AppBarTheme(
        //   backgroundColor: Colors.lightBlue,
        // ),
        //   primaryColor: Colors.lightBlue,
        //   scaffoldBackgroundColor: Colors.white),
      home: const PriceScreen(),
    );
  }
  }