import 'package:flutter/material.dart';
import 'package:roombud/screens/roomie/discover/room_card.dart';
import 'package:roombud/screens/roomie/shared/search_bar.dart';

class RoomieDiscover extends StatefulWidget {
  @override
  _RoomieDiscoverState createState() => _RoomieDiscoverState();
}

class _RoomieDiscoverState extends State<RoomieDiscover> {
  List<dynamic> rooms;
  bool isLoading = false;

  void addData(List<dynamic> data) {
    setState(() {
      rooms = data;
      print(rooms);
    });
  }

  void toggleIsLoading() {
    setState(() {
      isLoading = !isLoading;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned(
          top: 30,
          left: MediaQuery.of(context).size.width * 0.05,
          child: SearchRoomBar(setData: addData, toggleIsLoading: toggleIsLoading),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(25.0, 120.0, 25.0, 10.0),
          child: isLoading 
            ? Center(
              child: CircularProgressIndicator(backgroundColor: Colors.white),
            )
            : Container(
              width: MediaQuery.of(context).size.width,
              child: rooms == null
                  ? Text("Search your room now")
                  : rooms.length == 0
                      // ? SvgPicture.asset('assets/images/empty.svg')
                      ? Text("No results")
                      : ListView.builder(
                          itemCount: rooms.length,
                          itemBuilder: (BuildContext context, int index) {
                            return RoomCard().getRoomCard(rooms[index]);
                          },
                        )),
        )
      ],
    );
  }
}
