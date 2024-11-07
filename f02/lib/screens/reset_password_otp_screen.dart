import 'package:flutter/material.dart';
import 'package:f02/services/auth_service.dart';
import 'package:f02/screens/login_screen.dart'; 
class ResetPasswordOtpScreen extends StatefulWidget {
  final String email;

  ResetPasswordOtpScreen({required this.email});

  @override
  _ResetPasswordOtpScreenState createState() => _ResetPasswordOtpScreenState();
}

class _ResetPasswordOtpScreenState extends State<ResetPasswordOtpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _authService = AuthService();
  
  String otp = '';
  String newPassword = '';
  bool isLoading = false;

  Future<void> _resetPassword() async {
    if (_formKey.currentState!.validate()) {
      setState(() => isLoading = true);
      
      try {
        final response = await _authService.resetPassword(
          email: widget.email,
          otp: otp,
          newPassword: newPassword,
        );
        
        // Navigate to login screen after successful reset
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => LoginScreen()),
          (route) => false,
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString())),
        );
      } finally {
        setState(() => isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Reset Password')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Enter OTP sent to ${widget.email}'),
              SizedBox(height: 20),
              TextFormField(
                decoration: InputDecoration(labelText: 'OTP'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter OTP';
                  }
                  return null;
                },
                onChanged: (value) => otp = value,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'New Password'),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter new password';
                  }
                  return null;
                },
                onChanged: (value) => newPassword = value,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: isLoading ? null : _resetPassword,
                child: isLoading
                    ? CircularProgressIndicator()
                    : Text('Reset Password'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}