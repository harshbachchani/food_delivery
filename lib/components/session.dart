import 'package:shared_preferences/shared_preferences.dart';

class SessionManager {
  static const String _isloggedinkey = 'isLoggedIn';
  static const String _uidkey = 'UID';
  static const String _latitudekey = 'latitude';
  static const String _longitudekey = 'longitude';
  static const String _citykey = 'city';
  static const String _addressinkey = 'address';

  static Future<void> setLoggedIn(bool isLoggedIn, String uid) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setBool(_isloggedinkey, isLoggedIn);
    await pref.setString(_uidkey, uid);
  }

  static Future<Map<String, dynamic>> isLoggedIn() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    bool isLoggedIn = pref.getBool(_isloggedinkey) ?? false;
    String uid = pref.getString(_uidkey) ?? "";
    return {'loggedin': isLoggedIn, 'uid': uid};
  }

  static Future<void> saveLocation(
      double latitude, double longitude, String city, String address) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setDouble(_latitudekey, latitude);
    await prefs.setDouble(_longitudekey, longitude);
    await prefs.setString(_addressinkey, address);
    await prefs.setString(_citykey, city);
  }

  static Future<Map<String, dynamic>> getLocation() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    double latitude = prefs.getDouble(_latitudekey) ?? 24.5854;
    double longitude = prefs.getDouble(_longitudekey) ?? 73.7125;
    String address = prefs.getString(_addressinkey) ??
        "NSCB HOSTEL,CTAE COLLEGE,UNIVERYSITY ROAD,UDAIPUR";
    String city = prefs.getString(_citykey) ?? "Udaipur";
    return {
      'latitude': latitude,
      'longitude': longitude,
      'address': address,
      'city': city
    };
  }

  static Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
