import 'dart:convert';

import 'package:http/http.dart';

class HttpService {

  String _baseURL = 'http://192.168.0.193:5000';
  // getRoommates/:uid
  // getRooms/:uid
  Future<List<dynamic>> getRooms({ String uid, Map<String, double> coords }) async {

    Map data = {
      'coordinates': coords
    };

    var body = json.encode(data);

    Response response = await post(
      '$_baseURL/getRooms/$uid',
      headers: {
        "Content-Type": "application/json"
      },
      body: body
    );

    Iterable list = json.decode(response.body);

    var result = list.toList();
    
    return result;
  }

  Future getRoommates({ String uid, Map<String, double> coords }) async {

    Map data = {
      'coordinates': coords
    };

    var body = json.encode(data);

    Response response = await post(
      '$_baseURL/getRoommates/$uid',
      headers: {
        "Content-Type": "application/json"
      },
      body: body
    );

    Iterable list = json.decode(response.body);

    var result = list.toList();
    
    return result;
  }

}