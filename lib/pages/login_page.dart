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
      body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 15,
                horizontal: 15,
              ),
              child:
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: Image.asset('images/intro2.jpg')
                    ),
                    TextField(
                      controller: emailController,
                      cursorColor: Colors.black,
                      decoration: const InputDecoration(
                          labelText: 'Email',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.email)),
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                    ),
                    const SizedBox(height: 4),
                    TextField(
                      controller: passwordController,
                      textInputAction: TextInputAction.done,
                      decoration: const InputDecoration(
                          labelText: 'Contraseña',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.email)),
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
                        'Ingresar',
                        style: TextStyle(fontSize: 24),
                      ),
                      onPressed: () => _signIn(context, emailController.text.trim(),
                          passwordController.text.trim()),
                    ),
                    const SizedBox(height: 15),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Text(
                          'Aun no tiene una cuenta?',
                          style: TextStyle(color: Colors.black, fontSize: 20),
                        ),
                        MaterialButton(
                          onPressed: () => Navigator.pushNamed(context, 'signup'),
                          child: Text(
                            'Registrate',
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
        )
    ;
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
