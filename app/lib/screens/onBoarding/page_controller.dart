import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'pages.dart';


class OnBoarding extends StatelessWidget {

  static String route = 'welcome'; 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IntroductionScreen(
        globalBackgroundColor: Color(0xff5321ad),
        pages: Pages().getPages(),
        done: Text(
          'Done',
          style: TextStyle(
            color: Colors.white
          ),
        ),
        onDone: (){
          Navigator.pushNamed(
            context,
            '/'
          );
        },
      ),
    );
  }
}
