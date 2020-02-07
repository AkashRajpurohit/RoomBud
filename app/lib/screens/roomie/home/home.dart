import 'package:flutter/material.dart';
import 'package:roombud/screens/roomie/discover/discover.dart';
import 'package:roombud/screens/roomie/find_roomie/find_roomie.dart';
import 'package:roombud/screens/roomie/profile/profile.dart';
import 'package:roombud/screens/roomie/shared/bottom_navigation.dart';

class RoomieHome extends StatefulWidget {
  @override
  _RoomieHomeState createState() => _RoomieHomeState();
}

class _RoomieHomeState extends State<RoomieHome> {
  int _currentIndex = 0;

  void setIndex(int index) {
    setState(() => _currentIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: SafeArea(
        child: IndexedStack(
          index: _currentIndex,
          children: <Widget>[
            RoomieDiscover(),
            FindRoomie(),
            RoomieProfile()
          ],
        )
      ),
      bottomNavigationBar: RoomieBottomNavigation(currentIndex: _currentIndex, setIndex: setIndex),
    );
  }
}