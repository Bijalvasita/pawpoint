import 'package:flutter/material.dart';
import 'package:pawpoint/services/local_storage.dart';

import 'adoption_detail_screen.dart';
import 'adoption_edit_screen.dart';

class AdoptionListScreen extends StatefulWidget {
  const AdoptionListScreen({Key? key}) : super(key: key);

  @override
  State<AdoptionListScreen> createState() => _AdoptionListScreenState();
}

class _AdoptionListScreenState extends State<AdoptionListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          AppBar(title: const Text("Adoptions"), backgroundColor: Colors.teal),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.teal,
        child: const Icon(Icons.add),
        onPressed: () => Navigator.pushNamed(context, '/add_adoption')
            .then((_) => setState(() {})),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: LocalStorageService.getList('adoption_list'),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting)
            return const Center(child: CircularProgressIndicator());
          final items = snapshot.data ?? [];
          if (items.isEmpty)
            return const Center(child: Text("No adoptions yet."));
          return ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: items.length,
            itemBuilder: (context, index) {
              final item = items[index];
              return Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                child: ListTile(
                  title: Text(item['petName'] ?? ""),
                  subtitle: Text(item['breed'] ?? ""),
                  trailing: Wrap(spacing: 8, children: [
                    IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => AdoptionEditScreen(
                                        adoption: item, index: index)))
                            .then((_) => setState(() {}))),
                    IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () async {
                          items.removeAt(index);
                          await LocalStorageService.updateList(
                              'adoption_list', items);
                          setState(() {});
                        }),
                  ]),
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) =>
                              AdoptionDetailScreen(adoption: item))),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
