// ignore_for_file: prefer_const_constructors_in_immutables, file_names, prefer_const_constructors, prefer_const_literals_to_create_immutables, must_be_immutable

import 'package:auth_app/gloabals.dart';
import 'package:auth_app/provider/authProvider.dart';
import 'package:auth_app/provider/jobProvider.dart';
import 'package:auth_app/screens/add_new_job.dart';
import 'package:auth_app/screens/signUp.dart';
import 'package:auth_app/services/util_services.dart';
import 'package:auth_app/utils/lcoator.dart';
import 'package:auth_app/widgets/column_scroll_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';

class SignIn extends StatefulWidget {
  SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  bool showPassword = true;
  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  var utilService = locator<UtilService>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: ColumnScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TitleWidget(
                      text: "Let's sign you in",
                      size: 38,
                      weight: FontWeight.bold,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TitleWidget(
                      text: "Welcome back\nyou've been missed!",
                      size: 30,
                      weight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(
                    height: 60,
                  ),
                  TextField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    style: TextStyle(color: Colors.white, fontSize: 14),
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey.shade900,
                        hintText: "Enter your emailAddress",
                        hintStyle: TextStyle(
                            color: Colors.grey.shade500, fontSize: 14),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(
                                color: Colors.grey.shade500, width: 1)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(
                                color: Colors.grey.shade500, width: 1))),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextField(
                    obscureText: showPassword,
                    controller: passwordController,
                    obscuringCharacter: '*',
                    style: TextStyle(color: Colors.white, fontSize: 14),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey.shade900,
                      hintText: "Enter your password",
                      hintStyle:
                          TextStyle(color: Colors.grey.shade500, fontSize: 14),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                              color: Colors.grey.shade500, width: 1)),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide:
                            BorderSide(color: Colors.grey.shade500, width: 1),
                      ),
                      suffixIcon: !showPassword
                          ? IconButton(
                              icon: Icon(
                                Icons.visibility_off,
                                size: 15,
                                color: Colors.grey.shade500,
                              ),
                              onPressed: () {
                                setState(() {
                                  showPassword = true;
                                });
                              },
                            )
                          : IconButton(
                              icon: Icon(
                                Icons.visibility,
                                size: 15,
                                color: Colors.grey.shade500,
                              ),
                              onPressed: () {
                                setState(() {
                                  showPassword = false;
                                });
                              },
                            ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account? ",
                        style: TextStyle(
                            color: Colors.grey.shade500, fontSize: 14),
                      ),
                      InkWell(
                          onTap: () async {
                            showLoadingAnimation(context);
                           
                            Navigator.of(context).pop();
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => SignUp()),
                            );
                          },
                          child: Text(
                            'Register',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w500),
                          ))
                    ],
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  ElevatedButton(
                      onPressed: () async {
                        if (passwordController.text.length < 6) {
                          utilService.showToast(
                              "Password must be greater than 6 characters");
                        } else if (!RegExp(
                                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                            .hasMatch(emailController.text.trim())) {
                          utilService.showToast("Please enter valid email");
                        } else if (passwordController.text.trim().isEmpty ||
                            emailController.text.trim().isEmpty) {
                          utilService.showToast("Please fill all fields");
                        } else {
                          showLoadingAnimation(context);
                          await context
                              .read<AuthProvider>()
                              .signinWithEmailAndPassword(
                                emailController.text,
                                passwordController.text,
                                context,
                              );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        textStyle: TextStyle(
                            color: Colors.black,
                            fontSize: MediaQuery.of(context).size.height * 0.09,
                            fontWeight: FontWeight.w600),
                        fixedSize: Size(MediaQuery.of(context).size.width * 0.9,
                            MediaQuery.of(context).size.height * 0.065),
                        primary: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                      ),
                      child: Text(
                        'Sign In',
                        style: TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TitleWidget extends StatelessWidget {
  String text;
  double size;
  FontWeight weight;
  TitleWidget({
    Key? key,
    required this.text,
    required this.size,
    required this.weight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: Colors.white,
        fontSize: size,
        fontWeight: weight,
      ),
    );
  }
}
