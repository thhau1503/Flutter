import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService {
  static const String baseUrl = 'https://be-android-project.onrender.com/api/auth';

  Future<http.Response> register({
    required String username,
    required String email,
    required String password,
    required String phone,
    required String address,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/register'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String> {
          'username': username,
          'email': email,
          'password': password,
          'phone': phone,
          'address': address,
        }),
      );

      return response;
    } catch (e) {
      throw Exception('Registration failed');
    }
  }

  Future<http.Response> verifyOtp({
    required String email,
    required String otp,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('https://be-android-project.onrender.com/api/auth/verify-otp'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String> {
          'email': email,
          'otp': otp,
        }),
      );

      return jsonDecode(response.body);
    } catch (e) {
      throw Exception('OTP verification failed');
    }
  }

  Future<http.Response> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('https://be-android-project.onrender.com/api/auth/login'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String> {
          'email': email,
          'password': password,
        }),
      );

      return response;
    } catch (e) {
      throw Exception('Login failed');
    }
  }

  Future<http.Response> forgotPassword({
    required String email,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('https://be-android-project.onrender.com/api/auth/forgot-password'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String,String> {
          'email': email,
        }),
      );

      return response;
    } catch (e) {
      throw Exception('Forgot password request failed');
    }
  }

  Future<http.Response> resetPassword({
    required String email,
    required String otp,
    required String newPassword,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/reset-password'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String> {
          'email': email,
          'otp': otp,
          'new_password': newPassword,
        }),
      );

      return jsonDecode(response.body);
    } catch (e) {
      throw Exception('Password reset failed');
    }
  }
}