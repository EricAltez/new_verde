import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:new_verde/widgets/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:new_verde/models/user.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final paginaActual = 1;
  final CollectionReference users =
      FirebaseFirestore.instance.collection('users');
  //final _user = _users.where(id);
  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: FutureBuilder<UserM?>(
        future: readUser(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Algo salió mal');
          } else if (snapshot.hasData) {
            final user = snapshot.data;

            return user == null
                ? const Center(child: Text('No hay usuario'))
                : buildUser(user);
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ));

  Widget buildUser(UserM user) => ListTile(
        leading: CircleAvatar(child: Text('${user.points}')),
        title: Text(user.name),
        subtitle: Text((user.carton).toString()),
      );

  Stream<List<UserM>> readUsers() => FirebaseFirestore.instance
      .collection('users')
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => UserM.fromJson(doc.data())).toList());

  Future<UserM?> readUser() async {
    final docUser = FirebaseFirestore.instance
        .collection('users')
        .doc('FLfuMOeM7wkBWziXLQUs');
    final snapshot = await docUser.get();

    if (snapshot.exists) {
      return UserM.fromJson(snapshot.data()!);
    }
  }

  Future createUser({required String name}) async {
    //referencia al documento
    final docUser = FirebaseFirestore.instance.collection('users').doc();

    final user = UserM(
      id: docUser.id,
      name: name,
      points: 0,
      organico: 0,
      carton: 0,
      plastico: 0,
    );
    final json = user.toJson();

    ///creacion del documento y escritura a firebase
    await docUser.set(json);
  }
}
