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
  final a =
      'https://media-private.canva.com/h0RjI/MAFEzYh0RjI/1/s.png?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAJWF6QO3UH4PAAJ6Q%2F20220626%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20220626T214625Z&X-Amz-Expires=74394&X-Amz-Signature=e7bbb89b7d1438fd153f68678804f2fe645fc20e26869b8cc54e3d1b708055cf&X-Amz-SignedHeaders=host&response-expires=Mon%2C%2027%20Jun%202022%2018%3A26%3A19%20GMT';
  final b =
      'https://media-private.canva.com/Nwpac/MAFE3fNwpac/1/s.png?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAJWF6QO3UH4PAAJ6Q%2F20220628%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20220628T031807Z&X-Amz-Expires=21967&X-Amz-Signature=1c5ae478b4af121de6c101b63e1c9c3a2a7ad6b5c27224804ab7d0c5774c387b&X-Amz-SignedHeaders=host&response-expires=Tue%2C%2028%20Jun%202022%2009%3A24%3A14%20GMT';
  final c =
      'https://media-private.canva.com/BEzfY/MAFE3WBEzfY/1/s.png?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAJWF6QO3UH4PAAJ6Q%2F20220627%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20220627T072451Z&X-Amz-Expires=93481&X-Amz-Signature=16b242a0a060c8ed553f7869fd1849fa87580f8d10f5b31809896014d591119c&X-Amz-SignedHeaders=host&response-expires=Tue%2C%2028%20Jun%202022%2009%3A22%3A52%20GMT';
  final d =
      'https://media-private.canva.com/Df1Gs/MAFE3cDf1Gs/1/s.png?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAJWF6QO3UH4PAAJ6Q%2F20220628%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20220628T000235Z&X-Amz-Expires=33808&X-Amz-Signature=ed7668a7e53b472614d8a12ee05d87b0d2209f7e3dd8add1b8852e2ba3a3e67b&X-Amz-SignedHeaders=host&response-expires=Tue%2C%2028%20Jun%202022%2009%3A26%3A03%20GMT';
  @override
  Widget build(BuildContext context) => Scaffold(
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
                            Image.network(
                              a,
                              alignment: Alignment.topCenter,
                              height: 300,
                            ),
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

  void buildImage(user) {
    if (user.points < 50) {
      a;
    } else if (user.points < 100) {
      b;
    } else if (user.points < 150) {
      c;
    } else {
      d;
    }
  }

  Widget buildUser(UserM user) => Padding(
      padding: const EdgeInsets.all(15),
      child: ListView(children: [
        Container(
          margin: EdgeInsets.all(30),
          height: 60,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: new LinearGradient(
              colors: [
                Color.fromARGB(255, 51, 255, 44),
                Color.fromARGB(255, 131, 236, 127),
              ],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              stops: [0.25, 0.90],
            ),
            boxShadow: [
              BoxShadow(
                color: Color(0xFF101012),
                offset: Offset(-12, 12),
                blurRadius: 8,
              ),
            ],
          ),
          alignment: Alignment.centerLeft, //to align its child
          padding: EdgeInsets.all(20),
          child: Text(
            'Bienvenido: ${user.name}',
            style: TextStyle(
              fontSize: 15,
              color: Colors.white,
              fontWeight: FontWeight.w200,
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
        Container(
         margin: EdgeInsets.all(30),
          height: 60,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: new LinearGradient(
              colors: [
                Color.fromARGB(255, 51, 255, 44),
                Color.fromARGB(255, 131, 236, 127),
              ],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              stops: [0.25, 0.90],
            ),
            boxShadow: [
              BoxShadow(
                color: Color(0xFF101012),
                offset: Offset(-12, 12),
                blurRadius: 8,
              ),
            ],
          ),
          alignment: Alignment.centerLeft, //to align its child
          padding: EdgeInsets.all(20),
          child: Text(
            'Reciclaje total: ${user.plastico + user.carton + user.organico}',
            style: TextStyle(
              fontSize: 15,
              color: Colors.white,
              fontWeight: FontWeight.w200,
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.all(30),
          height: 60,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: new LinearGradient(
              colors: [
                Color.fromARGB(255, 51, 255, 44),
                Color.fromARGB(255, 131, 236, 127),
              ],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              stops: [0.25, 0.90],
            ),
            boxShadow: [
              BoxShadow(
                color: Color(0xFF101012),
                offset: Offset(-12, 12),
                blurRadius: 8,
              ),
            ],
          ),
          alignment: Alignment.centerLeft, //to align its child
          padding: EdgeInsets.all(20),
          child: Text(
            'Puntaje total: ${user.points}',
            style: TextStyle(
              fontSize: 15,
              color: Colors.white,
              fontWeight: FontWeight.w200,
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.all(30),
          height: 60,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: new LinearGradient(
              colors: [
                Color.fromARGB(255, 51, 255, 44),
                Color.fromARGB(255, 131, 236, 127),
              ],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              stops: [0.25, 0.90],
            ),
            boxShadow: [
              BoxShadow(
                color: Color(0xFF101012),
                offset: Offset(-12, 12),
                blurRadius: 8,
              ),
            ],
          ),
          alignment: Alignment.centerLeft, //to align its child
          padding: EdgeInsets.all(20),
          child: Text(
            'Carton reciclado: ${user.carton}',
            style: TextStyle(
              fontSize: 15,
              color: Colors.white,
              fontWeight: FontWeight.w200,
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
        Container(
         margin: EdgeInsets.all(30),
          height: 60,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: new LinearGradient(
              colors: [
                Color.fromARGB(255, 51, 255, 44),
                Color.fromARGB(255, 131, 236, 127),
              ],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              stops: [0.25, 0.90],
            ),
            boxShadow: [
              BoxShadow(
                color: Color(0xFF101012),
                offset: Offset(-12, 12),
                blurRadius: 8,
              ),
            ],
          ),
          alignment: Alignment.centerLeft, //to align its child
          padding: EdgeInsets.all(20),
          child: Text(
            'Plastico reciclado: ${user.plastico}',
            style: TextStyle(
              fontSize: 15,
              color: Colors.white,
              fontWeight: FontWeight.w200,
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.all(30),
          height: 60,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: new LinearGradient(
              colors: [
                Color.fromARGB(255, 51, 255, 44),
                Color.fromARGB(255, 131, 236, 127),
              ],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              stops: [0.25, 0.90],
            ),
            boxShadow: [
              BoxShadow(
                color: Color(0xFF101012),
                offset: Offset(-12, 12),
                blurRadius: 8,
              ),
            ],
          ),
          alignment: Alignment.centerLeft, //to align its child
          padding: EdgeInsets.all(20),
          child: Text(
            'Material orgánico reciclado: ${user.organico}',
            style: TextStyle(
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
      ]));
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
