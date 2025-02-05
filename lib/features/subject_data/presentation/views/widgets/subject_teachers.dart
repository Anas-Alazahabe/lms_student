import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lms_student/constants.dart';

class subjectteachers extends StatelessWidget {
  const subjectteachers({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: 3,
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return Card(
            //elevation: 1,
            margin: EdgeInsets.symmetric(vertical: 5, horizontal: 14),
            child: ListTile(
              leading: Icon(Icons.subject_rounded),
              title: Text('Mathmatic'),
            ),
          );
        });
  }
}
