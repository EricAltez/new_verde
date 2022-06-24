import 'package:flutter/material.dart';

class ScanPage extends StatelessWidget {
  const ScanPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          const Center(
            child: Text('scan'),
          ),
          TextButton(
            child: const Text('Pop!'),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          ElevatedButton(
            onPressed: () => Navigator.pushNamed(context, 'scanpage'),
            child: null,
          ),
          ElevatedButton(
            onPressed: () => Navigator.pushNamed(context, 'organicoscan'),
            child: null,
          ),
          ElevatedButton(
            onPressed: () => Navigator.pushNamed(context, 'plasticoscan'),
            child: null,
          ),
        ],
      ),
    );
  }
}