// ignore_for_file: prefer_final_fields

import 'package:auth_app/services/util_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseService {
  FirebaseAuth _auth = FirebaseAuth.instance;
  UtilService _util = UtilService();

  signinWithEmailAndPassword(String email, String password) async {
    final authResult = await _auth.signInWithEmailAndPassword(
        email: email.trim(), password: password.trim());
    return authResult.user;
  }

  sendEmailVerification() async {
    final user = _auth.currentUser;
    user!.sendEmailVerification();
    _util.showToast("A Verification email has been sent");
  }

  resendEmailVerification() async {
    final user = _auth.currentUser;
    await user!.sendEmailVerification();
    _util.showToast(
        "A Verification Link Resend to your email kindly check your inbox");
  }

  createUserWithEmailAndPassword(String email, String password) async {
    final authResult = await _auth.createUserWithEmailAndPassword(
        email: email.trim(), password: password.trim());
    return authResult.user;
  }

  getFCMToken() async {
    final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
    _firebaseMessaging.requestPermission();
    String? token = await _firebaseMessaging.getToken();
    return token;
  }
}
