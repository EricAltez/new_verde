import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_launcher/url_launcher_string.dart';
//import 'package:new_verde/widgets/utils.dart';
//import 'package:firebase_auth/firebase_auth.dart';
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
            :Scaffold(
              body: Center(
                child: SafeArea(
                  child: Column(
                    children: [
                      Image.network(
                        'https://media-private.canva.com/h0RjI/MAFEzYh0RjI/1/s.png?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAJWF6QO3UH4PAAJ6Q%2F20220626%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20220626T214625Z&X-Amz-Expires=74394&X-Amz-Signature=e7bbb89b7d1438fd153f68678804f2fe645fc20e26869b8cc54e3d1b708055cf&X-Amz-SignedHeaders=host&response-expires=Mon%2C%2027%20Jun%202022%2018%3A26%3A19%20GMT',
                        alignment: Alignment.topCenter,
                        height: 300,
                      ),
                    ]
                  ),
                ),
              ),
              bottomNavigationBar: BottomNavigationBar(
                onTap: (index) {
                  if (index == 2) {
                    launchUrlString("https://verde-mvp.blogspot.com/");
                  }
                  if (index == 1) Navigator.pushNamed(context, 'scanpage');
                  if (index == 0) Navigator.pushNamed(context, 'mappage');
                },
                currentIndex: paginaActual,
                items: const [
                  BottomNavigationBarItem(icon: Icon(Icons.map),
                  label: 'Mapa'),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.qr_code),
                    label: 'Scanner QR'),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.text_format),
                      label: 'Blog'),
                ],
              ),
            );
            } else {  return const Center(child: CircularProgressIndicator());}
      },
    ),
  );
            //: buildUser(user);

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