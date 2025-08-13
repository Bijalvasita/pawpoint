import 'package:flutter/material.dart';
import 'package:pawpoint/services/local_storage.dart';

class PetEditScreen extends StatefulWidget {
  final Map<String, dynamic> pet;
  final int index;
  const PetEditScreen({Key? key, required this.pet, required this.index})
      : super(key: key);

  @override
  State<PetEditScreen> createState() => _PetEditScreenState();
}

class _PetEditScreenState extends State<PetEditScreen> {
  late TextEditingController nameController;
  late TextEditingController typeController;
  late TextEditingController ageController;
  late TextEditingController notesController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.pet['name'] ?? '');
    typeController = TextEditingController(text: widget.pet['type'] ?? '');
    ageController = TextEditingController(text: widget.pet['age'] ?? '');
    notesController = TextEditingController(text: widget.pet['notes'] ?? '');
  }

  Future<void> _save() async {
    final items = await LocalStorageService.getList('pet_list');
    items[widget.index] = {
      "name": nameController.text,
      "type": typeController.text,
      "age": ageController.text,
      "notes": notesController.text,
      "dateAdded":
          items[widget.index]['dateAdded'] ?? DateTime.now().toIso8601String(),
    };
    await LocalStorageService.updateList('pet_list', items);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:
            AppBar(title: const Text('Edit Pet'), backgroundColor: Colors.teal),
        body: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(children: [
              TextField(
                  controller: nameController,
                  decoration: const InputDecoration(
                      labelText: 'Name', border: OutlineInputBorder())),
              const SizedBox(height: 12),
              TextField(
                  controller: typeController,
                  decoration: const InputDecoration(
                      labelText: 'Type', border: OutlineInputBorder())),
              const SizedBox(height: 12),
              TextField(
                  controller: ageController,
                  decoration: const InputDecoration(
                      labelText: 'Age', border: OutlineInputBorder())),
              const SizedBox(height: 12),
              TextField(
                  controller: notesController,
                  maxLines: 3,
                  decoration: const InputDecoration(
                      labelText: 'Notes', border: OutlineInputBorder())),
              const SizedBox(height: 12),
              ElevatedButton(onPressed: _save, child: const Text('Save'))
            ])));
  }
}
