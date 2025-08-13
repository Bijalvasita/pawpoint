import 'package:flutter/material.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: const Text('Privacy Policy'), backgroundColor: Colors.teal), body: Padding(padding: const EdgeInsets.all(16), child: SingleChildScrollView(child: Text('This is a sample privacy policy. Replace with real policy for production.', style: TextStyle(fontSize:16)))));
  }
}
