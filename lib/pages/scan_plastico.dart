import 'package:flutter/material.dart';

class ScanPlastico extends StatelessWidget {
  const ScanPlastico({Key? key}) : super(key: key);

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
