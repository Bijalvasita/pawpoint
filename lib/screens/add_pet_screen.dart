import 'package:flutter/material.dart';
//import 'package:pet_app_flutter/services/local_storage.dart';
import 'package:pawpoint/services/local_storage.dart';

class AddPetScreen extends StatefulWidget {
  const AddPetScreen({Key? key}) : super(key: key);

  @override
  State<AddPetScreen> createState() => _AddPetScreenState();
}

class _AddPetScreenState extends State<AddPetScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _typeController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();

  Future<void> _savePet() async {
    if (_formKey.currentState!.validate()) {
      final newPet = {
        "name": _nameController.text,
        "type": _typeController.text,
        "age": _ageController.text,
        "notes": _notesController.text,
        "dateAdded": DateTime.now().toIso8601String(),
      };
      await LocalStorageService.saveToList('pet_list', newPet);
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Pet added successfully!")));
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          AppBar(title: const Text("Add Pet"), backgroundColor: Colors.teal),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(children: [
                TextFormField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                        labelText: "Pet Name",
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.pets)),
                    validator: (v) => v!.isEmpty ? "Enter pet name" : null),
                const SizedBox(height: 16),
                TextFormField(
                    controller: _typeController,
                    decoration: const InputDecoration(
                        labelText: "Pet Type (Dog, Cat...)",
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.category)),
                    validator: (v) => v!.isEmpty ? "Enter pet type" : null),
                const SizedBox(height: 16),
                TextFormField(
                    controller: _ageController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                        labelText: "Age (years)",
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.cake)),
                    validator: (v) => v!.isEmpty ? "Enter age" : null),
                const SizedBox(height: 16),
                TextFormField(
                    controller: _notesController,
                    maxLines: 3,
                    decoration: const InputDecoration(
                        labelText: "Notes",
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.note))),
                const SizedBox(height: 20),
                ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.teal,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12))),
                    onPressed: _savePet,
                    icon: const Icon(Icons.save),
                    label:
                        const Text("Save Pet", style: TextStyle(fontSize: 18))),
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
