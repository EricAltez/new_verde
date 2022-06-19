import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:new_verde/services/login_provider.dart';
import 'package:provider/provider.dart';

import 'package:new_verde/widgets/index.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            colors: [
              Color.fromRGBO(243, 243, 245, 1),
              Color.fromRGBO(237, 241, 247, 1),
            ],
            end: Alignment.bottomCenter,
          ),
        ),
        height: double.infinity,
        width: double.infinity,
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 200),
                const Text(
                  '¡Bienvenido!',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                ChangeNotifierProvider(
                  child: const _LoginForm(),
                  create: (_) => LoginFormProvider(),
                )
              ],
            ),
          ),
        ),
      ),
      resizeToAvoidBottomInset: false,
    );
  }
}

class _LoginForm extends StatelessWidget {
  const _LoginForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formProvider = Provider.of<LoginFormProvider>(context);

    return Form(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      key: formProvider.key,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            LoginInput(
              hintText: 'Email',
              keyboardType: TextInputType.emailAddress,
              onChanged: (value) => formProvider.email = value,
              prefixIcon: const Icon(Icons.alternate_email_sharp),
              textInputAction: TextInputAction.next,
              validator: (value) {
                String pattern =
                    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

                RegExp regExp = RegExp(pattern);

                return regExp.hasMatch(value ?? '')
                    ? null
                    : 'Verifique que ingresó una dirección de correo electrónico';
              },
            ),
            LoginInput(
              hintText: 'Password',
              onChanged: (value) => formProvider.password = value,
              prefixIcon: const Icon(Icons.lock_outline_rounded),
              textInputAction: TextInputAction.done,
              validator: (value) {
                if (value != null && value.length >= 6) return null;

                return 'Contraseña mínimo de 6 caracteres';
              },
            ),
            MaterialButton(
              color: Colors.deepPurple,
              height: 50,
              minWidth: double.infinity,
              onPressed: formProvider.isLoading ? null : () => _login(context),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: formProvider.isLoading
                  ? const CircularProgressIndicator(
                      color: Colors.white,
                    )
                  : const Text(
                      'Ingresar',
                      style: TextStyle(color: Colors.white),
                    ),
            )
          ],
        ),
      ),
    );
  }

  void _login(BuildContext context) async {
    final formProvider = Provider.of<LoginFormProvider>(context, listen: false);
    FocusScope.of(context).unfocus();

    formProvider.isLoading = true;

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: formProvider.email,
        password: formProvider.password,
      );

      formProvider.isLoading = false;
      Navigator.pushReplacementNamed(context, 'home');
    } catch (e) {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          actions: [
            MaterialButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cerrar'),
            )
          ],
          content: const Text('Verifique mail y contraseña sean correctos.'),
          title: const Text('Error al iniciar sesión'),
        ),
      );
      formProvider.isLoading = false;
    }
  }
}