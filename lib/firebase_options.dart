// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyChIWO9Gf2lb9sEdHw1NoQncbgAPEJmrvQ',
    appId: '1:698186693362:web:66b1294fd40dd719652e6b',
    messagingSenderId: '698186693362',
    projectId: 'new-verde',
    authDomain: 'new-verde.firebaseapp.com',
    storageBucket: 'new-verde.appspot.com',
    measurementId: 'G-608WY0KM7L',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBUi26Z8QBsKRbgtBtLWlEcZlqQK-DBTsA',
    appId: '1:698186693362:android:70a4efc33ba80108652e6b',
    messagingSenderId: '698186693362',
    projectId: 'new-verde',
    storageBucket: 'new-verde.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAG_5Q3UJbASVwO9HuzMa1SICN0NO3TMOQ',
    appId: '1:698186693362:ios:9db8b1d976f6f767652e6b',
    messagingSenderId: '698186693362',
    projectId: 'new-verde',
    storageBucket: 'new-verde.appspot.com',
    iosClientId: '698186693362-8b4uaqhcbaj65r2vlol2umo6ke29hk2a.apps.googleusercontent.com',
    iosBundleId: 'com.example.newVerde',
  );
}
