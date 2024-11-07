import 'package:flutter/material.dart';
import 'package:f02/screens/login_screen.dart'; 
import 'package:f02/services/token_service.dart'; 
import 'package:f02/services/auth_service.dart'; 
import 'package:f02/models/user.dart'; 
class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _tokenService = TokenService();
  final _authService = AuthService();
  User? currentUser;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    setState(() => isLoading = true);
    try {
      // Giả sử bạn có API để lấy thông tin user
      final token = await _tokenService.getToken();
      if (token != null) {
        // Thực hiện call API get user info ở đây
        // currentUser = await _authService.getUserInfo(token);
        // Tạm thời dùng dữ liệu mẫu
        currentUser = User(
          username: "John Doe",
          email: "john@example.com",
          phone: "0123456789",
          address: "123 Street, City",
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to load user data')),
      );
    } finally {
      setState(() => isLoading = false);
    }
  }

  Future<void> _logout() async {
    try {
      await _tokenService.deleteToken();
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
        (route) => false,
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Logout failed')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: _logout,
          ),
        ],
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Card(
                    elevation: 4,
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Profile Information',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 20),
                          ListTile(
                            leading: Icon(Icons.person),
                            title: Text('Username'),
                            subtitle: Text(currentUser?.username ?? ''),
                          ),
                          ListTile(
                            leading: Icon(Icons.email),
                            title: Text('Email'),
                            subtitle: Text(currentUser?.email ?? ''),
                          ),
                          ListTile(
                            leading: Icon(Icons.phone),
                            title: Text('Phone'),
                            subtitle: Text(currentUser?.phone ?? ''),
                          ),
                          ListTile(
                            leading: Icon(Icons.location_on),
                            title: Text('Address'),
                            subtitle: Text(currentUser?.address ?? ''),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Card(
                    elevation: 4,
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Quick Actions',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              _buildQuickActionButton(
                                icon: Icons.edit,
                                label: 'Edit Profile',
                                onPressed: () {
                                  // Navigate to edit profile screen
                                },
                              ),
                              _buildQuickActionButton(
                                icon: Icons.security,
                                label: 'Change Password',
                                onPressed: () {
                                  // Navigate to change password screen
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Widget _buildQuickActionButton({
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            shape: CircleBorder(),
            padding: EdgeInsets.all(20),
          ),
          child: Icon(icon, size: 30),
        ),
        SizedBox(height: 8),
        Text(label),
      ],
    );
  }
}