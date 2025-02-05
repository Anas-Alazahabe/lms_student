import 'dart:io';

import 'package:flutter/material.dart';
import 'package:lms_student/features/subject_data/data/models/quizzes_model/answer.dart';
// import 'package:hadara_app/core/cubits/directory_cubit/directory_cubit.dart';
// import 'package:hadara_app/core/utils/service_locator.dart';
// import 'package:hadara_app/features/home/data/models/answers_model.dart';
// import 'package:hadara_app/features/home/data/models/quiz_model/quiz_model.dart';
// import 'package:hadara_app/features/home/presentation/views/widgets/atatched_image.dart';
import 'package:lms_student/features/subject_data/data/models/quizzes_model/quiz.dart';
import 'package:lms_student/features/subject_data/presentation/views/widgets/options_items.dart';

// import 'blank_items.dart';
// import 'matchs_items.dart';
// import 'options_items.dart';

class PageViewQuizItem extends StatefulWidget {
  final int index;
  final Quiz quiz;
  // final QuizModel quizModel;
  final List<Answer?> answers;
  // final Map<int, List<String>> groupedBlanks;
// final List<Question> originalQuestion;
  final bool showCorrect;
  // final List<List<String>> allShuffledLefts;
  //final Question question;
  // final List<Answer?> correctAnswers;

//final List<int> selectedIndices;
  const PageViewQuizItem({
    super.key,
    required this.index,
    // required this.quizModel,
    required this.answers,
// required this.originalQuestion,
    // required this.groupedBlanks,
    required this.showCorrect,
    required this.quiz,
    // required this.allShuffledLefts,
    // required this.question, // required this.correctAnswers,

//required this.selectedIndices,
  });

  @override
  State<PageViewQuizItem> createState() => _PageViewQuizItemState();
}

class _PageViewQuizItemState extends State<PageViewQuizItem> {
// adjust the size as needed

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text('السؤال ${widget.index + 1}:'),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                    '${widget.quiz.questions![widget.index].mark.toString()} علامة'),
              ),
              // Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: 10),
              //   child: Text(
              //       '${widget.quizModel.data!.questions![widget.index].points.toString()} نقطة'),
              // ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    widget.quiz.questions![widget.index].text!,
                    style: const TextStyle(fontSize: 24),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 50,
          ),
// if (quizModel.data!.question![index].orders!.isNotEmpty)
// Text('data3'),

          OptionsItems(
            correctAnswer: widget.quiz.questions![widget.index].correctAnswer!,
            showCorrect: widget.showCorrect,
            options: widget.quiz.questions![widget.index].answers!,
            selectedIndex:
                (widget.answers[widget.index] as MCQAnswer).selectedOption,
            onOptionSelected: (selectedIndex) {
              setState(() {
                widget.answers[widget.index] = MCQAnswer(selectedIndex);
              });
            },
          )
        ],
      ),
    );
  }
}
