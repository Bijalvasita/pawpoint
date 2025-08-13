import 'package:flutter/material.dart';
import 'package:pawpoint/services/local_storage.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String username = 'Guest';
  @override
  void initState() {
    super.initState();
    LocalStorageService.getString('username').then((v) {
      if (v != null) setState(() => username = v);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:
            AppBar(title: const Text('Profile'), backgroundColor: Colors.teal),
        body: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(children: [
              CircleAvatar(
                  radius: 40,
                  child: Text(
                      username.isNotEmpty ? username[0].toUpperCase() : 'G')),
              const SizedBox(height: 12),
              Text(username, style: const TextStyle(fontSize: 20)),
              const SizedBox(height: 12),
              ElevatedButton(
                  onPressed: () async {
                    await LocalStorageService.remove('username');
                    Navigator.pushReplacementNamed(context, '/login');
                  },
                  child: const Text('Logout'))
            ])));
  }
}
