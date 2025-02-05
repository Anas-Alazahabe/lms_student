// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lms_student/constants.dart';
import 'package:lms_student/core/utils/app_router.dart';
import 'package:lms_student/features/subject_data/data/models/units_model/lesson.dart';
import 'package:lms_student/features/subject_data/presentation/views/widgets/lesson_content.dart';

class LessonView extends StatefulWidget {
  final Lesson lesson;
  final String subjectName;
  final String unitName;
  final String subjectId;
  const LessonView(
      {super.key,
      required this.lesson,
      required this.subjectName,
      required this.unitName,
      required this.subjectId});

  @override
  State<LessonView> createState() => _LessonViewState();
}

class _LessonViewState extends State<LessonView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(_handleTabSelection);
    super.initState();
  }

  void _handleTabSelection() {
    if (_tabController.indexIsChanging) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
    _tabController.removeListener(_handleTabSelection);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: kAppColor,
              ),
              onPressed: () {
                context.pop();
              },
            );
          },
        ),
        title: Text(
          widget.lesson.name!,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            letterSpacing: 1,
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 10),
            child: Icon(
              Icons.favorite_border_outlined,
              size: 25,
              color: kAppColor,
            ),
          ),
        ],
      ),
      body: LessonContent(
        tabController: _tabController,
        lesson: widget.lesson,
        subjectName: widget.subjectName,
        unitName: widget.unitName,
        subjectId: widget.subjectId,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.push(AppRouter.kCommentsView, extra: widget.lesson.id);
        },
        child: const Icon(Icons.comment),
      ),
    ));
  }
}
