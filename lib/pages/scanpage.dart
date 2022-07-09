import 'package:flutter/material.dart';

class ScanPage extends StatelessWidget {
  const ScanPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Volver al Home'),
        backgroundColor: Colors.lightGreen,
        automaticallyImplyLeading: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context, false),
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              InkWell(
                borderRadius: BorderRadius.circular(28),
                splashColor: Colors.black26,
                onTap: () {
                  Navigator.pushNamed(context, 'scanplastico');
                },
                child: Ink.image(
                  image: const AssetImage('images/botella.png'),
                  height: 240,
                  width: 180,
                  fit: BoxFit.cover,
                  child: const Center(
                    child: Text(
                      'Plástico',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 32, color: Colors.black),
                    ),
                  ),
                ),
              ),
              InkWell(
                borderRadius: BorderRadius.circular(28),
                splashColor: Colors.black26,
                onTap: () {
                  Navigator.pushNamed(context, 'scancarton');
                },
                child: Ink.image(
                  image: const AssetImage('images/carton.png'),
                  height: 240,
                  width: 180,
                  fit: BoxFit.cover,
                  child: const Center(
                    child: Text(
                      'Cartón',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 32, color: Colors.black),
                    ),
                  ),
                ),
              ),
            ],
          ),
          InkWell(
            borderRadius: BorderRadius.circular(28),
            onTap: () {
              Navigator.pushNamed(context, 'scanorganico');
            },
            child: Ink.image(
              image: const AssetImage('images/manzana.png'),
              height: 240,
              width: 180,
              fit: BoxFit.cover,
              child: const Center(
                child: Text(
                  'Orgánicos',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 32, color: Colors.black),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

