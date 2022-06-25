import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:new_verde/widgets/utils.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();

    return Scaffold(
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('images/Logo_Verde.jpg'),
                const SizedBox(height: 40),
                TextField(
                  controller: emailController,
                  cursorColor: Colors.black,
                  decoration: const InputDecoration(labelText: 'Email'),
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                ),
                const SizedBox(height: 4),
                TextField(
                  controller: passwordController,
                  textInputAction: TextInputAction.done,
                  decoration: const InputDecoration(labelText: 'Password'),
                  obscureText: true,
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(50),
                  ),
                  icon: const Icon(Icons.lock_open, size: 32),
                  label: const Text(
                    'Sign In',
                    style: TextStyle(fontSize: 24),
                  ),
                  onPressed: () => _signIn(context, emailController.text.trim(),
                      passwordController.text.trim()),
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    const Text(
                      'No account?',
                      style: TextStyle(color: Colors.black, fontSize: 20),
                    ),
                    MaterialButton(
                      onPressed: () => Navigator.pushNamed(context, ''),
                      child: Text(
                        'Sign Up',
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
    ),
  );
  }

  void _signIn(BuildContext context, String email, String password) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );

    FirebaseAuth.instance
        .signInWithEmailAndPassword(
          email: email,
          password: password,
        )
        .then((value) => Navigator.of(context).pushReplacementNamed('home'))
        .catchError((error) => Utils.showSnackBar(error.message));

    // navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }
}
