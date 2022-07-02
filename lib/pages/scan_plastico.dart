import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:new_verde/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class ScanPlastico extends StatefulWidget {
  const ScanPlastico({Key? key}) : super(key: key);

  @override
  State<ScanPlastico> createState() => _ScannerState();
}

class _ScannerState extends State<ScanPlastico> {
  String _scanBarcode = 'Unknown';
  final docUser = FirebaseFirestore.instance
      .collection('users')
      .doc('FLfuMOeM7wkBWziXLQUs');

  @override
  void initState() {
    super.initState();
  }

  //Consultar este bloque con Eric.
  Future<void> startBarcodeScanStream() async {
    FlutterBarcodeScanner.getBarcodeStreamReceiver(
            '#ff6666', 'Cancel', true, ScanMode.BARCODE)!
        .listen((barcode) => print(barcode));
  }

  Future<void> scanQR() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.QR);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _scanBarcode = barcodeScanRes;
    });
  }

/*
  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> scanBarcodeNormal() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.BARCODE);
      if (barcodeScanRes == 'verde plastico') {
        print('Bien hecho!! Reciclaste plastico.');
      }
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _scanBarcode = barcodeScanRes;
    });
  }
*/

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: const Text('QR scan')),
        body: Builder(
          builder: (BuildContext context) {
            var res = _scanBarcode;
            return Container(
              alignment: Alignment.center,
              child: Flex(
                direction: Axis.vertical,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ElevatedButton(
                      onPressed: () => scanQR(),
                      child: const Text('Start QR scan')),
                  Text((() {
                    if (_scanBarcode == "Unknown") {
                      return "";
                    } else if (_scanBarcode == 'verde plastico') {
                      return "Bien hecho!! Reciclaste plastico.";
                    }
                    return "Recipiente incorrecto";
                  })())
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}


/*import 'package:flutter/material.dart';

class ScanPlastico extends StatelessWidget {
  const ScanPlastico({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Center(
            child: Text('scan p'),
          ),
          TextButton(
            child: const Text('Volver'),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}*/
