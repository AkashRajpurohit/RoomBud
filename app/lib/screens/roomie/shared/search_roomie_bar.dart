import 'package:flutter/material.dart';
import 'package:roombud/services/http_service.dart';
import 'package:roombud/utils/get_lat_lng.dart';
import 'package:roombud/utils/shared_data.dart';
import 'package:search_map_place/search_map_place.dart';

class SearchRoomieBar extends StatefulWidget {
  final dynamic setData;
  final Function toggleIsLoading;

  SearchRoomieBar({ this.setData, this.toggleIsLoading });

  @override
  _SearchRoomieBarState createState() => _SearchRoomieBarState();
}

class _SearchRoomieBarState extends State<SearchRoomieBar> {
  // final String apiKey = "AIzaSyCuBxtjQhxLmqQWDzrjIQtFlHUvsfviICI";
  final String apiKey = "AIzaSyDmwbZFOM6zFZpFMOng9mZMc-UzQtXvsaU";
  final SharedData _data = SharedData();

  @override
  Widget build(BuildContext context) {
    return SearchMapPlaceWidget(
      apiKey: apiKey,
      onSelected: (Place place) async {
        Map<String,double> coords = LatLng().getLatLng();

        widget.toggleIsLoading();
        
        var uid = await _data.getDataFromSharedData("uid");

        print("Get data");
        
        List<dynamic> resp = await HttpService().getRoommates(uid: uid, coords: coords);

        print(resp);

        widget.toggleIsLoading();

        widget.setData(resp);
      },
    );
  }
}
