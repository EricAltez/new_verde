import 'package:flutter/material.dart';

class PlasticoScan extends StatelessWidget {
  const PlasticoScan({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Center(
            child: Text('scan p'),
          ),
          TextButton(
          child: const Text('Pop!'),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        ],
      ),
    );
  }
}