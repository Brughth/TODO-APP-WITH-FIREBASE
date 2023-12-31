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
    apiKey: 'AIzaSyAKRIEFfQXfG48mOraJl8qZmSx8zYpaQqo',
    appId: '1:1058786288074:web:79fcc321d265b6e9f32f33',
    messagingSenderId: '1058786288074',
    projectId: 'todo-list-app-6f3a9',
    authDomain: 'todo-list-app-6f3a9.firebaseapp.com',
    storageBucket: 'todo-list-app-6f3a9.appspot.com',
    measurementId: 'G-VMCZLDEG7P',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBEwnKFKRXAryKWp0VHgCfmQCJkUOGwt-0',
    appId: '1:1058786288074:android:b01c07ab770e6940f32f33',
    messagingSenderId: '1058786288074',
    projectId: 'todo-list-app-6f3a9',
    storageBucket: 'todo-list-app-6f3a9.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCFYVzo6ZX0pizWJBbKJrb9ViIpLYUoiJU',
    appId: '1:1058786288074:ios:67218392eda216a8f32f33',
    messagingSenderId: '1058786288074',
    projectId: 'todo-list-app-6f3a9',
    storageBucket: 'todo-list-app-6f3a9.appspot.com',
    iosClientId: '1058786288074-u50g70e4j3t857uomiq70e12a4tp1q18.apps.googleusercontent.com',
    iosBundleId: 'com.example.todoAppWithFirebase',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCFYVzo6ZX0pizWJBbKJrb9ViIpLYUoiJU',
    appId: '1:1058786288074:ios:8607b9c37e5dc049f32f33',
    messagingSenderId: '1058786288074',
    projectId: 'todo-list-app-6f3a9',
    storageBucket: 'todo-list-app-6f3a9.appspot.com',
    iosClientId: '1058786288074-qisscrje2f0olabv9nel8jtsuetqjnb7.apps.googleusercontent.com',
    iosBundleId: 'com.example.todoAppWithFirebase.RunnerTests',
  );
}
