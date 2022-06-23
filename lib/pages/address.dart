import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:new_verde/models/user.dart';

class AddressPage extends StatelessWidget {
  const AddressPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final userId = FirebaseAuth.instance.currentUser;

    final usersReference = FirebaseFirestore.instance.collection('users');
    // Obtención de Stream de elementos de la db.
    final users = usersReference.snapshots();

    return Scaffold(
      body: Center(
        child: SafeArea(
          child: Column(
            children: [
              const Text('Prueba de snapshot'),
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                  builder: (_, AsyncSnapshot<QuerySnapshot> snapshot) {
                    // Snapshot, objeto ya sintetizado por parte de Dart.
                    // Verifico que tenga datos.
                    if (snapshot.hasData) {
                      // Una vez verificados. Mapeo la lista de documentos.
                      final listOfDocs =
                          snapshot.data!.docs.map((DocumentSnapshot doc) {
                        // Casteo lista de documentos como un Map<String, dynamic> para poder ser transformados a un modelo de clase.
                        final document = doc.data() as Map<String, dynamic>;

                        return UserModel.fromJson(document);
                        // return UserModel.fromJson({"id": doc.id, ...document}); el documento con su respectivo id.
                      }).toList();

                      return ListView.builder(
                        itemCount: listOfDocs.length,
                        itemBuilder: (_, int idx) => Text(listOfDocs[idx].name),
                      );
                    }

                    return const Text('Hola');
                  },
                  // Consumo de Stream (autopista) por parte del StreamBuilder
                  stream: users,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
