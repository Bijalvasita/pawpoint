import 'package:flutter/material.dart';
import 'package:pawpoint/services/local_storage.dart';

class FeedbackScreen extends StatefulWidget {
  const FeedbackScreen({Key? key}) : super(key: key);

  @override
  State<FeedbackScreen> createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  final _controller = TextEditingController();

  Future<void> _submit() async {
    if (_controller.text.trim().isEmpty) return;
    await LocalStorageService.saveToList('feedback_list', {
      'text': _controller.text.trim(),
      'date': DateTime.now().toIso8601String()
    });
    _controller.clear();
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('Thanks for feedback')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:
            AppBar(title: const Text('Feedback'), backgroundColor: Colors.teal),
        body: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(children: [
              TextField(
                  controller: _controller,
                  decoration: const InputDecoration(
                      labelText: 'Your feedback',
                      border: OutlineInputBorder())),
              const SizedBox(height: 12),
              ElevatedButton(onPressed: _submit, child: const Text('Submit'))
            ])));
  }
}
