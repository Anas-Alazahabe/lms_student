import 'package:flutter/material.dart';
import 'package:lms_student/features/subject_data/data/models/quizzes_model/answer.dart';
import 'package:lms_student/features/subject_data/data/models/quizzes_model/quiz.dart';
import 'package:lms_student/features/subject_data/presentation/views/widgets/page_view_quiz_item.dart';

class QuizViewPages extends StatelessWidget {
  final PageController pageController;
  // final QuizSuccess state;
  final void Function(int)? onChange;
  final List<Answer?> answers;
  // final List<Question> originalQuestion;
  // final Map<int, List<String>> groupedBlanks;
  final bool showCorrect;
  final Quiz quiz;
  // final List<List<String>> allShuffledLefts;
  // final List<Answer?> correctAnswers;

//  final List<int> selectedIndices;
  const QuizViewPages({
    super.key,
    // required this.state,
    this.onChange,
    required this.pageController,
    // required this.answers,
    // required this.originalQuestion,
    // required this.groupedBlanks,
    required this.showCorrect,
    // required this.allShuffledLefts
    required this.quiz,
    required this.answers,
    //required this.correctAnswers,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 3,
      child: PageView.builder(
        scrollDirection: Axis.vertical,
        physics: const NeverScrollableScrollPhysics(),
        controller: pageController,
        itemCount: quiz.questions!.length,
        onPageChanged: onChange,
        itemBuilder: (BuildContext context, int index) {
          return PageViewQuizItem(
            //  question: state.quiz.data!.questions![index],
            //   correctAnswers: correctAnswers,
            answers: answers,
            quiz: quiz,
            index: index,
            // quizModel: state.quiz,
            //  originalQuestion: originalQuestion,
            // groupedBlanks: groupedBlanks,
            showCorrect: showCorrect,
            // allShuffledLefts:
            //     allShuffledLefts, //correctAnswers: correctAnswers,
          );
          // return Text('PageViewQuizItem(index: index,quizModel: state.quiz,)');
        },
      ),
    );
  }
}
