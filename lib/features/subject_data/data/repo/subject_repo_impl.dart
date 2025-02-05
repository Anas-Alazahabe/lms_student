import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:lms_student/constants.dart';
import 'package:lms_student/core/cubits/shared_preferences_cubit/shared_preferences_cubit.dart';
import 'package:lms_student/core/cubits/token_cubit/token_cubit.dart';
import 'package:lms_student/core/errors/failures.dart';
import 'package:lms_student/core/utils/api_service.dart';
import 'package:lms_student/core/utils/service_locator.dart';
import 'package:lms_student/features/subject_data/data/models/comments_model/comments_model.dart';
import 'package:lms_student/features/subject_data/data/models/comments_model/comemnt_data.dart';
import 'package:lms_student/features/subject_data/data/models/quizzes_model/quizzes_model.dart';
import 'package:lms_student/features/subject_data/data/models/teacher_profile_model/users_model.dart';
import 'package:lms_student/features/subject_data/data/models/units_model/unit.dart';
import 'package:lms_student/features/subject_data/data/repo/subject_repo.dart';

class SubjectRepoImpl implements SubjectRepo {
  final ApiService _apiService;
  final TokenCubit tokenCubit = getIt<TokenCubit>();
  final SharedPreferencesCubit sharedPreferencesCubit =
      getIt<SharedPreferencesCubit>();
  SubjectRepoImpl(this._apiService);

  @override
  Future<Either<Failure, Unitt>> fetchUnits(
      {required String? subjectId}) async {
    try {
      final response = await _apiService.post(
        url: '$kBaseUrl/unit/show_all_units',
        token: tokenCubit.state,
        body: {
          'subject_id': subjectId,
        },
      );
      Unitt unitModel = Unitt.fromJson(response);

      return right(unitModel);
    } on Exception catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioException(e));
      }
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> buySubject(
      {required String? subjectId}) async {
    try {
      final response = await _apiService.post(
        url: '$kBaseUrl/subscription/buy_subject',
        token: tokenCubit.state,
        body: {
          'subject_id': subjectId,
        },
      );

      // Unitt unitModel = Unitt.fromJson(response);

      return right(response['message']);
    } on Exception catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioException(e));
      }
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, QuizzesModel>> fetchQuizzes(
      {required String? subjectId,
      required String? type,
      required String? typeId}) async {
    try {
      final response = await _apiService.post(
        url: '$kBaseUrl/quiz/show_all_to_student',
        token: tokenCubit.state,
        body: {
          'subject_id': subjectId,
          'type': type,
          'type_id': typeId,
        },
      );
      print(response);
      QuizzesModel quizzezModel = QuizzesModel.fromJson(response);

      return right(quizzezModel);
    } on Exception catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioException(e));
      }
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, CommentsModel>> fetchCommentsData(
      {required String lessonId}) async {
    try {
      final response = await _apiService.get(
        url: '$kBaseUrl/comment/getComments',
        token: tokenCubit.state,
        body: null,
        queryParameters: {'lesson_id': lessonId},
      );

      CommentsModel commentsModel = CommentsModel.fromJson(response);

      return right(commentsModel);
    } on Exception catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioException(e));
      }
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, CommentData>> postComment({
    required String comment,
    required String lessonId,
  }) async {
    try {
      final response = await _apiService.post(
        url: '$kBaseUrl/comment/store',
        token: tokenCubit.state,
        body: {"content": comment, "lesson_id": lessonId},
      );

      CommentData commentsModel = CommentData.fromSingleJson(response['data']);

      return right(commentsModel);
    } on Exception catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioException(e));
      }
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, CommentData>> updateComment(
      {required String comment, required String commentId}) async {
    try {
      final response = await _apiService.post(
        url: '$kBaseUrl/comment/update',
        token: tokenCubit.state,
        body: {"content": comment, 'id': commentId},
      );

      CommentData commentsModel = CommentData.fromSingleJson(response['data']);

      return right(commentsModel);
    } on Exception catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioException(e));
      }
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, UsersModel>> fetchTeacherProfile(
      {required String userId, required bool isTeacher}) async {
    try {
      final response = await _apiService.post(
        url:isTeacher? '$kBaseUrl/profile/show_one_teacher':'$kBaseUrl/profile/show_one_student',
        token: tokenCubit.state,
        body: {'user_id': userId},
      );

      UsersModel commentsModel = UsersModel.fromJson(response);

      return right(commentsModel);
    } on Exception catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioException(e));
      }
      return Left(ServerFailure(e.toString()));
    }
  }
}
