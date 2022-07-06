import 'dart:io';
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
  final docUser = FirebaseFirestore.instance
      .collection('users')
      .doc('FLfuMOeM7wkBWziXLQUs');
  final a =
      'https://media-private.canva.com/X-X_c/MAFFF0X-X_c/1/s.png?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAJWF6QO3UH4PAAJ6Q%2F20220630%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20220630T052851Z&X-Amz-Expires=51051&X-Amz-Signature=0c707b138062e19e4fbc42aaafd5ba928518c2166500b8a49618bebee6472d5a&X-Amz-SignedHeaders=host&response-expires=Thu%2C%2030%20Jun%202022%2019%3A39%3A42%20GMT';
  final b =
      'https://www.worldatlas.com/r/w960-q80/upload/89/99/3b/shutterstock-1263201358.jpg';
  final c =
      'https://wallpaperaccess.com/full/6153786.jpg';
  final d =
      'https://c.pxhere.com/photos/47/5a/chestnut_tree_sunset_meadows_land_hdr_high_dynamic_range_chestnut_nature-1199025.jpg!d';
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Home'),
          backgroundColor: Colors.lightGreen,
          automaticallyImplyLeading: true,
          leading: IconButton(icon:Icon(Icons.arrow_back),
          //onPressed:() => Navigator.pop(context, false),
          onPressed:() => exit(0),)
        ),
        backgroundColor: Colors.white,
        body: FutureBuilder<UserM?>(
          future: readUser(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Text('Algo salió mal');
            } else if (snapshot.hasData) {
              final user = snapshot.data;
              return user == null
                  ? const Center(child: Text('No hay usuario'))
                  : Scaffold(
                      body: Center(
                        child: SafeArea(
                          child: Column(children: [
                            Expanded(child: buildUser(user))
                          ]),
                        ),
                      ),
                      bottomNavigationBar: BottomNavigationBar(
                        onTap: (index) {
                          if (index == 2) {
                            launchUrlString("https://verde-mvp.blogspot.com/");
                          }
                          if (index == 1) {
                            Navigator.pushNamed(context, 'scanpage');
                          }
                          if (index == 0) {
                            Navigator.pushNamed(context, 'mappage');
                          }
                        },
                        currentIndex: paginaActual,
                        items: const [
                          BottomNavigationBarItem(
                              icon: Icon(Icons.map), label: 'Mapa'),
                          BottomNavigationBarItem(
                              icon: Icon(Icons.qr_code), label: 'Scanner QR'),
                          BottomNavigationBarItem(
                              icon: Icon(Icons.text_format), label: 'Blog'),
                        ],
                      ),
                    );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      );
  //: buildUser(user);

  Widget buildUser(UserM user) => Scaffold(
      body: Padding(
          padding: const EdgeInsets.all(15),
          child: ListView(children: [
            Image.network(
              (() {
                if (user.points < 50) {
                  return a;
                } else if (user.points >= 50 && user.points < 100) {
                  return b;
                } else if (user.points >= 100 && user.points < 150) {
                  return c;
                } else if (user.points >= 150) {
                  return d;
                }
                return "Error al cargar sus puntos";
              })(),
              alignment: Alignment.topCenter,
              height: 300,
            ),
            Container(
              margin: const EdgeInsets.all(30),
              height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: const LinearGradient(
                  colors: [
                    Color.fromARGB(255, 51, 255, 44),
                    Color.fromARGB(255, 131, 236, 127),
                  ],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  stops: [0.25, 0.90],
                ),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0xFF101012),
                    offset: Offset(-12, 12),
                    blurRadius: 8,
                  ),
                ],
              ),
              alignment: Alignment.centerLeft, //to align its child
              padding: const EdgeInsets.all(20),
              child: Text(
                'Bienvenido: ${user.name}',
                style: const TextStyle(
                  fontSize: 15,
                  color: Colors.white,
                  fontWeight: FontWeight.w200,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.all(30),
              height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: const LinearGradient(
                  colors: [
                    Color.fromARGB(255, 51, 255, 44),
                    Color.fromARGB(255, 131, 236, 127),
                  ],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  stops: [0.25, 0.90],
                ),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0xFF101012),
                    offset: Offset(-12, 12),
                    blurRadius: 8,
                  ),
                ],
              ),
              alignment: Alignment.centerLeft, //to align its child
              padding: const EdgeInsets.all(20),
              child: Text(
                'Reciclaje total: ${user.plastico + user.carton + user.organico}',
                style: const TextStyle(
                  fontSize: 15,
                  color: Colors.white,
                  fontWeight: FontWeight.w200,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.all(30),
              height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: const LinearGradient(
                  colors: [
                    Color.fromARGB(255, 51, 255, 44),
                    Color.fromARGB(255, 131, 236, 127),
                  ],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  stops: [0.25, 0.90],
                ),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0xFF101012),
                    offset: Offset(-12, 12),
                    blurRadius: 8,
                  ),
                ],
              ),
              alignment: Alignment.centerLeft, //to align its child
              padding: const EdgeInsets.all(20),
              child: Text(
                'Puntaje total: ${user.points}',
                style: const TextStyle(
                  fontSize: 15,
                  color: Colors.white,
                  fontWeight: FontWeight.w200,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.all(30),
              height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: const LinearGradient(
                  colors: [
                    Color.fromARGB(255, 51, 255, 44),
                    Color.fromARGB(255, 131, 236, 127),
                  ],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  stops: [0.25, 0.90],
                ),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0xFF101012),
                    offset: Offset(-12, 12),
                    blurRadius: 8,
                  ),
                ],
              ),
              alignment: Alignment.centerLeft, //to align its child
              padding: const EdgeInsets.all(20),
              child: Text(
                'Carton reciclado: ${user.carton}',
                style: const TextStyle(
                  fontSize: 15,
                  color: Colors.white,
                  fontWeight: FontWeight.w200,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.all(30),
              height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: const LinearGradient(
                  colors: [
                    Color.fromARGB(255, 51, 255, 44),
                    Color.fromARGB(255, 131, 236, 127),
                  ],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  stops: [0.25, 0.90],
                ),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0xFF101012),
                    offset: Offset(-12, 12),
                    blurRadius: 8,
                  ),
                ],
              ),
              alignment: Alignment.centerLeft, //to align its child
              padding: const EdgeInsets.all(20),
              child: Text(
                'Plastico reciclado: ${user.plastico}',
                style: const TextStyle(
                  fontSize: 15,
                  color: Colors.white,
                  fontWeight: FontWeight.w200,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.all(30),
              height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: const LinearGradient(
                  colors: [
                    Color.fromARGB(255, 51, 255, 44),
                    Color.fromARGB(255, 131, 236, 127),
                  ],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  stops: [0.25, 0.90],
                ),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0xFF101012),
                    offset: Offset(-12, 12),
                    blurRadius: 8,
                  ),
                ],
              ),
              alignment: Alignment.centerLeft, //to align its child
              padding: const EdgeInsets.all(20),
              child: Text(
                'Material orgánico reciclado: ${user.organico}',
                style: const TextStyle(
                  fontSize: 15,
                  color: Colors.white,
                  fontWeight: FontWeight.w200,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
            //CircleAvatar(child: Text('${user.points}')),
            //Text(user.name),
            //Text((user.carton).toString()),
          ])));
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
