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
        leading: IconButton(icon:Icon(Icons.arrow_back),
        onPressed:() => Navigator.pop(context, false),
        // onPressed:() => exit(0),
        )
      ),
      body: Center(
        child: Expanded(
          child: Column(
            children: [
              InkWell(
                borderRadius: BorderRadius.circular(28),
                splashColor: Colors.black26,
                onTap: () {
                  Navigator.pushNamed(context, 'scanplastico');
                },
                child: Ink.image(
                  image: const AssetImage('images/botella.png'),
                  height: 130,
                  width: 180,
                  fit: BoxFit.cover,
                  child: const Text(
                    'Plástico',
                    style: TextStyle(fontSize: 32, color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              InkWell(
                borderRadius: BorderRadius.circular(28),
                splashColor: Colors.black26,
                onTap: () {
                  Navigator.pushNamed(context, 'scancarton');
                },
                child: Ink.image(
                  image: const AssetImage('images/carton.png'),
                  height: 130,
                  width: 180,
                  fit: BoxFit.cover,
                  child: const Text(
                    'Cartón',
                    style: TextStyle(fontSize: 32, color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              InkWell(
                borderRadius: BorderRadius.circular(28),
                splashColor: Colors.black26,
                onTap: () {
                  Navigator.pushNamed(context, 'scanorganico');
                },
                child: Ink.image(
                  image: const AssetImage('images/manzana.png'),
                  height: 130,
                  width: 180,
                  fit: BoxFit.cover,
                  child: const Text(
                    'Orgánicos',
                    style: TextStyle(fontSize: 32, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

  /*@override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          const Center(
            child: Text('Que vas a reciclar?'),
          ),
          const SizedBox(
            height: 20,
          ),
          MaterialButton(
              minWidth: 200,
              height: 200,
              color: Colors.lightGreen,
              onPressed: () => Navigator.pushNamed(context, 'scanorganico'),
              child: const Text('Escanear Organicos',
                  style: TextStyle(color: Colors.white))),
          const SizedBox(
            height: 20,
          ),
          MaterialButton(
              minWidth: 200,
              height: 200,
              color: Colors.lightGreen,
              onPressed: () => Navigator.pushNamed(context, 'scanplastico'),
              child: const Text('Escanear plásticos',
                  style: TextStyle(color: Colors.white))),
          const SizedBox(
            height: 20,
          ),
          MaterialButton(
              minWidth: 200,
              height: 200,
              color: Colors.lightGreen,
              onPressed: () => Navigator.pushNamed(context, 'scancarton'),
              child: const Text('Escanear cartón',
                  style: TextStyle(color: Colors.white))),
          const SizedBox(
            height: 20,
          ),
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
}*/