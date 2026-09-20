import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Weekly Schedule')),
      body: const Center(child: Text('Home screen - schedule grid will appear here')),
    );
  }
}
