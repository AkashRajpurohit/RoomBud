import 'package:flutter/material.dart';

class RoomCard {
  final TextStyle myStyle = TextStyle(color: Colors.black);

  Widget getRoomCard(room) {
    return Card(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            width: 600,
            height: 250,
            decoration: BoxDecoration(
              image: DecorationImage(image: NetworkImage(room['photos'])),
            ),
          ),
          Text(room['description'],
              style: myStyle.copyWith(fontWeight: FontWeight.bold)),
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            Row(children: [
              Icon(Icons.people),
              SizedBox(width: 8.0),
              Text("${room['capacity']}",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 20.0))
            ]),
            Padding(
                padding: EdgeInsets.all(10.0),
                child: Text("Rs. ${room['cost']} / mo",
                    style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.purple)))
          ]),
        ],
      ),
    );
  }
}
