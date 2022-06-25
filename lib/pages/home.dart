import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:new_verde/models/user.dart';
import 'package:url_launcher/url_launcher.dart';

import '../widgets/utils.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final userId = FirebaseAuth.instance.currentUser;

    final usersReference = FirebaseFirestore.instance.collection('users');
    // Obtención de Stream de elementos de la db.
    final users = usersReference.snapshots();
    const int paginaActual = 1;

    return Scaffold(
      body: Center(
        child: SafeArea(
          child: Column(
            children: [
              Image.network(
                'https://farm3.staticflickr.com/2897/14464606763_5473161990.jpg',
                alignment: Alignment.topCenter,
                height: 300,
              ),
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
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: listOfDocs.length,
                        itemBuilder: (_, int idx) => Container(
                          child: Column(
                            children: [Text('')],
                          ),
                          height: 50,
                          width: 50,
                        ),
                      );
                    }

                    return const Text('Hola');
                  },
                  // Consumo de Stream (autopista) por parte del StreamBuilder
                  stream: users,
                ),
              ),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  primary: Colors.lightGreen,
                  minimumSize: const Size.fromHeight(50),
                ),
                icon: const Icon(Icons.arrow_back, size: 32),
                label: const Text(
                  'Desconectarse',
                  style: TextStyle(fontSize: 24),
                ),
                onPressed: () {
                  FirebaseAuth.instance
                      .signOut()
                      .then((_) =>
                          Navigator.of(context).pushReplacementNamed('login'))
                      .catchError((error) => Utils.showSnackBar(error.message));
                },
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
          onTap: (index) {
            if (index == 2) launch("https://3956holberton.blogspot.com/");
            if (index == 1) Navigator.pushNamed(context, 'scanpage');
            if (index == 0) Navigator.pushNamed(context, 'mappage');
          },
          currentIndex: paginaActual,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.map), label: 'map'),
            BottomNavigationBarItem(
                icon: Icon(Icons.qr_code), label: 'qr_scaner'),
            BottomNavigationBarItem(
                icon: Icon(Icons.text_format), label: 'blogs'),
          ]),
    );
  }
}
