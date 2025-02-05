import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lms_student/features/subject_data/data/models/quizzes_model/answer.dart';
import 'package:lms_student/features/subject_data/data/models/quizzes_model/quiz.dart';
import 'package:lms_student/features/subject_data/presentation/views/widgets/quiz_navigation_button.dart';
import 'package:lms_student/features/subject_data/presentation/views/widgets/quiz_view_header.dart';
import 'package:lms_student/features/subject_data/presentation/views/widgets/quiz_view_pages.dart';

class QuizView extends StatefulWidget {
  final Quiz quiz;
  const QuizView({
    super.key,
    required this.quiz,
  });

  @override
  State<QuizView> createState() => _QuizViewState();
}

class _QuizViewState extends State<QuizView> {
  final PageController _pageController = PageController();
  late List<Answer?> answers;
  late List<Answer?> correctAnswers;

  @override
  void initState() {
    super.initState();
    answers = List.filled(widget.quiz.questions!.length, null);
    widget.quiz.questions!.asMap().forEach((index, element) {
      answers[index] = MCQAnswer(-1);
    });

    correctAnswers = List.filled(widget.quiz.questions!.length, null);
    widget.quiz.questions!.asMap().forEach((index, element) {
      // answers[index] = MCQAnswer(-1);
      correctAnswers[index] = MCQAnswer(element.answers!
          .indexWhere((element2) => element2 == element.correctAnswer!));
    });
  }

  // int _currentStep = 1;

  // List<String?> rights = [];
  // late QuizSuccess state;
  // late QuizSuccess originalState;
  // late List<Question> originalQuestion;
  final ValueNotifier<int> _currentStepNotifier = ValueNotifier<int>(1);
  bool showCorrect = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: Stack(
      children: [
        Column(
          children: [
            QuizViewHeader(
              totalMarks: int.parse(widget.quiz.totalMark!),
              correctAnswers: correctAnswers,
              quiz: widget.quiz,
              // courseId: widget.courseId,
              currentStepNotifier: _currentStepNotifier,
              // state: state,
              answers: answers,
              // correctAnswers: correctAnswers,
              // questions: state.quiz.data!.questions!,
              // postPoints: showCorrect,
              showCorrect: (value) {
                setState(() {
                  showCorrect = value;
                });
              },
              showTimer: showCorrect,
              // quizId: state.quiz.data!.id!,
            ),
            QuizViewPages(
              //correctAnswers: correctAnswers,
              // allShuffledLefts: allShuffledLefts,
              showCorrect: showCorrect,
              // groupedBlanks: groupedBlanks,
              //  originalQuestion: originalQuestion,
              answers: answers,
              pageController: _pageController,
              // state: state,
              onChange: (int page) {
                _currentStepNotifier.value = page + 1;
              },
              quiz: widget.quiz,
            ),
          ],
        ),
        ValueListenableBuilder<int>(
            valueListenable: _currentStepNotifier,
            builder: (context, value, child) {
              return QuizNavigationButton(
                totalMarks: int.parse(widget.quiz.totalMark!),
                correctAnswers: correctAnswers,
                // courseId: widget.courseId,
                postPoints: showCorrect,
                showCorrect: (value) {
                  setState(() {
                    showCorrect = value;
                  });
                },
                // quizId: state.quiz.data!.id!,
                // questions: state.quiz.data!.questions!,
                answers: answers,
                // correctAnswers: correctAnswers,
                text:
                    value != widget.quiz.questions!.length ? 'التالي' : 'إنهاء',
                pageController: _pageController,
                alignment: Alignment.bottomRight,
              );
            }),
        QuizNavigationButton(
          totalMarks: int.parse(widget.quiz.totalMark!),
          correctAnswers: correctAnswers,
          postPoints: showCorrect,
          showCorrect: (value) {
            setState(() {
              showCorrect = value;
            });
          },
          // quizId: state.quiz.data!.id!,
          // questions: state.quiz.data!.questions!,
          answers: answers,
          // correctAnswers: correctAnswers,
          text: 'السابق',
          pageController: _pageController,
          alignment: Alignment.bottomLeft,
        ),
      ],
    )));
  }
}
