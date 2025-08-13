import 'package:flutter/material.dart';
import 'package:pawpoint/services/local_storage.dart';

class ReminderScreen extends StatefulWidget {
  const ReminderScreen({Key? key}) : super(key: key);

  @override
  State<ReminderScreen> createState() => _ReminderScreenState();
}

class _ReminderScreenState extends State<ReminderScreen> {
  final controller = TextEditingController();

  Future<void> _add() async {
    if (controller.text.trim().isEmpty) return;
    await LocalStorageService.saveToList('reminders', {
      'text': controller.text.trim(),
      'date': DateTime.now().toIso8601String()
    });
    controller.clear();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text('Reminders'), backgroundColor: Colors.teal),
        body: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(children: [
              TextField(
                  controller: controller,
                  decoration: const InputDecoration(
                      labelText: 'Reminder', border: OutlineInputBorder())),
              const SizedBox(height: 12),
              ElevatedButton(
                  onPressed: _add, child: const Text('Add Reminder')),
              const SizedBox(height: 12),
              Expanded(
                  child: FutureBuilder<List<Map<String, dynamic>>>(
                      future: LocalStorageService.getList('reminders'),
                      builder: (c, s) {
                        if (!s.hasData)
                          return const Center(
                              child: CircularProgressIndicator());
                        final items = s.data!;
                        if (items.isEmpty)
                          return const Center(child: Text('No reminders'));
                        return ListView.builder(
                            itemCount: items.length,
                            itemBuilder: (ctx, i) {
                              return ListTile(title: Text(items[i]['text']));
                            });
                      }))
            ])));
  }
}
