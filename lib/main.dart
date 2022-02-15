// ignore_for_file: prefer_const_constructors

import 'package:auth_app/provider/authProvider.dart';
import 'package:auth_app/provider/jobProvider.dart';
import 'package:auth_app/utils/lcoator.dart';
import 'package:auth_app/utils/routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_portal/flutter_portal.dart';

import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  setUpLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AuthProvider(),
        ),
        ChangeNotifierProvider(create: (_) => JobProvider()),
      ],
      child: Portal(
        child: MaterialApp(
          title: 'Assignment 1',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          onGenerateRoute: onGenerateRoute,
          initialRoute: SignInScreenRoute,
        ),
      ),
    );
  }
}
