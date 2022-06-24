import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'firebase_options.dart';
import 'package:new_verde/pages/map.dart';
import 'package:new_verde/widgets/utils.dart';
import 'pages/index.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const MyApp());
}

final navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => MaterialApp(
      scaffoldMessengerKey: Utils.messengerKey,
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      initialRoute: 'home',
      routes: {
        'address': (_) => const AddressPage(),
        'home': (_) => const UserPage(),
        'mappage': (_) => const MapPage(),
        'scancarton': (_) => const CartonScan(),
        'scanorganico': (_) => const OrganicoScan(),
        'scanpage': (_) => const ScanPage(),
        'scanplastico': (_) => const PlasticoScan(),
      },
    );
      
}
