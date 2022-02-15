// ignore_for_file: constant_identifier_names

import 'package:auth_app/screens/add_new_job.dart';
import 'package:auth_app/screens/edit_job.dart';
import 'package:auth_app/screens/signIn.dart';
import 'package:auth_app/screens/signUp.dart';
import 'package:flutter/material.dart';


const SignUpScreenRoute = '/sign-up';
const SignInScreenRoute = '/sign-in';
const EditJobScreenRoute = '/edit-screen';
const AddNewJobRoute = '/add-new-job-route';
Route<dynamic> onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case SignUpScreenRoute:
      return MaterialPageRoute(builder: (BuildContext context) => SignUp());
    case SignInScreenRoute:
      return MaterialPageRoute(builder: (BuildContext context) => SignIn());
    case EditJobScreenRoute:
      return MaterialPageRoute(builder: (BuildContext context) => EditJob());
    case AddNewJobRoute:
      return MaterialPageRoute(builder: (BuildContext context) => AddNewJob());
    default:
      return MaterialPageRoute(builder: (BuildContext context) => SignIn());
  }
}
