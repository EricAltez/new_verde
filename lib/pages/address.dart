import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:new_verde/models/scan.dart';

class AddressPage extends StatelessWidget {
  const AddressPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userId = FirebaseAuth.instance.currentUser?.uid;

    final recordsReference = FirebaseFirestore.instance.collection('records');

    final records = recordsReference
        .where("user", isEqualTo: userId)
        .get()
        .then((snapshot) => snapshot.docs // Una lista
            .map((doc) => ScanModel.fromJson({"id": doc.id, ...doc.data()}))
            .toList());

    return FutureBuilder<List<ScanModel>>(
      builder: (_, AsyncSnapshot<List<ScanModel>> snapshot) {
        if (snapshot.hasError) return const Text('Algo falló');

        if (!snapshot.hasData) {
          return const Text('Algo falló x2');
        }

        if (snapshot.connectionState == ConnectionState.done) {
          final data = snapshot.data;

          return ListView.builder(
            itemBuilder: (_, int idx) => Dismissible(
              background: Container(color: Colors.red),
              // onDismissed: (direction) => recordsReference., => funcionalidad de delete de base de datos.
              key: UniqueKey(),
              child: ListTile(
                title: Text('Value is: ${data?[idx].value}'),
              ),
            ),
            itemCount: data?.length,
          );
        }

        return const CircularProgressIndicator();
      },
      future: records,
    );
  }
}