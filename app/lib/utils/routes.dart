import 'package:flutter/material.dart';
import 'package:roombud/auth_wrapper.dart';
import 'package:roombud/screens/roomie/discover/discover.dart';
import 'package:roombud/screens/roomie/find_roomie/find_roomie.dart';
import 'package:roombud/screens/roomie/home/home.dart';
import 'package:roombud/screens/roomie/profile/profile.dart';
import 'package:roombud/screens/roomie/profile/profile_form.dart';
import 'package:roombud/screens/roomie/profile/profile_type.dart';
import 'package:roombud/screens/tenant/home.dart';

class Routes {
  static final Map<String, WidgetBuilder> routes = {
    '/discover': (context) => RoomieDiscover(),
    '/profile': (context) => RoomieProfile(),
    '/find-roomie': (context) => FindRoomie(),
    '/user-type': (context) => ProfileType(),
    '/auth': (context) => AuthWrapper(),
    '/roomie': (context) => RoomieHome(),
    '/tenant': (context) => TenantHome(),
    '/update-profile': (context) => ProfileForm()
  };
}
