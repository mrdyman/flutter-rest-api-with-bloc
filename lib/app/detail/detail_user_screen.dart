import 'package:flutter/material.dart';

class DetailUserScreen extends StatelessWidget {
  const DetailUserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.arrow_back),
      ),
      body: Center(child: Text('data')),
    );
  }
}
