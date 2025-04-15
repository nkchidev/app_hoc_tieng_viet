import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    // TODO: Thay thế các giá trị này bằng thông tin cấu hình Firebase của bạn
    return const FirebaseOptions(
      apiKey: 'AIzaSyBzwnf68m14NRi0Z5VDK0iNAzWuLqlnLSA',
      appId: '1:1064906268705:android:cccac159c79f57d02c4360',
      messagingSenderId: '1064906268705',
      projectId: 'app-learning-vietnamese',
      authDomain: 'app-learning-vietnamese.firebaseapp.com',
      storageBucket: 'app-learning-vietnamese.firebasestorage.app',
    );
  }
} 