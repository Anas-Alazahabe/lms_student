import 'package:equatable/equatable.dart';

class Exam extends Equatable {
  final int? quizId;
  final int? mark;
  final int? status;
  final String? date;

  const Exam({this.quizId, this.mark, this.status, this.date});

  factory Exam.fromJson(Map<String, dynamic> json) => Exam(
        quizId: json['quiz_id'] as int?,
        mark: json['mark'] as int?,
        status: json['status'] as int?,
        date: json['date'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'quiz_id': quizId,
        'mark': mark,
        'status': status,
        'date': date,
      };

  @override
  List<Object?> get props => [quizId, mark, status, date];
}
