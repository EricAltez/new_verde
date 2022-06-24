import 'package:flutter/material.dart';
import 'package:new_verde/pages/scan_carton.dart';

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
          ElevatedButton.icon(
            icon: const Icon(Icons.arrow_back, size: 32),
            label: const Text(
              'Sign Out1',
              style: TextStyle(fontSize: 24),
            ),
            onPressed: () => Navigator.pushNamed(context, '/scanpage')
          ),
          ElevatedButton.icon(
            icon: const Icon(Icons.arrow_back, size: 32),
            label: const Text(
              'Sign Out2',
              style: TextStyle(fontSize: 24),
            ),
            onPressed: () => Navigator.pushNamed(context, '/organicoscan'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pushNamed(context, '/plasticoscan'),
            child: null,
          ),
        ],
      ),
    );
  }
}