import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UserForm extends StatefulWidget {
  const UserForm({Key? key}) : super(key: key);

  @override
  State<UserForm> createState() => _UserFormState();
}

class _UserFormState extends State<UserForm> {
  final controller = TextEditingController();
  final CollectionReference _users =
      FirebaseFirestore.instance.collection('Users');
  final int paginaActual = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Image.network(
              'https://www.infobae.com/new-resizer/3Li_m1keD_SbaaC0kpmpvqEPdmE=/768x432/filters:format(webp):quality(85)/s3.amazonaws.com/arc-wordpress-client-uploads/infobae-wp/wp-content/uploads/2019/08/29114706/shutterstock_577672450.jpg'),
          StreamBuilder(
            stream: _users.snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
              if (streamSnapshot.hasData) {
                return ListView.builder(
                    shrinkWrap: true,
                    itemCount: streamSnapshot.data!.docs.length,
                    itemBuilder: (_, index) {
                      final DocumentSnapshot documentSnapshot =
                          streamSnapshot.data!.docs[index];
                      return Card(
                        margin: const EdgeInsets.all(10),
                        child: ListTile(
                          title: Text(documentSnapshot['Name']),
                          subtitle: Text(documentSnapshot['Email']),
                          trailing: Text(
                            ("points = ${documentSnapshot['Points']} - Nº scan = ${documentSnapshot['ScanN']}"),
                          ),
                        ),
                      );
                    });
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
          onTap: (index) {
            setState(() {
              paginaActual;
            });
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

/*  Future createUser({required String name}) async {
    final docUser = FirebaseFirestore.instance.collection('Users').doc();

    final json = {
      'Name': name,
      'Email': 'testwrite@gmail.com',
      'Points': 10,
      'ScanN': 12,
    };

    await docUser.set(json);
  }
}
*/