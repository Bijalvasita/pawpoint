import 'package:flutter/material.dart';
import 'package:pawpoint/services/local_storage.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({Key? key}) : super(key: key);

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  String name = 'Guest';
  @override
  void initState() {
    super.initState();
    LocalStorageService.getString('username').then((v) {
      if (v != null) setState(() => name = v);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text('User Profile'), backgroundColor: Colors.teal),
        body: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(children: [
              CircleAvatar(
                  radius: 40,
                  child: Text(name.isNotEmpty ? name[0].toUpperCase() : 'G')),
              const SizedBox(height: 12),
              Text(name, style: const TextStyle(fontSize: 20)),
              const SizedBox(height: 12),
              ElevatedButton(
                  onPressed: () => Navigator.pushNamed(context, '/settings'),
                  child: const Text('Settings'))
            ])));
  }
}
