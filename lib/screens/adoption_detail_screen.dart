import 'package:flutter/material.dart';

class AdoptionDetailScreen extends StatelessWidget {
  final Map<String, dynamic> adoption;
  const AdoptionDetailScreen({Key? key, required this.adoption}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Adoption Details"), backgroundColor: Colors.teal),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(adoption['petName'] ?? "", style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Text("Breed: \${adoption['breed'] ?? ''}"),
              const SizedBox(height: 8),
              Text("Age: \${adoption['age'] ?? ''}"),
              const SizedBox(height: 12),
              Text(adoption['description'] ?? ""),
            ]),
          ),
        ),
      ),
    );
  }
}
