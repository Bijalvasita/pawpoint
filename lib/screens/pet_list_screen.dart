import 'package:flutter/material.dart';
import 'package:pawpoint/services/local_storage.dart';

import 'pet_detail_screen.dart';
import 'pet_edit_screen.dart';

class PetListScreen extends StatefulWidget {
  const PetListScreen({Key? key}) : super(key: key);

  @override
  State<PetListScreen> createState() => _PetListScreenState();
}

class _PetListScreenState extends State<PetListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Pets"), backgroundColor: Colors.teal),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.teal,
          child: const Icon(Icons.add),
          onPressed: () => Navigator.pushNamed(context, '/add_pet')
              .then((_) => setState(() {}))),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: LocalStorageService.getList('pet_list'),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting)
            return const Center(child: CircularProgressIndicator());
          final items = snapshot.data ?? [];
          if (items.isEmpty) return const Center(child: Text("No pets yet."));
          return ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index];
                return Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    child: ListTile(
                        title: Text(item['name'] ?? ''),
                        subtitle: Text(item['type'] ?? ''),
                        trailing: Wrap(spacing: 8, children: [
                          IconButton(
                              icon: const Icon(Icons.edit),
                              onPressed: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => PetEditScreen(
                                              pet: item, index: index)))
                                  .then((_) => setState(() {}))),
                          IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () async {
                                items.removeAt(index);
                                await LocalStorageService.updateList(
                                    'pet_list', items);
                                setState(() {});
                              })
                        ]),
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => PetDetailScreen(pet: item)))));
              });
        },
      ),
    );
  }
}
