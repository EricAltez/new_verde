import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class CartonScan extends StatefulWidget {
  const CartonScan({Key? key}) : super(key: key);

  @override
  State<CartonScan> createState() => _ScannerState();
}

class _ScannerState extends State<CartonScan> {
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

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> scanBarcodeNormal() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.BARCODE);
      if (barcodeScanRes == 'scancarton') {
        print('Bien hecho!! Reciclaste cartón.');
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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
            title: const Text('Escanner QR Cartón'),
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
        body: Builder(
          builder: (BuildContext context) {
            return Padding(
              padding: const EdgeInsets.all(20),
              child: Container(
              alignment: Alignment.center,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
                    child: Column(
                      children: <Widget>[
                        ListTile(
                          // leading: Icon(Icons.photo_album, color: Colors.blue),
                          title: Text("Modo correcto de reciclar cartón"),
                          subtitle: Text(
                              "Debe estar seco y limpio."),
                        ),
                      ],
                    ),
                  ),
                  ElevatedButton(
                      onPressed: () => scanQR(),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.green,
                        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                        textStyle: const TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                      child: const Text('Escanear QR')),
                  Text((() {
                    if (_scanBarcode == "Unknown") {
                      return "";
                    } else if (_scanBarcode == 'verde carton') {
                      docUser.update({'points': FieldValue.increment(1)});
                      docUser.update({'carton': FieldValue.increment(1)});
                      return "Bien hecho!! Reciclaste cartón.";
                    }
                    return "Recipiente incorrecto";
                  })())
                ],
              ),
            ));
          },
        ),
      ),
    );
  }
}