import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lms_student/constants.dart';
import 'package:lms_student/core/utils/app_router.dart';
import 'package:lms_student/features/home/data/models/subjects_model/subject.dart';
import 'package:lms_student/features/home/presentation/views/widgets/subject_widget/subject_item.dart';

class SubjectList extends StatelessWidget {
  SubjectList({super.key, required this.subjects});
  var height, width;
  List<Subject> subjects;
  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          color: kAppColor,
          width: width,
          child: Column(
            children: [
              Container(
                  decoration: BoxDecoration(
                    color: kAppColor,
                  ),
                  height: height * 0.15,
                  width: width,
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          context.push(AppRouter.kHomeView);
                        },
                        icon: Icon(
                          Icons.arrow_back_ios_new_rounded,
                          color: Colors.white,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 15,
                        ),
                        child: Text(
                          'Subject'.tr(),
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 1),
                        ),
                      )
                    ],
                  )),
              SingleChildScrollView(
                child: Container(
                  decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.background,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(40),
                          topRight: Radius.circular(40))),
                  height: height * 0.85,
                  width: width,
                  padding: EdgeInsets.only(bottom: 20),
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 1.1,
                      mainAxisSpacing: 25,
                    ),
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: subjects.length,
                    itemBuilder: (context, index) {
                      return SubjectItem(subject: subjects[index]);
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
