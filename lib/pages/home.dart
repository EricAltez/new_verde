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
  final docUser = FirebaseFirestore.instance
      .collection('users')
      .doc('fmXGtUKgGWfYQXbYRY2q');
  final a = 'https://github.com/EricAltez/new_verde/blob/17-07/images/semilla_v3.png?raw=true';
  final b = 'https://github.com/EricAltez/new_verde/blob/17-07/images/planta.png?raw=true';
  final c = 'https://github.com/EricAltez/new_verde/blob/17-07/images/planta_grande.png?raw=true';
  final d = 'https://github.com/EricAltez/new_verde/blob/17-07/images/arbol.png?raw=true';
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Inicio'),
          backgroundColor: Colors.green,
          automaticallyImplyLeading: true,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              FirebaseAuth.instance
              .signOut()
              .then((_) =>
                  Navigator.of(context).pushReplacementNamed('login'))
              .catchError((error) => Utils.showSnackBar(error.message));
            },
          ),
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromARGB(192, 120, 199, 30),
                  Color.fromARGB(64, 131, 236, 127),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                stops: [0.25, 0.90],
              ),
              boxShadow: [
                BoxShadow(
                  color: Color(0xFF101012),
                  offset: Offset(-5, 5),
                  blurRadius: 8,
                ),
              ],
            ),
          ),
        ),
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
                          child: Column(
                              children: [Expanded(child: buildUser(user))]),
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
                              icon: Icon(Icons.map),
                              label: 'Mapa',
                              backgroundColor: Colors.green,
                              ),
                          BottomNavigationBarItem(
                              icon: Icon(Icons.qr_code), label: 'Scanner QR', backgroundColor: Colors.green,),
                          BottomNavigationBarItem(
                              icon: Icon(Icons.text_format), label: 'Blog', backgroundColor: Colors.green,),
                        ],
                      ),
                    );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      );

  Widget buildUser(UserM user) => Scaffold(
    body: Padding(
      padding: const EdgeInsets.all(0),
      child: ListView(
        children: [
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
            margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
            height: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              gradient: const LinearGradient(
                colors: [
                  Color.fromARGB(192, 120, 199, 30),
                  Color.fromARGB(157, 44, 83, 42),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                stops: [0.25, 0.90],
              ),
              boxShadow: const [
                BoxShadow(
                  color: Color(0xFF101012),
                  offset: Offset(-5, 5),
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
            margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
            height: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              gradient: const LinearGradient(
                colors: [
                  Color.fromARGB(192, 120, 199, 30),
                  Color.fromARGB(157, 44, 83, 42),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                stops: [0.25, 0.90],
              ),
              boxShadow: const [
                BoxShadow(
                  color: Color(0xFF101012),
                  offset: Offset(-5, 5),
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
            margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
            height: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              gradient: const LinearGradient(
                colors: [
                  Color.fromARGB(192, 120, 199, 30),
                  Color.fromARGB(157, 44, 83, 42),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                stops: [0.25, 0.90],
              ),
              boxShadow: const [
                BoxShadow(
                  color: Color(0xFF101012),
                  offset: Offset(-5, 5),
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
            margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
            height: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              gradient: const LinearGradient(
                colors: [
                  Color.fromARGB(192, 120, 199, 30),
                  Color.fromARGB(157, 44, 83, 42),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                stops: [0.25, 0.90],
              ),
              boxShadow: const [
                BoxShadow(
                  color: Color(0xFF101012),
                  offset: Offset(-5, 5),
                  blurRadius: 8,
                ),
              ],
            ),
            alignment: Alignment.centerLeft, //to align its child
            padding: const EdgeInsets.all(20),
            child: Text(
              'Cartón reciclado: ${user.carton}',
              style: const TextStyle(
                fontSize: 15,
                color: Colors.white,
                fontWeight: FontWeight.w200,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
            height: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              gradient: const LinearGradient(
                colors: [
                  Color.fromARGB(192, 120, 199, 30),
                  Color.fromARGB(157, 44, 83, 42),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                stops: [0.25, 0.90],
              ),
              boxShadow: const [
                BoxShadow(
                  color: Color(0xFF101012),
                  offset: Offset(-5, 5),
                  blurRadius: 8,
                ),
              ],
            ),
            alignment: Alignment.centerLeft, //to align its child
            padding: const EdgeInsets.all(20),
            child: Text(
              'Plástico reciclado: ${user.plastico}',
              style: const TextStyle(
                fontSize: 15,
                color: Colors.white,
                fontWeight: FontWeight.w200,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
            height: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              gradient: const LinearGradient(
                colors: [
                  Color.fromARGB(192, 120, 199, 30),
                  Color.fromARGB(157, 44, 83, 42),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                stops: [0.25, 0.90],
              ),
              boxShadow: const [
                BoxShadow(
                  color: Color(0xFF101012),
                  offset: Offset(-5, 5),
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
        ],
      ),
    ),
  );

  Stream<List<UserM>> readUsers() => FirebaseFirestore.instance
      .collection('users')
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => UserM.fromJson(doc.data())).toList());

  Future<UserM?> readUser() async {
    final docUser = FirebaseFirestore.instance
        .collection('users')
        .doc('fmXGtUKgGWfYQXbYRY2q');
    final snapshot = await docUser.get();

    if (snapshot.exists) {
      return UserM.fromJson(snapshot.data()!);
    }
  }
}
