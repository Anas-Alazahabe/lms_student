import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lms_student/constants.dart';

import '../../../data/models/teacher_profile_model/subject.dart';
// import 'package:lms_student/features/home/data/models/subjects_model/subject.dart';
// import 'package:lms_student/features/subject_data/data/models/teacher_profile_model/subject.dart';

class subjectteachers extends StatelessWidget {
  final List<Subject> subject;
  const subjectteachers({super.key, required this.subject});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: subject.length,
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return Card(
            //elevation: 1,
            margin: EdgeInsets.symmetric(vertical: 5, horizontal: 14),
            child: ListTile(
              leading: Icon(Icons.subject_rounded),
              title: Text(subject[index].name!),
            ),
          );
        });
  }
}
