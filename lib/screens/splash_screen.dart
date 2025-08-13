import 'package:flutter/material.dart';
import 'dart:async';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 2), () => Navigator.pushReplacementNamed(context, '/login'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Column(mainAxisSize: MainAxisSize.min, children: const [Icon(Icons.pets, size: 80, color: Colors.teal), SizedBox(height:12), Text('PetCare', style: TextStyle(fontSize:24, fontWeight: FontWeight.bold))])));
  }
}
