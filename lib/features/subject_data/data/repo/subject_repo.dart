import 'package:dartz/dartz.dart';
import 'package:lms_student/core/errors/failures.dart';
import 'package:lms_student/features/subject_data/data/models/comments_model/comments_model.dart';
import 'package:lms_student/features/subject_data/data/models/comments_model/comemnt_data.dart';
import 'package:lms_student/features/subject_data/data/models/quizzes_model/quizzes_model.dart';
import 'package:lms_student/features/subject_data/data/models/teacher_profile_model/users_model.dart';
import 'package:lms_student/features/subject_data/data/models/units_model/unit.dart';

abstract class SubjectRepo {
  Future<Either<Failure, Unitt>> fetchUnits({required String? subjectId});
  Future<Either<Failure, String>> buySubject({required String? subjectId});
  Future<Either<Failure, QuizzesModel>> fetchQuizzes(
      {required String? subjectId,
      required String? type,
      required String? typeId});

  Future<Either<Failure, CommentsModel>> fetchCommentsData(
      {required String lessonId});
  Future<Either<Failure, UsersModel>> fetchTeacherProfile(
      {required String userId, required bool isTeacher});

  Future<Either<Failure, CommentData>> postComment({
    required String comment,
    required String lessonId,
    // required String courseId
  });
  Future<Either<Failure, CommentData>> updateComment(
      {required String comment, required String commentId});

  // Future<Either<Failure, AdModel>> fetchAds({required bool all});

  // Future<Either<Failure, SearchResultModel>> searchSubject(
  //     {required String? name, required String? yearId});
}
