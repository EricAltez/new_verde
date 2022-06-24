import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:new_verde/pages/address.dart';
import 'package:new_verde/widgets/auth_page.dart';

class UserPage extends StatelessWidget {
  const UserPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) { 
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(body: user != null ? const AddressPage() : const AuthPage());
  }
}
