import 'package:flutter/material.dart';
//import 'package:paw/services/local_storage.dart';
import 'package:pawpoint/services/local_storage.dart';

class AddAdoptionScreen extends StatefulWidget {
  const AddAdoptionScreen({Key? key}) : super(key: key);

  @override
  State<AddAdoptionScreen> createState() => _AddAdoptionScreenState();
}

class _AddAdoptionScreenState extends State<AddAdoptionScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _petNameController = TextEditingController();
  final TextEditingController _breedController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  Future<void> _saveAdoption() async {
    if (_formKey.currentState!.validate()) {
      final newAdoption = {
        "petName": _petNameController.text,
        "breed": _breedController.text,
        "age": _ageController.text,
        "description": _descriptionController.text,
        "dateAdded": DateTime.now().toIso8601String(),
      };
      await LocalStorageService.saveToList('adoption_list', newAdoption);
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Adoption added successfully!")));
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text("Add Adoption"), backgroundColor: Colors.teal),
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
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text("Enter Pet Details",
                        style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.teal)),
                    const SizedBox(height: 16),
                    TextFormField(
                        controller: _petNameController,
                        decoration: const InputDecoration(
                            labelText: "Pet Name",
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.pets)),
                        validator: (v) =>
                            v!.isEmpty ? "Please enter pet name" : null),
                    const SizedBox(height: 16),
                    TextFormField(
                        controller: _breedController,
                        decoration: const InputDecoration(
                            labelText: "Breed",
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.category)),
                        validator: (v) =>
                            v!.isEmpty ? "Please enter breed" : null),
                    const SizedBox(height: 16),
                    TextFormField(
                        controller: _ageController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                            labelText: "Age (in years)",
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.cake)),
                        validator: (v) =>
                            v!.isEmpty ? "Please enter age" : null),
                    const SizedBox(height: 16),
                    TextFormField(
                        controller: _descriptionController,
                        maxLines: 3,
                        decoration: const InputDecoration(
                            labelText: "Description",
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.description)),
                        validator: (v) =>
                            v!.isEmpty ? "Please enter a description" : null),
                    const SizedBox(height: 24),
                    ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            backgroundColor: Colors.teal,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12))),
                        onPressed: _saveAdoption,
                        icon: const Icon(Icons.save),
                        label: const Text("Save Adoption",
                            style: TextStyle(fontSize: 18))),
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}
