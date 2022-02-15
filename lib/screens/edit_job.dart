// ignore_for_file: prefer_const_constructors_in_immutables, file_names, prefer_const_constructors, prefer_const_literals_to_create_immutables, must_be_immutable

import 'package:auth_app/gloabals.dart';
import 'package:auth_app/provider/jobProvider.dart';
import 'package:flutter/material.dart';

import 'package:auth_app/widgets/column_scroll_view.dart';
import 'package:provider/src/provider.dart';

class EditJob extends StatefulWidget {
  String? position;
  String? description;
  String? id;

  EditJob({
    Key? key,
    this.position,
    this.description,
    this.id,
  }) : super(key: key);

  @override
  State<EditJob> createState() => _EditJobState();
}

class _EditJobState extends State<EditJob> {
  bool showPassword = false;
  TextEditingController positionController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  void initState() {
    positionController.text = widget.position!;
    descriptionController.text = widget.description!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        toolbarHeight: 100,
        leadingWidth: 40,
        leading: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
              size: 30,
            ),
          ),
        ),
        title: TitleWidget(
          text: "Edit Job",
          size: 26,
          weight: FontWeight.bold,
        ),
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
                    showLoadingAnimation(context);
                    await context.read<JobProvider>().updateJobFromFirebase(
                          widget.id!,
                          positionController.text,
                          descriptionController.text,
                        );
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
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
                    'Update Job',
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
