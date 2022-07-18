import 'package:flutter/material.dart';

class MapPage extends StatelessWidget {
  const MapPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Volver al inicio'),
        backgroundColor: Colors.green,
        automaticallyImplyLeading: true,
        leading: IconButton(icon:const Icon(Icons.arrow_back),
        onPressed:() => Navigator.pop(context, false),
        // onPressed:() => exit(0),
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
        body: Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('images/mapa.png'), fit: BoxFit.cover))));
  }
}
