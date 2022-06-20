import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserPage extends StatelessWidget {
  const UserPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    return Scaffold(
        appBar: AppBar(
          title: const Text('User Page'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Signed in as',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 16),
              Text(
                user.email!,
                style: const TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 40),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(50),
                ),
                icon: const Icon(Icons.arrow_back, size: 32),
                label: const Text(
                  'Sign Out',
                  style: TextStyle(fontSize: 24),
                ),
                onPressed: () => FirebaseAuth.instance.signOut(),
              ),
            ],
          ),
        ));
  }
}
