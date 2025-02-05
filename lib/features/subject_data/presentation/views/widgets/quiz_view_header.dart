import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lms_student/core/utils/functions/calculate_quiz_result.dart';
import 'package:lms_student/features/home/presentation/views/widgets/countdown_localed.dart';
import 'package:lms_student/features/subject_data/data/models/quizzes_model/answer.dart';
import 'package:lms_student/features/subject_data/data/models/quizzes_model/quiz.dart';

class QuizViewHeader extends StatelessWidget {
  final Quiz quiz;
  final bool showTimer;
  final ValueNotifier<int> currentStepNotifier;
  final List<Answer?> correctAnswers;
  final List<Answer?> answers;
  final int totalMarks;
  // final List<Question> questions;
  final void Function(bool) showCorrect;
  // final bool postPoints;

  const QuizViewHeader({
    super.key,
    required this.currentStepNotifier,
    // required this.quizId,
    required this.showCorrect,
    // required this.postPoints,
    required this.quiz,
    required this.answers,
    required this.correctAnswers,
    required this.totalMarks,
    required this.showTimer,
    // required this.courseId,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
        valueListenable: currentStepNotifier,
        builder: (context, value, child) {
          return PopScope(
            canPop: false,
            onPopInvoked: (didPop) {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('تأكيد'),
                    content: const Text('هل تريد الخروج من الاختبار؟'),
                    actions: <Widget>[
                      TextButton(
                        child: const Text('إلغاء'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      TextButton(
                        child: const Text('نعم'),
                        onPressed: () async {
                          context.pop();
                          context.pop();
                        },
                      ),
                    ],
                  );
                },
              );
            },
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: const BorderRadius.all(
                          Radius.circular(20),
                        )),
                    width: double.infinity,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  quiz.name!,
                                  softWrap: true,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              IconButton(
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: const Text('تأكيد'),
                                          content: const Text(
                                              'هل تريد الخروج من الاختبار؟'),
                                          actions: <Widget>[
                                            TextButton(
                                              child: const Text('إلغاء'),
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                            ),
                                            TextButton(
                                              child: const Text('نعم'),
                                              onPressed: () async {
                                                context.pop();
                                                context.pop();
                                              },
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  },
                                  icon: const Icon(Icons.arrow_forward))
// Spacer(),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: Row(
                            children: [
                              Text('$value/${quiz.questions!.length}'),
                              const Spacer(),
                              if (!showTimer)
                                CountdownLocaled(
                                    duration: Duration(
//hours: state.quiz.data!.duration!.hour!,
                                        minutes: int.parse(
                                            quiz.duration!) //.minute!,
// seconds: state.quiz.data!.duration!.second!,
                                        ),
                                    onDone: () async {
                                      await calulateAndPush(
                                        totalMark: totalMarks,
                                        context: context,
                                        answers: answers,
                                        correctAnswers: correctAnswers,
                                        showCorrect: showCorrect,
                                      );
                                    }
                                    // },
                                    ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: LinearProgressIndicator(
                            borderRadius: BorderRadius.circular(20),
                            value: value / quiz.questions!.length,
                            minHeight: 15,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }
}
