// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:lms_student/constants.dart';
import 'package:lms_student/core/enums/types_enum.dart';
import 'package:lms_student/features/home/presentation/views/widgets/header_widget.dart';
import 'package:lms_student/features/subject_data/data/models/units_model/lesson.dart';
import 'package:lms_student/features/subject_data/presentation/views/widgets/files_list_view.dart';
import 'package:lms_student/features/subject_data/presentation/views/widgets/lesson_tab_view.dart';
import 'package:lms_student/features/subject_data/presentation/views/widgets/quizzes_list_view.dart';

class LessonContent extends StatefulWidget {
  final Lesson lesson;
  final String subjectName;
  final String unitName;
  final String subjectId;

  final TabController tabController;
  const LessonContent({
    super.key,
    required this.lesson,
    required this.tabController,
    required this.subjectName,
    required this.unitName,
    required this.subjectId,
  });

  @override
  State<LessonContent> createState() => _LessonContentState();
}

class _LessonContentState extends State<LessonContent> {
  int isLessionSection = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isLessionSection = 0;
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        HeaderWidget(
          lessonName: widget.lesson.name!,
          imageUrl: widget.lesson.imageUrl!,
        ),
        SliverToBoxAdapter(
          // child: TabBar(
          //   controller: tabController,
          //   labelColor: Colors.red,
          //   unselectedLabelColor: Colors.grey,
          //   indicatorColor: Colors.red,
          //   tabs: const [
          //     Tab(text: 'مقاطع الدرس'),
          //     Tab(text: 'المرفقات'),
          //     Tab(text: 'الاختبارات'),
          //   ],
          // ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Material(
                color: isLessionSection == 0
                    ? kAppColor
                    : kAppColor.withOpacity(0.6),
                borderRadius: BorderRadius.circular(10),
                child: InkWell(
                  onTap: () {
                    setState(() {
                      isLessionSection = 0;
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 28),
                    child: const Text(
                      'Lesson',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 2,
              ),
              Material(
                color: isLessionSection == 1
                    ? kAppColor
                    : kAppColor.withOpacity(0.6),
                borderRadius: BorderRadius.circular(10),
                child: InkWell(
                  onTap: () {
                    setState(() {
                      isLessionSection = 1;
                      // isComments= false;
                    });
                  },
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 28),
                    child: const Text(
                      'مرفقات',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 2,
              ),
              Material(
                color: isLessionSection == 2
                    ? kAppColor
                    : kAppColor.withOpacity(0.6),
                borderRadius: BorderRadius.circular(10),
                child: InkWell(
                  onTap: () {
                    setState(() {
                      isLessionSection = 2;
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 30),
                    child: const Text(
                      'Quizzes',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        if (isLessionSection == 0)
          SliverToBoxAdapter(
            child: LessonTabView(
              unitName: widget.unitName,
              lesson: widget.lesson,
              tabController: widget.tabController,
              subjectName: widget.subjectName,
              subjectId: widget.subjectId,
            ),
          ),
        if (isLessionSection == 1)
          SliverToBoxAdapter(
            child: FilesListView(
              imageUrl: widget.lesson.imageUrl!,
              files: widget.lesson.files!,
              lessonId: widget.lesson.id!,
              subjectId: null,
            ),
          ),
        if (isLessionSection == 2)
          SliverToBoxAdapter(
            child: QuizzseListView(
              parentId: widget.lesson.id!,
              subjectId: widget.subjectId,
              type: Types.lesson.name,
            ),
          )
      ],
    );
  }
}
