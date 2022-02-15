// ignore_for_file: file_names, unused_local_variable, unnecessary_new, avoid_function_literals_in_foreach_calls

import 'package:auth_app/models/jobs_model.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class JobProvider with ChangeNotifier {
  List<JobModel> jobData = [];
  addJobToFirebase(String positionName, String requirement) async {
    Map<String, dynamic> jobData = {
      'createdOnDate': DateTime.now().millisecondsSinceEpoch.toString(),
      'positionName': positionName,
      'requirement': requirement,
    };

    await FirebaseFirestore.instance.collection("Jobs").add(jobData);
    await getAllJobsFromFirebase();
    notifyListeners();
  }

  Future getAllJobsFromFirebase() async {
    jobData = [];
    await FirebaseFirestore.instance.collection('Jobs').get().then(
      (response) {
        response.docs.forEach(
          (element) {
            jobData.add(
              JobModel(
                id: element.id,
                title: element.data()['positionName'],
                description: element.data()['requirement'],
              ),
            );
          },
        );
      },
    );
    notifyListeners();
    // jobsQuery.docs.forEach((element) {
    //   jobsHashMap.putIfAbsent(
    //       element.get('id'),
    //       () => new JobModel(
    //             id: element.get('id'),
    //             title: element.get('positionName'),
    //             description: element.get('requirement'),
    //           ));
    // });
  }

  deleteJobFromFirebase(String id) async {
    await FirebaseFirestore.instance
        .collection('Jobs')
        .get()
        .then((snapshot) async {
      // snapshot.docs.forEach((element) {
      //   if (element.data()['id'] == id) {}
      // }
      for (var doc in snapshot.docs) {
        if (doc.id == id) {
          await FirebaseFirestore.instance
              .collection("Jobs")
              .doc(doc.id)
              .delete();
        }
      }
    });
    await getAllJobsFromFirebase();
    notifyListeners();
  }

  updateJobFromFirebase(
      String id, String positionName, String requirement) async {
    Map<String, dynamic> updatedJobData = {
      'createdOnDate': DateTime.now().millisecondsSinceEpoch.toString(),
      'positionName': positionName,
      'requirement': requirement,
    };
    await FirebaseFirestore.instance
        .collection('Jobs')
        .get()
        .then((value) async {
      for (var doc in value.docs) {
        if (doc.id == id) {
          await FirebaseFirestore.instance
              .collection('Jobs')
              .doc(doc.id)
              .update(updatedJobData);
        }
      }
    });
    await getAllJobsFromFirebase();
  }
}
