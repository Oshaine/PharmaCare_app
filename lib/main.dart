import 'package:flutter/material.dart';
import 'package:pharmacare_app/routes.dart';
import 'package:pharmacare_app/screens/splash/splash_screen.dart';
import 'package:pharmacare_app/theme.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'PharmaCare App',
      theme: theme(),
      home: SplashScreen(),
      initialRoute: SplashScreen.routeName,
      routes: routes,
    );
  }
}
