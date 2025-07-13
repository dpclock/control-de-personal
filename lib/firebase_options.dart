import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
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
        return windows;
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
    apiKey: 'AIzaSyDdNOqaHG4XNjSfkQx1PiKjuL6ASkqz0DA',
    appId: '1:505387942892:web:a5ea8520733ee066aab6c9',
    messagingSenderId: '505387942892',
    projectId: 'dpclock-3482b',
    authDomain: 'dpclock-3482b.firebaseapp.com',
    storageBucket: 'dpclock-3482b.firebasestorage.app',
    measurementId: 'G-3RT9NHCJ8S',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDdNOqaHG4XNjSfkQx1PiKjuL6ASkqz0DA',
    appId: '1:505387942892:android:your-android-app-id',
    messagingSenderId: '505387942892',
    projectId: 'dpclock-3482b',
    storageBucket: 'dpclock-3482b.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDdNOqaHG4XNjSfkQx1PiKjuL6ASkqz0DA',
    appId: '1:505387942892:ios:your-ios-app-id',
    messagingSenderId: '505387942892',
    projectId: 'dpclock-3482b',
    storageBucket: 'dpclock-3482b.firebasestorage.app',
    iosBundleId: 'com.example.controlDePersonal',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDdNOqaHG4XNjSfkQx1PiKjuL6ASkqz0DA',
    appId: '1:505387942892:ios:your-macos-app-id',
    messagingSenderId: '505387942892',
    projectId: 'dpclock-3482b',
    storageBucket: 'dpclock-3482b.firebasestorage.app',
    iosBundleId: 'com.example.controlDePersonal',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDdNOqaHG4XNjSfkQx1PiKjuL6ASkqz0DA',
    appId: '1:505387942892:windows:your-windows-app-id',
    messagingSenderId: '505387942892',
    projectId: 'dpclock-3482b',
    storageBucket: 'dpclock-3482b.firebasestorage.app',
  );
} 