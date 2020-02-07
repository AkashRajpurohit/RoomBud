import 'package:flutter/material.dart';
import 'package:roombud/screens/roomie/find_roomie/find_roomie_card.dart';
import 'package:roombud/screens/roomie/shared/search_roomie_bar.dart';

class FindRoomie extends StatefulWidget {
  @override
  _FindRoomieState createState() => _FindRoomieState();
}

class _FindRoomieState extends State<FindRoomie> {
  List<dynamic> roommates;
  bool isLoading = false;

  void addData(List<dynamic> data) {
    setState(() {
      roommates = data;
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
          child: SearchRoomieBar(setData: addData, toggleIsLoading: toggleIsLoading),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(25.0, 120.0, 25.0, 10.0),
          child: isLoading 
            ? Center(
              child: CircularProgressIndicator(backgroundColor: Colors.white),
            )
            : Container(
              width: MediaQuery.of(context).size.width,
              child: roommates == null
                  ? Text("Search your roomies now")
                  : roommates.length == 0
                      ? Text("No results")
                      : ListView.builder(
                          itemCount: roommates.length,
                          itemBuilder: (BuildContext context, int index) {
                            return RoomieCard().getRoomieCard(roommates[index]);
                          },
                        )),
        )
      ],
    );
  }
}
