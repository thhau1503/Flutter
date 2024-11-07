import 'package:flutter/material.dart';
import 'package:f02/services/auth_service.dart';
import 'package:f02/screens/login_screen.dart';
class OtpScreen extends StatefulWidget {
  final String email;

  OtpScreen({required this.email});

  @override
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _authService = AuthService();
  
  String otp = '';
  bool isLoading = false;

  Future<void> _verifyOtp() async {
    if (_formKey.currentState!.validate()) {
      setState(() => isLoading = true);
      
      try {
        final response = await _authService.verifyOtp(
          email: widget.email,
          otp: otp,
        );
        
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
      appBar: AppBar(title: Text('Verify OTP')),
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
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: isLoading ? null : _verifyOtp,
                child: isLoading
                    ? CircularProgressIndicator()
                    : Text('Verify OTP'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}