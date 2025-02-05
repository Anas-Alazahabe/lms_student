// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:lms_student/constants.dart';
import 'package:lms_student/core/utils/functions/calculate_quiz_result.dart';
import 'package:lms_student/features/subject_data/data/models/quizzes_model/answer.dart';

class QuizNavigationButton extends StatelessWidget {
  final String text;
  final void Function()? onPressed;
  final AlignmentGeometry alignment;
  final PageController pageController;
  final int totalMarks;
  // final List<Answer?> correctAnswers;
  final List<Answer?> answers;
  final List<Answer?> correctAnswers;
  // final List<Question> questions;
  // final int courseId;
  // final int quizId;
  final void Function(bool) showCorrect;
  final bool postPoints;

  const QuizNavigationButton({
    super.key,
    required this.text,
    this.onPressed,
    required this.alignment,
    required this.pageController,
    // required this.correctAnswers,
    required this.answers,
    // required this.questions,
    // required this.quizId,
    required this.showCorrect,
    required this.postPoints,
    required this.totalMarks,
    required this.correctAnswers,
    // required this.courseId,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Align(
        alignment: alignment,
        child: FloatingActionButton(
          backgroundColor: kAppColor,
          heroTag: text,
          onPressed: () async {
            FocusScope.of(context).unfocus();
            switch (text) {
              case 'التالي':
                {
                  pageController.animateToPage(
                    pageController.page!.round() + 1,
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.ease,
                  );
                  break;
                }
              case 'السابق':
                {
                  pageController.animateToPage(
                    pageController.page!.floor() - 1,
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.ease,
                  );
                  break;
                }
              case 'إنهاء':
                {
                  if (!postPoints) {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text('تأكيد'),
                          content: const Text('هل تريد انهاء الاختبار؟'),
                          actions: <Widget>[
                            TextButton(
                              child: const Text('لا'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                            TextButton(
                              child: const Text('نعم'),
                              onPressed: () async {
                                Navigator.pop(context);
                                await calulateAndPush(
                                  totalMark: totalMarks,
                                  context: context,
                                  answers: answers,
                                  correctAnswers: correctAnswers,
                                  showCorrect: showCorrect,
                                );
                              },
                            ),
                          ],
                        );
                      },
                    );
                  } else {
                    await calulateAndPush(
                      totalMark: totalMarks,
                      context: context,
                      answers: answers,
                      correctAnswers: correctAnswers,
                      showCorrect: showCorrect,
                    );
                  }

                  break;
                }
              default:
                {
                  onPressed;
                  break;
                }
            }
          },
          child: Text(
            text,
            style: const TextStyle(fontSize: 12),
          ),
        ),
      ),
    );
  }
}
