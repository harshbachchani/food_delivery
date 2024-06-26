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
    apiKey: 'AIzaSyBAF_BURtbsX6gQVyOaxE7sUfvmxcdLAac',
    appId: '1:705446619139:web:1e516fe3a19c15ff7c8636',
    messagingSenderId: '705446619139',
    projectId: 'zapto-76990',
    authDomain: 'zapto-76990.firebaseapp.com',
    storageBucket: 'zapto-76990.appspot.com',
    measurementId: 'G-8N9R2GLWZP',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBR19uVmgejhGT0PvP7Q613YTPgF7KVFd8',
    appId: '1:705446619139:android:040e8a4457fc24bb7c8636',
    messagingSenderId: '705446619139',
    projectId: 'zapto-76990',
    storageBucket: 'zapto-76990.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBHxwCt_ZNSXqNZSa7c31HuTV3kyZ2lf2E',
    appId: '1:705446619139:ios:fa0b4c3b0f9147157c8636',
    messagingSenderId: '705446619139',
    projectId: 'zapto-76990',
    storageBucket: 'zapto-76990.appspot.com',
    iosBundleId: 'com.example.foodDelivery',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBHxwCt_ZNSXqNZSa7c31HuTV3kyZ2lf2E',
    appId: '1:705446619139:ios:755972ec04a792d07c8636',
    messagingSenderId: '705446619139',
    projectId: 'zapto-76990',
    storageBucket: 'zapto-76990.appspot.com',
    iosBundleId: 'com.example.foodDelivery.RunnerTests',
  );
}
