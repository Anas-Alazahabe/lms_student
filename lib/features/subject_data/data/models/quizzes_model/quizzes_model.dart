import 'package:equatable/equatable.dart';
import 'package:lms_student/features/subject_data/data/models/quizzes_model/quiz.dart';

class QuizzesModel extends Equatable {
  final List<Quiz>? openQuizzes;
  final List<Quiz>? lockQuizzes;
  // final List<Quiz>? quizzes;

  const QuizzesModel({this.openQuizzes, this.lockQuizzes
      // ,this.quizzes
      });

  factory QuizzesModel.fromJson(Map<String, dynamic> json) => QuizzesModel(
        openQuizzes: (json['OpenQuizzes'] as List<dynamic>?)
            ?.map((e) => Quiz.fromJson(e as Map<String, dynamic>))
            .toList(),
        lockQuizzes: (json['LockQuizzes'] as List<dynamic>?)
            ?.map((e) => Quiz.fromJson(e as Map<String, dynamic>))
            .toList(),
        // quizzes: (json['quiz'] as List<dynamic>?)
        //     ?.map((e) => Quiz.fromJson(e as Map<String, dynamic>))
        //     .toList(),
      );

  Map<String, dynamic> toJson() => {
        'OpenQuizzes': openQuizzes?.map((e) => e.toJson()).toList(),
        'LockQuizzes': lockQuizzes?.map((e) => e.toJson()).toList(),
      };

  @override
  List<Object?> get props => [openQuizzes, lockQuizzes];
}
