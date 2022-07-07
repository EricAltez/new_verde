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
      .doc('FLfuMOeM7wkBWziXLQUs');
  final a =
      'https://media-private.canva.com/2i_-Y/MAFFrN2i_-Y/1/s.png?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAJWF6QO3UH4PAAJ6Q%2F20220706%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20220706T104318Z&X-Amz-Expires=50713&X-Amz-Signature=858058dbd805e5df9ad36f19c95584fd6887d9aded317efd52b1d2d9ae712e63&X-Amz-SignedHeaders=host&response-expires=Thu%2C%2007%20Jul%202022%2000%3A48%3A31%20GMT';
  final b =
      'https://media-private.canva.com/fOaE4/MAFFtjfOaE4/1/s.png?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAJWF6QO3UH4PAAJ6Q%2F20220706%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20220706T212246Z&X-Amz-Expires=47385&X-Amz-Signature=fdf42c0a68f279d8a29f19ad878ace5a5b26987f7b44c44ba20a5cadaf2114bf&X-Amz-SignedHeaders=host&response-expires=Thu%2C%2007%20Jul%202022%2010%3A32%3A31%20GMT';
  final c = 'https://media-private.canva.com/2Mqc4/MAFFtr2Mqc4/1/s.png?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAJWF6QO3UH4PAAJ6Q%2F20220707%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20220707T024247Z&X-Amz-Expires=28795&X-Amz-Signature=9a213e0ba2f7aa1ea0c36495e9549e2f115c4ef8a9373b492808806afda510e3&X-Amz-SignedHeaders=host&response-expires=Thu%2C%2007%20Jul%202022%2010%3A42%3A42%20GMT';
  final d =
      'https://media-private.canva.com/EBghI/MAFFtxEBghI/1/s.png?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAJWF6QO3UH4PAAJ6Q%2F20220706%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20220706T232522Z&X-Amz-Expires=68615&X-Amz-Signature=46805dc69f9843b101814c4217d3db68d2922b2f16f9cf60733312a4b2ffb2fd&X-Amz-SignedHeaders=host&response-expires=Thu%2C%2007%20Jul%202022%2018%3A28%3A57%20GMT';
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Home'),
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
