import 'package:flutter/material.dart';
import 'package:roombud/utils/routes.dart';

import 'auth_wrapper.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Roombud',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.purple,
        scaffoldBackgroundColor: Color(0xff5321ad),
        textTheme: TextTheme(
          body1: TextStyle(
            color: Colors.white
          )
        )
      ),
      home: AuthWrapper(),
      routes: Routes.routes
    );
  }
}