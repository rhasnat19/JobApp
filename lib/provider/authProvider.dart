// ignore_for_file: file_names, prefer_final_fields, avoid_print, unused_local_variable, unnecessary_this, prefer_const_constructors, avoid_function_literals_in_foreach_calls
import 'dart:io';

import 'package:auth_app/models/auth_user.dart';
import 'package:auth_app/provider/jobProvider.dart';
import 'package:auth_app/screens/add_new_job.dart';
import 'package:auth_app/screens/job_list.dart';
import 'package:auth_app/screens/signIn.dart';
import 'package:auth_app/services/firebase_service.dart';
import 'package:auth_app/services/navigation_service.dart';
import 'package:auth_app/services/util_services.dart';
import 'package:auth_app/utils/routes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';

class AuthProvider with ChangeNotifier {
  // FirebaseAuth auth = FirebaseAuth.instance;
  NavigationService navigationService = NavigationService();
  FirebaseService _firebase = FirebaseService();
  UtilService utilService = UtilService();
  AuthUser? user;

  Future<void> createUserWithEmailPassword(
    String email,
    String password,
    String fullName,
    BuildContext context,
  ) async {
    try {
      final firebaseUser =
          await _firebase.createUserWithEmailAndPassword(email, password);
      var token = await firebaseUser.getIdToken(true);

      this.user = AuthUser(
        email: firebaseUser!.email,
        fullName: fullName,
        id: firebaseUser.uid,
      );
      Map<String, dynamic> userData = {
        'createdOnDate': DateTime.now().millisecondsSinceEpoch.toString(),
        'fullName': fullName,
        'email': user!.email,
      };
      await FirebaseFirestore.instance.collection("Users").add(userData);
      utilService.showToast("Sign Up Successfully! now please login");
      Navigator.of(context).pop();
      Navigator.of(context).pop();
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (BuildContext ctx) => SignIn()));
    } on FirebaseAuthException catch (err) {
      utilService.showToast(err.message.toString());
    }
  }

  Future<void> signinWithEmailAndPassword(
      String? email, String? password, BuildContext context) async {
    try {
      final firebaseUser =
          await _firebase.signinWithEmailAndPassword(email!, password!);
      var token = await firebaseUser.getIdToken();
      this.user = AuthUser(
        email: firebaseUser.email,
        id: firebaseUser.uid,
        // fullName: firebaseUser.fullName,
      );
      await FirebaseFirestore.instance.collection('Users').get().then((value) {
        value.docs.forEach((element) {
          if (element.data()['email'] == email) {
            this.user = AuthUser(
              fullName: value.docs.first.data()['fullName'],
            );
          }
        });
      });
      await context.read<JobProvider>().getAllJobsFromFirebase();

      utilService.showToast("Sign in Successfully!");

      Navigator.of(context).pop();
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (BuildContext ctx) => JobList(),
        ),
      );

      print("user token: $token");
    } on FirebaseAuthException catch (err) {
      utilService.showToast(err.message.toString());
    }
  }

  Future<void> logoutFirebaseUser(BuildContext context) async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    await _auth.signOut();

    // stopStream();

    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (BuildContext ctx) => SignIn()),
        (route) => false);
  }
}
