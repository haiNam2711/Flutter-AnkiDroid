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
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCjPqF-nWsEOL_yRV4Ba4ByPSwNcRSRlA0',
    appId: '1:58210022238:android:87c4fdddf9c7dc5c0bd5cf',
    messagingSenderId: '58210022238',
    projectId: 'flutter-ankidroid-2bb2f',
    storageBucket: 'flutter-ankidroid-2bb2f.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBhXDS-43DCK7Bk9qFUDR_AWX7dTq1kuTo',
    appId: '1:58210022238:ios:d5175074a6bd52790bd5cf',
    messagingSenderId: '58210022238',
    projectId: 'flutter-ankidroid-2bb2f',
    storageBucket: 'flutter-ankidroid-2bb2f.appspot.com',
    iosClientId: '58210022238-0h27ef0j85aje5int7bruhhiqp29h99t.apps.googleusercontent.com',
    iosBundleId: 'com.example.fiveControlWidget',
  );
}
