import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class ScanOrganico extends StatefulWidget {
  const ScanOrganico({Key? key}) : super(key: key);

  @override
  State<ScanOrganico> createState() => _ScannerState();
}

class _ScannerState extends State<ScanOrganico> {
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
        appBar: AppBar(title: const Text('QR scan')),
        body: Builder(
          builder: (BuildContext context) {
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
                    } else if (_scanBarcode == 'verde organico') {
                        docUser.update({'points': FieldValue.increment(1)});
                        docUser.update({'organico': FieldValue.increment(1)});
                      return "Bien hecho!! Reciclaste material orgánico.";
                    }
                    return "Recipente incorrecto";
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

class ScanOrganico extends StatelessWidget {
  const ScanOrganico({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Center(
            child: Text('scan o'),
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
