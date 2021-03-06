import 'package:flutter/material.dart';
import 'package:renda_machine/pages/home.dart';

void main() {
  runApp(MyApp());
}

final RouteObserver<PageRoute> routeObserver = new RouteObserver<PageRoute>();

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
      navigatorObservers: <NavigatorObserver>[routeObserver],
    );
  }
}
