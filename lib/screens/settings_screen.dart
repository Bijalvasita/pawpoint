import 'package:flutter/material.dart';
import 'package:pawpoint/services/local_storage.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool darkMode = false;

  @override
  void initState() {
    super.initState();
    LocalStorageService.getString('theme').then((v) {
      if (v == 'dark') setState(() => darkMode = true);
    });
  }

  Future<void> _toggle(bool val) async {
    setState(() => darkMode = val);
    await LocalStorageService.saveString('theme', val ? 'dark' : 'light');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:
            AppBar(title: const Text('Settings'), backgroundColor: Colors.teal),
        body: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(children: [
              SwitchListTile(
                  value: darkMode,
                  onChanged: _toggle,
                  title: const Text('Dark Mode')),
              ListTile(
                  title: const Text('Privacy Policy'),
                  onTap: () => Navigator.pushNamed(context, '/privacy'))
            ])));
  }
}
