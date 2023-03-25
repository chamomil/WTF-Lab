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
        return macos;
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
    apiKey: 'AIzaSyCMzkFzTU15jrvz7zYhev7XWN5ibMTrBlA',
    appId: '1:165493054205:web:caf988d65f4ec2c1d7bc94',
    messagingSenderId: '165493054205',
    projectId: 'coolchatjournal',
    authDomain: 'coolchatjournal.firebaseapp.com',
    storageBucket: 'coolchatjournal.appspot.com',
    measurementId: 'G-JEE8LKDT3H',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCg89KWVzYdyMSDFe6q-wAkBj8N8w2P4lI',
    appId: '1:165493054205:android:6166465164c35178d7bc94',
    messagingSenderId: '165493054205',
    projectId: 'coolchatjournal',
    storageBucket: 'coolchatjournal.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBMGrxFZg7K7bgwK4QaFjRMTyK-h7XZ6Lk',
    appId: '1:165493054205:ios:5a3693cc196e6986d7bc94',
    messagingSenderId: '165493054205',
    projectId: 'coolchatjournal',
    storageBucket: 'coolchatjournal.appspot.com',
    iosClientId:
        '165493054205-ip7cu4u85nngc6oi2plo1ilt6mo58h1n.apps.googleusercontent.com',
    iosBundleId: 'com.example.coolChatJournal',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBMGrxFZg7K7bgwK4QaFjRMTyK-h7XZ6Lk',
    appId: '1:165493054205:ios:5a3693cc196e6986d7bc94',
    messagingSenderId: '165493054205',
    projectId: 'coolchatjournal',
    storageBucket: 'coolchatjournal.appspot.com',
    iosClientId:
        '165493054205-ip7cu4u85nngc6oi2plo1ilt6mo58h1n.apps.googleusercontent.com',
    iosBundleId: 'com.example.coolChatJournal',
  );
}