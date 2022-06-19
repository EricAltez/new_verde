import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';

import 'package:new_verde/services/tab_navigation_handler.dart';
import 'pages/index.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TabNavigatorHandler()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute:
            FirebaseAuth.instance.currentUser != null ? 'home' : 'login',
        routes: {
          'home': (_) => const HomePage(),
          'login': (_) => const LoginPage(),
          'mapa': (_) => const MapPage(),
        },
        theme: ThemeData.light().copyWith(
          colorScheme:
              ThemeData().colorScheme.copyWith(primary: Colors.deepPurple),
          floatingActionButtonTheme: const FloatingActionButtonThemeData(
            backgroundColor: Colors.deepPurple,
          ),
        ),
      ),
    );
  }
}