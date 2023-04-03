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
    apiKey: 'AIzaSyCHujIAvZXGfcENA8P3NfxOfan8mYmMr8Y',
    appId: '1:383923535430:web:62b0f47800746f2fd19447',
    messagingSenderId: '383923535430',
    projectId: 'schoner-tag-project',
    authDomain: 'schoner-tag-project.firebaseapp.com',
    storageBucket: 'schoner-tag-project.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAD4FUyGryxyA5yT8XRsordJBfAWigl6_s',
    appId: '1:383923535430:android:0b81b4727f9180ced19447',
    messagingSenderId: '383923535430',
    projectId: 'schoner-tag-project',
    storageBucket: 'schoner-tag-project.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDcNuccWTJ5ihyFld3leNIvr6o337gASxw',
    appId: '1:383923535430:ios:4daea5f45d676cded19447',
    messagingSenderId: '383923535430',
    projectId: 'schoner-tag-project',
    storageBucket: 'schoner-tag-project.appspot.com',
    iosClientId: '383923535430-q8p4dk6k6l7j9hn9rt33mm3of2tjukbe.apps.googleusercontent.com',
    iosBundleId: 'com.example.schonerTag',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDcNuccWTJ5ihyFld3leNIvr6o337gASxw',
    appId: '1:383923535430:ios:4daea5f45d676cded19447',
    messagingSenderId: '383923535430',
    projectId: 'schoner-tag-project',
    storageBucket: 'schoner-tag-project.appspot.com',
    iosClientId: '383923535430-q8p4dk6k6l7j9hn9rt33mm3of2tjukbe.apps.googleusercontent.com',
    iosBundleId: 'com.example.schonerTag',
  );
}