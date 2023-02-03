import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("TECNICAL TEST IDSTAR"),
        backgroundColor: Colors.blueAccent,
      ),
      backgroundColor: Colors.grey[300],
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return buildCardItem();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => 1,
        tooltip: 'Add New User',
        child: const Icon(Icons.add),
      ),
    );
  }

  Padding buildCardItem() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 10),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: Colors.white),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Text('ID'),
                  Text('Nama'),
                  Text('Email'),
                  Text('Gender'),
                  Text('Status'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
