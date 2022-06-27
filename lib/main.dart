import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            body: Container(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              const TextField(),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Text('Interactivity', style: TextStyle(fontSize: 16)),
                  const Spacer(),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        textStyle: const TextStyle(fontSize: 24)),
                    onPressed: () {},
                    child: const Text('Save'),
                  ),
                ],
              ),
            ],
          ),
        )));
  }
}
