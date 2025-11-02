import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  static late SharedPreferences pref;

  static const String konBoarding = "onBoarding";

  static init() async {
    pref = await SharedPreferences.getInstance();
  }

  static isonBoardigSeen() async {
    await pref.setBool(konBoarding, true);
  }

  static bool getisBoardingSeen() {
    return pref.getBool(konBoarding) ?? false;
  }
}
