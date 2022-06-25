import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:new_verde/main.dart';
import 'package:flutter/gestures.dart';
import 'package:email_validator/email_validator.dart';
import 'package:new_verde/widgets/utils.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
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
                TextFormField(
                    controller: emailController,
                    cursorColor: Colors.black,
                    textInputAction: TextInputAction.next,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.email)),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (email) =>
                        email != null && !EmailValidator.validate(email)
                            ? 'Ingresa un email válido!'
                            : null),
                const SizedBox(height: 4),
                TextFormField(
                  controller: passwordController,
                  textInputAction: TextInputAction.done,
                  decoration: const InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.email)),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) => value != null && value.length < 6
                      ? '6 characters minimun'
                      : null,
                  obscureText: true,
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.lightGreen,
                    minimumSize: const Size.fromHeight(50),
                  ),
                  icon: const Icon(Icons.lock_open, size: 32),
                  label: const Text(
                    'Registrarse',
                    style: TextStyle(fontSize: 24),
                  ),
                  onPressed: () => _signUp(
                      context,
                      formKey,
                      emailController.text.trim(),
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

  Future _signUp(BuildContext context, GlobalKey<FormState> formKey,
      String email, String password) async {
    final isValid = formKey.currentState!.validate();
    if (!isValid) return;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );

    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      print(e);

      Utils.showSnackBar(e.message);
    }

    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }
}
