import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user_model.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Stream để theo dõi trạng thái đăng nhập
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  // Đăng ký tài khoản mới
  Future<UserModel?> signUp({
    required String email,
    required String password,
    String? displayName,
  }) async {
    try {
      final UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (result.user != null) {
        // Tạo document user trong Firestore
        final UserModel newUser = UserModel(
          uid: result.user!.uid,
          email: email,
          displayName: displayName,
          createdAt: DateTime.now(),
          lastLoginAt: DateTime.now(),
        );

        await _firestore
            .collection('users')
            .doc(result.user!.uid)
            .set(newUser.toMap());

        return newUser;
      }
    } catch (e) {
      rethrow;
    }
    return null;
  }

  // Đăng nhập
  Future<UserModel?> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final UserCredential result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (result.user != null) {
        // Cập nhật thời gian đăng nhập cuối
        await _firestore.collection('users').doc(result.user!.uid).update({
          'lastLoginAt': DateTime.now(),
        });

        // Lấy thông tin user từ Firestore
        final doc = await _firestore
            .collection('users')
            .doc(result.user!.uid)
            .get();
        
        return UserModel.fromMap({...doc.data()!, 'uid': result.user!.uid});
      }
    } catch (e) {
      rethrow;
    }
    return null;
  }

  // Đăng xuất
  Future<void> signOut() async {
    await _auth.signOut();
  }
} 