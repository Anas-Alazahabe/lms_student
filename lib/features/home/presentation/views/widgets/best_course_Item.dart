import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lms_student/constants.dart';
import 'package:lms_student/core/utils/assets.dart';

import '../../../../subject_data/data/models/teacher_profile_model/subject.dart';
import 'course_Rating.dart';

class BestCourseListViewItem extends StatelessWidget {
  final Subject subject;
  const BestCourseListViewItem({super.key, required this.subject});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      child: GestureDetector(
        onTap: (){
          
        },
        child: Card(
          shape:
              ContinuousRectangleBorder(borderRadius: BorderRadius.circular(16)),
          elevation: 8,
          shadowColor: Colors.black.withOpacity(0.3),
          child: Row(children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: AspectRatio(
                aspectRatio: 4.8 / 4,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: const Color(0xFF193152),
                    image: const DecorationImage(
                        image: AssetImage(
                      AssetsData.course,
                    )),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Text(
                        subject.name!,
                        maxLines: 2,
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    subject.description!,
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Row(
                    children: [
                      const Text(
                        'owned',
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(
                        width: 30,
                      ),
                      // IconButton(
                      //   onPressed: () {},
                      //   icon: const Icon(Icons.favorite_border_outlined),
                      //   color: Colors.black,
                      //   iconSize: 20,
                      // ),
                      //  CourseRating(),
                    ],
                  )
                ],
              ),
            )
          ]),
        ),
      ),
    );
  }
}
