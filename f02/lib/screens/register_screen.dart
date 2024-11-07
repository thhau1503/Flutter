import 'package:flutter/material.dart';
import 'package:f02/services/auth_service.dart';
import 'package:f02/screens/otp_screen.dart'; 

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _authService = AuthService();
  
  String username = '';
  String email = '';
  String password = '';
  String phone = '';
  String address = '';
  bool isLoading = false;

  Future<void> _register() async {
    if (_formKey.currentState!.validate()) {
      setState(() => isLoading = true);
      
      try {
        final response = await _authService.register(
          username: username,
          email: email,
          password: password,
          phone: phone,
          address: address,
        );
        
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => OtpScreen(email: email),
          ),
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
      appBar: AppBar(title: Text('Register')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Username'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter username';
                  }
                  return null;
                },
                onChanged: (value) => username = value,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Email'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter email';
                  }
                  return null;
                },
                onChanged: (value) => email = value,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Password'),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter password';
                  }
                  return null;
                },
                onChanged: (value) => password = value,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Phone'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter phone number';
                  }
                  return null;
                },
                onChanged: (value) => phone = value,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Address'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter address';
                  }
                  return null;
                },
                onChanged: (value) => address = value,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: isLoading ? null : _register,
                child: isLoading
                    ? CircularProgressIndicator()
                    : Text('Register'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}