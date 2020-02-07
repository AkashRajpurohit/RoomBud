import 'package:flutter/material.dart';

class RoomieBottomNavigation extends StatefulWidget {

  final int currentIndex;
  final Function setIndex;

  RoomieBottomNavigation({ this.currentIndex, this.setIndex});

  @override
  _RoomieBottomNavigationState createState() => _RoomieBottomNavigationState();
}

class _RoomieBottomNavigationState extends State<RoomieBottomNavigation> {

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: widget.currentIndex,
      onTap: (int index) {
        widget.setIndex(index);
      },
      backgroundColor: Theme.of(context).primaryColor,
      unselectedItemColor: Colors.grey[400],
      selectedItemColor: Colors.white,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.map),
          title: Text("Discover")
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.nature_people),
          title: Text("Find Roommate")
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          title: Text("Profile")
        ),
      ],
    );
  }
}