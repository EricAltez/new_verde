import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:new_verde/models/user.dart';



class UserPage extends StatefulWidget {
  const UserPage({Key? key}) : super(key: key);

  @override
  State<UserPage> createState() => _UserpageState();
}

class _UserpageState extends State<UserPage> {
  final controllerNombre = TextEditingController();

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Agragar usuario'),
        ),
        body: ListView(
          padding: const EdgeInsets.all(16),
          children: <Widget>[
            TextFormField(
              controller: controllerNombre,
              decoration: const InputDecoration(
                labelText: 'Elije un alias'),
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              child: const Text('Crear'),
              onPressed: () {
                final user = UserM(
                  points: 0,
                  organico: 0,
                  plastico: 0,
                  carton: 0,
                  name: controllerNombre.text,
                );

                createUser(user);

                Navigator.pop(context);
              },
            )
          ],
        ),
      );
  Future createUser(UserM user) async {
    final docUser = FirebaseFirestore.instance.collection('users').doc();
    user.id = docUser.id;

    final json = user.toJson();
    await docUser.set(json);
  }
}
