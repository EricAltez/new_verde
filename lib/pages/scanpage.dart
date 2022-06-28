import 'dart:html';

import 'package:flutter/material.dart';

class ScanPage extends StatelessWidget {
  const ScanPage({Key? key}) : super(key: key);

  /*@override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: InkWell(
            borderRadius: BorderRadius.circular(28),
            splashColor: Colors.black26,
            onTap: () {},
            child: Ink.image(
              image: AssetImage('images/manzana.jpg'),
                  height: 200,
                  width: 200,
                  fit: BoxFit.cover,
                  child: Text(
                    'Orgánicos',
                    style: TextStyle(fontSize: 32, color: Colors.white),
                  ),
                ),
          )
          ),
    );
  }
}*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Center(
            child: Text('Que vas a reciclar?'),
          ),
          SizedBox(height: 20,),
          MaterialButton(
            minWidth: 200,
            height: 200,
            color: Colors.lightGreen,
            onPressed: () => Navigator.pushNamed(context, 'scanorganico'),
            child: Text('Escanear Organicos',style: TextStyle(color: Colors.white))
          ),
          SizedBox(height: 20,),
          MaterialButton(
            minWidth: 200,
            height: 200,
            color: Colors.lightGreen,
            onPressed: () => Navigator.pushNamed(context, 'scanplastico'),
            child: Text('Escanear plásticos',style: TextStyle(color: Colors.white))
          ),
          SizedBox(height: 20,),
          MaterialButton(
            minWidth: 200,
            height: 200,
            color: Colors.lightGreen,
            onPressed: () => Navigator.pushNamed(context, 'scancarton'),
            child: Text('Escanear cartón',style: TextStyle(color: Colors.white))
          ),
          SizedBox(height: 20,),
          ElevatedButton(
            child: const Text('Volver al inicio'),
            onPressed: () {
            Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
