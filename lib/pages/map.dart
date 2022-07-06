import 'package:flutter/material.dart';

class MapPage extends StatelessWidget {
  const MapPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ir a la pagina anterior'),
        backgroundColor: Colors.lightGreen,
        automaticallyImplyLeading: true,
        leading: IconButton(icon:Icon(Icons.arrow_back),
        onPressed:() => Navigator.pop(context, false),
        // onPressed:() => exit(0),
        )
      ),
        body: Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('images/mapa.png'), fit: BoxFit.cover))));
  }
}
