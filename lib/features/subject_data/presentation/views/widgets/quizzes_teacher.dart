import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lms_student/constants.dart';
import 'package:lms_student/features/subject_data/data/models/teacher_profile_model/exam.dart';

class quizzesTeacher extends StatelessWidget {
  final List<Exam>quiz;
  const quizzesTeacher({super.key,required this.quiz});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: quiz.length,
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return Card(
            //elevation: 1,
            margin: EdgeInsets.symmetric(vertical: 5, horizontal: 14),
            child: ListTile(
              
              title: Text(quiz[index].date!),
            ),
          );
        });
  }
}