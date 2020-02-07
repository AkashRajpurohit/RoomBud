import "package:shared_preferences/shared_preferences.dart";

Future<bool> getVisitingFlag() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  bool visitFlag = preferences.getBool('first_visit') ?? false;
  return visitFlag;
}
  
setVisitingFlag() async{
  SharedPreferences preferences = await SharedPreferences.getInstance();
  preferences.setBool('first_visit', true);
}

