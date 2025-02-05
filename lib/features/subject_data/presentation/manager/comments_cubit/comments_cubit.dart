import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lms_student/features/subject_data/data/models/comments_model/comments_model.dart';
import 'package:lms_student/features/subject_data/data/repo/subject_repo.dart';
part 'comments_state.dart';

class CommentsCubit extends Cubit<CommentsState> {
  final SubjectRepo homeRepo;

  CommentsCubit(this.homeRepo) : super(CommentsInitial());

  Future<void> fetchCommentsData({required String lessonId}) async {
    emit(CommentsLoading());
    final result = await homeRepo.fetchCommentsData(lessonId: lessonId);
    result.fold(
        (failure) => emit(CommentsFailure(errMessage: failure.errMessage)),
        (comments) => emit(CommentsSuccess(comments)));
  }
}
