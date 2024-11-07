import 'package:flutter/material.dart';
import 'package:f02/services/auth_service.dart';
import 'package:f02/screens/reset_password_otp_screen.dart';

class ForgotPasswordScreen extends StatefulWidget {
  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _authService = AuthService();
  
  String email = '';
  bool isLoading = false;

  Future<void> _sendResetLink() async {
    if (_formKey.currentState!.validate()) {
      setState(() => isLoading = true);
      
      try {
        final response = await _authService.forgotPassword(email: email);
        
        if (response.statusCode == 200) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ResetPasswordOtpScreen(email: email),
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to send reset link')),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      } finally {
        setState(() => isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Forgot Password')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Email'),
                onChanged: (value) => email = value,
                validator: (value) => value!.isEmpty ? 'Please enter your email' : null,
              ),
              SizedBox(height: 20),
              isLoading
                  ? CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: _sendResetLink,
                      child: Text('Send Reset Link'),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}