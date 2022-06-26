import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_launcher/url_launcher_string.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final paginaActual = 1;
  final CollectionReference _users =
      FirebaseFirestore.instance.collection('users');
  //final _user = _users.where(id);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder<DocumentSnapshot>(
      future: _users.doc('FLfuMOeM7wkBWziXLQUs').get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text("Algo salió mal");
        }
        if (snapshot.hasData && !snapshot.data!.exists) {
          return const Text("Document does not exist");
        }
        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          return Scaffold(
            body: Column(),
            bottomNavigationBar: BottomNavigationBar(
          onTap: (index) {
            if (index == 2) {
              launchUrlString("https://3956holberton.blogspot.com/");
            }
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

        return const Text("loading");
      },
    ));
  }

  /*stream: _users.snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
          if (streamSnapshot.hasData) {
            return ListView.builder(
              itemCount: streamSnapshot.data!.docs.length,
              itemBuilder: (context, index) {
                final DocumentSnapshot documentSnapshot =
                    streamSnapshot.data!.docs[0];
                return Card(
                  margin: const EdgeInsets.all(10),
                  child: ListTile(
                    title: Text(documentSnapshot['name']),
                  ),
                );
              },
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}*/
  /*const int paginaActual = 1;

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
                            children: [Text('${UserModel.name}')],
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
      ),*/
  }
