import 'package:flutter/material.dart';

class ScanOrganico extends StatelessWidget {
  const ScanOrganico({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Center(
            child: Text('scan o'),
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
