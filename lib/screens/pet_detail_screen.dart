import 'package:flutter/material.dart';

class PetDetailScreen extends StatelessWidget {
  final Map<String, dynamic> pet;
  const PetDetailScreen({Key? key, required this.pet}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pet Details'),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  pet['name'] ?? '',
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text('Type: ${pet['type'] ?? ''}'),
                const SizedBox(height: 8),
                Text('Age: ${pet['age'] ?? ''}'),
                const SizedBox(height: 12),
                Text(pet['notes'] ?? ''),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
