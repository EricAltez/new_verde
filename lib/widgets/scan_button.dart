import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ScanButton extends StatelessWidget {
  const ScanButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    final CollectionReference records =
        FirebaseFirestore.instance.collection('users');

    return FloatingActionButton(
      elevation: 0,
      onPressed: () async {
        try {
          await records.add({
            "user": userId,
          });
        } catch (e) {
          showDialog(
            context: context,
            builder: (_) => AlertDialog(
              actions: [
                MaterialButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cerrar'),
                )
              ],
              title: const Text('Error al incluir registro'),
            ),
          );
        }

        // String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
        //   '#3D8BEF',
        //   'Cancelar',
        //   false,
        //   ScanMode.QR,
        // );

        // print(barcodeScanRes);
      },
      child: const Icon(Icons.filter_center_focus),
    );
  }
}