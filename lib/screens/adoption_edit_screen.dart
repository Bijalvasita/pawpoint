import 'package:flutter/material.dart';
import 'package:pawpoint/services/local_storage.dart';

class AdoptionEditScreen extends StatefulWidget {
  final Map<String, dynamic> adoption;
  final int index;
  const AdoptionEditScreen(
      {Key? key, required this.adoption, required this.index})
      : super(key: key);

  @override
  State<AdoptionEditScreen> createState() => _AdoptionEditScreenState();
}

class _AdoptionEditScreenState extends State<AdoptionEditScreen> {
  late TextEditingController petNameController;
  late TextEditingController breedController;
  late TextEditingController ageController;
  late TextEditingController descController;

  @override
  void initState() {
    super.initState();
    petNameController =
        TextEditingController(text: widget.adoption['petName'] ?? '');
    breedController =
        TextEditingController(text: widget.adoption['breed'] ?? '');
    ageController = TextEditingController(text: widget.adoption['age'] ?? '');
    descController =
        TextEditingController(text: widget.adoption['description'] ?? '');
  }

  Future<void> _save() async {
    final items = await LocalStorageService.getList('adoption_list');
    items[widget.index] = {
      "petName": petNameController.text,
      "breed": breedController.text,
      "age": ageController.text,
      "description": descController.text,
      "dateAdded":
          items[widget.index]['dateAdded'] ?? DateTime.now().toIso8601String(),
    };
    await LocalStorageService.updateList('adoption_list', items);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text("Edit Adoption"), backgroundColor: Colors.teal),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(children: [
          TextField(
              controller: petNameController,
              decoration: const InputDecoration(
                  labelText: "Pet Name", border: OutlineInputBorder())),
          const SizedBox(height: 12),
          TextField(
              controller: breedController,
              decoration: const InputDecoration(
                  labelText: "Breed", border: OutlineInputBorder())),
          const SizedBox(height: 12),
          TextField(
              controller: ageController,
              decoration: const InputDecoration(
                  labelText: "Age", border: OutlineInputBorder())),
          const SizedBox(height: 12),
          TextField(
              controller: descController,
              maxLines: 3,
              decoration: const InputDecoration(
                  labelText: "Description", border: OutlineInputBorder())),
          const SizedBox(height: 16),
          ElevatedButton(onPressed: _save, child: const Text("Save"))
        ]),
      ),
    );
  }
}
