import 'package:flutter/material.dart';

class FaqScreen extends StatelessWidget {
  const FaqScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final faqs = [
      {'q': 'How to adopt a pet?', 'a': 'Add an adoption and contact the shelter.'},
      {'q': 'How to add my pet?', 'a': 'Use Add Pet screen to add your pet.'},
    ];
    return Scaffold(
      appBar: AppBar(title: const Text('FAQ'), backgroundColor: Colors.teal),
      body: ListView.builder(itemCount: faqs.length, padding: const EdgeInsets.all(12), itemBuilder: (c,i){
        return Card(child: ExpansionTile(title: Text(faqs[i]['q']!), children: [Padding(padding: const EdgeInsets.all(12), child: Text(faqs[i]['a']!))]));
      }),
    );
  }
}
