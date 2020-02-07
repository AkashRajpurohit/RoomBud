import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:flutter_svg/flutter_svg.dart';


class Pages{
  
  final PageDecoration _pageDecoration = PageDecoration(
  
      titleTextStyle: TextStyle(
          color: Colors.white, 
          fontSize: 30.0, 
          fontWeight: FontWeight.bold
      ),
      
      bodyTextStyle: TextStyle(
          color: Colors.white, 
          fontSize: 20.0
      )
  );


  List<PageViewModel> getPages() {
    return [
      PageViewModel(
          title: 'Find your perfect room',
          body: 'by location, preference, price...',
          image: Center(child: Container(
              margin: EdgeInsets.only(top:150.0),
              child: SvgPicture.asset('assets/images/locate.svg')
          )),
          decoration: _pageDecoration
      ),
      
      PageViewModel(
          title: 'Set your preferences',
          body: 'to find the ideal results',
          image:  Container(
              margin: EdgeInsets.only(top:150.0),
              child: SvgPicture.asset('assets/images/preference.svg')
          ),
          decoration: _pageDecoration
      ),

      PageViewModel(
          title: 'Find a roomate',
          body: 'to share the expenses...',
          image:  Container(
              margin: EdgeInsets.only(top:150.0, left: 30.0, right:30.0),
              child: SvgPicture.asset('assets/images/find_roomie.svg')
          ),
          decoration: _pageDecoration
      )
    ];
  }
}
