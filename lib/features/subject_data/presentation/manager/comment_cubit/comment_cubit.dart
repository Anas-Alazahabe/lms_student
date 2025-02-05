import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:lms_student/features/subject_data/data/models/comments_model/comments_model.dart';
import 'package:lms_student/features/subject_data/data/models/comments_model/comemnt_data.dart';
import 'package:lms_student/features/subject_data/data/repo/subject_repo.dart';

part 'comment_state.dart';

class CommentCubit extends Cubit<CommentState> {
  final SubjectRepo homeRepo;

  CommentCubit(this.homeRepo) : super(CommentInitial());

  Future<void> postComment({
    required String comment,
    required String lessonId,
  }) async {
    emit(CommentLoading());
    final result =
        await homeRepo.postComment(comment: comment, lessonId: lessonId);
    result.fold(
        (failure) => emit(CommentFailure(errMessage: failure.errMessage)),
        (comment) => emit(CommentSuccess(comment)));
  }

  Future<void> updateComment({
    required String comment,
    required String commentId,
  }) async {
    emit(CommentLoading());
    final result =
        await homeRepo.updateComment(comment: comment, commentId: commentId);
    result.fold(
        (failure) => emit(CommentFailure(errMessage: failure.errMessage)),
        (comment) => emit(EditingSuccess(comment)));
  }

  void onSetCommentText(String text, String id) {
    emit(SetCommentText(text, id));
  }

  // @override
  // CommentState? fromJson(Map<String, dynamic>? json) {
  //     if (json?['commentCubit'] == null || json == {}) {
  //     return CommentInitial();
  //   }
  //   final grades = GradesModel.fromJson(json!['gradesCubit']);
  //   return GradesSuccess(grades);
  // }

  // @override
  // Map<String, dynamic>? toJson(CommentState state) {
  //   throw UnimplementedError();
  // }
}
