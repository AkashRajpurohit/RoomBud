import 'package:flutter/material.dart';

class RoomieCard {
  Widget getRoomieCard(roommate) {
    print(roommate);
    return Card(
      child: ListTile(
        title: Text(roommate['name'], style: TextStyle(fontWeight: FontWeight.bold)),
        leading: CircleAvatar(
          radius: 27,
          backgroundImage: NetworkImage(roommate['profile']),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(roommate['email'], style: TextStyle(fontStyle: FontStyle.italic)),
            Text(roommate['bio'])
          ],
        ),
        isThreeLine: true,
    )
    );
  }
}
