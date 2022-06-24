import 'package:flutter/material.dart';

class CartonScan extends StatelessWidget {
  const CartonScan({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Center(
            child: Text('sacan c'),
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