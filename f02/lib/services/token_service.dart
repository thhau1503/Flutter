import 'package:shared_preferences/shared_preferences.dart';

class TokenService {
  static const String TOKEN_KEY = 'jwt_teyJhbGciOiJIUzI1NiJ9.eyJSb2xlIjoiQWRtaW4iLCJJc3N1ZXIiOiJJc3N1ZXIiLCJVc2VybmFtZSI6IkphdmFJblVzZSIsImV4cCI6MTczMDkxMzg1NiwiaWF0IjoxNzMwOTEzODU2fQ.8b3GWr-RfSOdxsYPHQ1Kt7c_0I9-OH_AkaKOHxfkNRQoken';
  
  Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(TOKEN_KEY, token);
  }

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(TOKEN_KEY);
  }

  Future<void> deleteToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(TOKEN_KEY);
  }
}