import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:new_verde/pages/map.dart';
import 'package:new_verde/widgets/utils.dart';
import 'pages/index.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const MyApp());
}

final navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return MaterialApp(
      scaffoldMessengerKey: Utils.messengerKey,
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      initialRoute: user != null ? 'home' : 'login',
      routes: {
        'home': (_) =>  const HomePage(),
        'login': (_) => const LoginPage(),
        'mappage': (_) => const MapPage(),
        'scancarton': (_) => const CartonScan(),
        'scanorganico': (_) => const ScanOrganico(),
        'scanpage': (_) => const ScanPage(),
        'scanplastico': (_) => const ScanPlastico(),
        'signup': (_) => const SignUpPage(),
      },
    );
  }
}


