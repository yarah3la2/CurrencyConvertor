import 'package:currency_converter/ui/CurrencyConvertorScreen.dart';
import 'package:currency_converter/utilities/AppConstants.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: TEXT_CONST_CURRENCY_APPBAR_TITLE,
        initialRoute: '/',
        routes: {
          '/': (context) => CurrencyConvertorScreen(),
        }
    );
  }
}

