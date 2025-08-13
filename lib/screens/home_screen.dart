import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final tiles = [
      {'title': 'Pets', 'route': '/pets', 'icon': Icons.pets},
      {'title': 'Adoptions', 'route': '/adoptions', 'icon': Icons.home},
      {'title': 'Add Pet', 'route': '/add_pet', 'icon': Icons.add},
      {
        'title': 'Add Adoption',
        'route': '/add_adoption',
        'icon': Icons.add_box
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: GridView.count(
          crossAxisCount: 2,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          children: tiles.map((t) {
            return GestureDetector(
              onTap: () => Navigator.pushNamed(context, t['route'] as String),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(t['icon'] as IconData, size: 48),
                      const SizedBox(height: 8),
                      Text(
                        t['title'] as String,
                        style: const TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
