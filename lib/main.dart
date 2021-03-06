import 'dart:io' show Directory;

import 'package:flutter/material.dart';
import 'dart:developer';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import 'package:personal_log/wren.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final Directory result = await getApplicationSupportDirectory();
  log(result.absolute.path);
  Wren.init(join(result.path, 'personalLog.db'));

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Personal Log',
        home: Scaffold(body: EntryWidget()));
  }
}

class EntryWidget extends StatefulWidget {
  const EntryWidget({super.key});

  @override
  State<EntryWidget> createState() => _EntryWidgetState();
}

class _EntryWidgetState extends State<EntryWidget> {
  String _message = '';
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _save() async {
    log('submitted: ${_controller.text}');
    setState(() {
      _message = 'Saving...';
    });
    await Wren.database.insert('entries', {
      'timestamp': DateTime.now().toIso8601String(),
      'entry': _controller.text,
    });
    setState(() {
      _message = 'Saved';
      _controller.clear();
    });
    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      _message = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          TextField(
              controller: _controller,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Log Entry',
              ),
              onSubmitted: (String value) async {
                _save();
              }),
          const SizedBox(height: 8),
          Row(
            children: [
              Text(_message, style: const TextStyle(fontSize: 16)),
              const Spacer(),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    textStyle: const TextStyle(fontSize: 24)),
                onPressed: _save,
                child: const Text('Save'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
