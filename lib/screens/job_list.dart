// ignore_for_file: prefer_const_constructors,prefer_const_literals_to_create_immutables

import 'package:auth_app/gloabals.dart';
import 'package:auth_app/provider/authProvider.dart';
import 'package:auth_app/provider/jobProvider.dart';
import 'package:auth_app/screens/add_new_job.dart';
import 'package:auth_app/screens/edit_job.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class JobList extends StatefulWidget {
  const JobList({Key? key}) : super(key: key);
  @override
  _JobListState createState() => _JobListState();
}

class _JobListState extends State<JobList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(170.0),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
            child: Column(
              children: [
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Welcome",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              "${context.read<AuthProvider>().user!.fullName}",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.w400,
                              ),
                            )
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          IconButton(
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      AddNewJob(),
                                ),
                              );
                            },
                            icon: Icon(
                              Icons.add,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              context
                                  .read<AuthProvider>()
                                  .logoutFirebaseUser(context);
                            },
                            icon: Icon(
                              Icons.exit_to_app,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                        ],
                      ),
                    ]),
                SizedBox(
                  height: 20,
                ),
                TextField(
                    style: TextStyle(color: Colors.white, fontSize: 14),
                    decoration: InputDecoration(
                      filled: true,
                      prefixIcon: Icon(
                        Icons.search,
                        size: 25,
                        color: Colors.grey.shade500,
                      ),
                      fillColor: Colors.grey.shade900,
                      hintText: "Search Keyword.",
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
                    )),
              ],
            ),
          )),
      body: Consumer<JobProvider>(builder: (context, jp, _) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20),
          child: ListView.builder(
            itemCount: jp.jobData.length,
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              return Column(
                children: [
                  Container(
                    padding: EdgeInsets.fromLTRB(20, 15, 15, 15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey.shade900,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${jp.jobData[index].title}",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              "${jp.jobData[index].description}",
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                              ),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (BuildContext ctx) => EditJob(
                                      position: jp.jobData[index].title,
                                      description:
                                          jp.jobData[index].description,
                                      id: jp.jobData[index].id,
                                    ),
                                  ),
                                );
                              },
                              icon: Icon(
                                Icons.edit,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            InkWell(
                              onTap: () async {
                                showLoadingAnimation(context);
                                await context
                                    .read<JobProvider>()
                                    .deleteJobFromFirebase(
                                      jp.jobData[index].id!,
                                    );
                                Navigator.of(context).pop();

                                setState(() {});
                              },
                              child: Icon(
                                Icons.delete,
                                size: 25,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  )
                ],
              );
            },
          ),
        );
      }),
    );
  }
}
