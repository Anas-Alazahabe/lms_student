import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lms_student/core/utils/app_router.dart';
import 'package:lms_student/features/home/data/models/subjects_model/subject.dart';

class SubjectItem extends StatelessWidget {
  const SubjectItem({super.key, required this.subject});
  final Subject subject;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.push(AppRouter.kSubjectDataView, extra: subject);
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Theme.of(context).colorScheme.onSecondary,
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              spreadRadius: 1,
              blurRadius: 6,
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // Image.asset(imasgs[index],
            //   width: 120,),
            Text(subject.name!,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    )
                // TextStyle(
                //   color: Colors.black,
                //   fontWeight: FontWeight.bold,
                //   fontSize: 20,
                // ),
                )
          ],
        ),
      ),
    );
  }
}
