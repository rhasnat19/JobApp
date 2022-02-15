// ignore_for_file: prefer_const_constructors_in_immutables, file_names, prefer_const_constructors, prefer_const_literals_to_create_immutables, must_be_immutable

import 'package:auth_app/gloabals.dart';
import 'package:auth_app/provider/jobProvider.dart';
import 'package:auth_app/services/util_services.dart';
import 'package:auth_app/utils/lcoator.dart';
import 'package:auth_app/widgets/column_scroll_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';

class AddNewJob extends StatefulWidget {
  AddNewJob({Key? key}) : super(key: key);

  @override
  State<AddNewJob> createState() => _AddNewJobState();
}

class _AddNewJobState extends State<AddNewJob> {
  bool showPassword = false;
  TextEditingController positionController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  var utilService = locator<UtilService>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        toolbarHeight: 140,
        leadingWidth: 40,
        leading: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
            size: 30,
          ),
        ),
        title: TitleWidget(
          text: "Add New Job",
          size: 26,
          weight: FontWeight.bold,
        ),
        centerTitle: false,
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
                  TextField(
                    controller: positionController,
                    keyboardType: TextInputType.emailAddress,
                    style: TextStyle(color: Colors.white, fontSize: 14),
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey.shade900,
                        hintText: "Enter position name",
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
                    controller: descriptionController,
                    maxLines: 10,
                    style: TextStyle(color: Colors.white, fontSize: 14),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey.shade900,
                      hintText: "Describe Requirement..",
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
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
              child: ElevatedButton(
                  onPressed: () async {
                    if (positionController.text.trim().isEmpty ||
                        descriptionController.text.trim().isEmpty) {
                      utilService.showToast("Please fill all fields");
                    } else {
                      showLoadingAnimation(context);
                      await context.read<JobProvider>().addJobToFirebase(
                          positionController.text, descriptionController.text);
                      Navigator.pop(context);
                      Navigator.pop(context);
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
                    'Submit Job',
                    style: TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  )),
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
