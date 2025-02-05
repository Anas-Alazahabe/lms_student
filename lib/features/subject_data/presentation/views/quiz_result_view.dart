import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lms_student/constants.dart';
import 'package:lms_student/core/cubits/shared_preferences_cubit/shared_preferences_cubit.dart';
import 'package:lms_student/core/utils/service_locator.dart';
import 'package:lms_student/features/downloads/data/models/failed_request/failed_request.dart';
import 'package:hive/hive.dart';

class QuizResults extends StatefulWidget {
  final int fullMark;
  // final int fullPoints;
  final int userMarks;
  // final int userPoints;
  // final int quizId;
  // final bool postPoints;
  // final int courseId;
  const QuizResults({
    super.key,
    required this.fullMark,
    // required this.fullPoints,
    required this.userMarks,
    // required thi/s.userPoints,
    // required this.quizId,
    // required this.postPoints,
    // required this.courseId
  });

  @override
  State<QuizResults> createState() => _QuizResultsState();
}

class _QuizResultsState extends State<QuizResults> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: PopScope(
        canPop: false,
        onPopInvoked: (didPop) async {
          context.pop(true);
        },
        child: Scaffold(
            appBar: AppBar(
              title: const Text('نتيجة الاختبار'),
            ),
            body: SingleChildScrollView(
                child: Column(
              children: [
                const SizedBox(
                  height: 60,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: kAppColor,
                        borderRadius: BorderRadius.circular(20)),
                    child: Column(
//mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20)),
                              child: const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  'نتيجة الاختبار',
                                  style: TextStyle(color: kAppColor),
                                ),
                              )),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              children: [
                                const Text(
                                  'النتيجة النهائية:',
                                  style: TextStyle(color: Colors.white),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  '${widget.userMarks}/${widget.fullMark}',
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 30),
                                ),
                              ],
                            ),
// Spacer(),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Column(
                          children: [
                            SizedBox(
                              height: 20,
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
// Spacer(),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 70),
                  child: Row(
                    children: [
                      ElevatedButton(
                          onPressed: () {
                            context.pop();
                            context.pop();
                          },
                          child: const Text('العودة إلى الاختبارات')),
                      const Spacer(),
                      ElevatedButton(
                          onPressed: () {
                            context.pop(true);
                          },
                          child: const Text('مراجعة الإجابات')),
                    ],
                  ),
                ),
              ],
            ))),
      ),
    );
  }

  void showResultDialog(BuildContext context, String text) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
//title: const Text('تأكيد'),
          content: Text(text),
          actions: <Widget>[
            TextButton(
              child: const Text('تم'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
