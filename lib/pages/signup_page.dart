import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:new_verde/main.dart';
import 'package:email_validator/email_validator.dart';
import 'package:new_verde/widgets/utils.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  Future _signUp() async {
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim());

    addUserInfo(_nameController.text.trim(), _emailController.text.trim());
  }

  Future addUserInfo(String name, String email) async {
    await FirebaseFirestore.instance.collection('users').add({
      'name': name,
      'organico': 0,
      'plastico': 0,
      'carton': 0,
      'points': 0,
      'email': email,
    });
  }

  /* final isValid = formKey.currentState!.validate();
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
  }
*/
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("images/fondo.jpg"),
              fit: BoxFit.cover,
            ),
          ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 15,
            horizontal: 15,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(child: Image.asset('images/verdelogopng.png')),
              TextFormField(
                controller: _nameController,
                cursorColor: Colors.black,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  labelText: 'Nombre',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(25)),
                  prefixIcon: const Icon(Icons.people),
                ),
              ),
              const SizedBox(height: 4),
              TextFormField(
                controller: _emailController,
                cursorColor: Colors.black,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                    labelText: 'Email',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(25), borderSide: const BorderSide(color: Colors.black, width: 0.5)),
                    prefixIcon: const Icon(Icons.email)),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (email) =>
                  email != null && !EmailValidator.validate(email)
                    ? 'Ingresa un email válido!'
                    : null),
              const SizedBox(height: 4),
              TextFormField(
                controller: _passwordController,
                textInputAction: TextInputAction.done,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  labelText: 'Contraseña',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(25)),
                  prefixIcon: const Icon(Icons.lock),
                ),
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
                  shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          side: const BorderSide(color: Colors.black),
                        ),
                  side: const BorderSide(color: Colors.black, width: 0.5),
                  primary: Colors.lightGreen,
                  minimumSize: const Size.fromHeight(50),
                ),
                icon: const Icon(Icons.lock_open, size: 32),
                label: const Text(
                  'Registrarse',
                  style: TextStyle(fontSize: 24),
                ),
                onPressed: () => _signUp(),
              ),
              const SizedBox(height: 24),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Text(
                    'Ya tiene una cuenta?',
                    style: TextStyle(color: Colors.black, fontSize: 20),
                  ),
                  MaterialButton(
                    onPressed: () => Navigator.pushNamed(context, 'login'),
                    child: Text(
                      'Log In',
                      style: TextStyle(
                        fontSize: 20,
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

  //navigatorKey.currentState!.popUntil((route) => route.isFirst);
}
