part of 'comment_cubit.dart';

sealed class CommentState extends Equatable {
  const CommentState();

  @override
  List<Object> get props => [];
}

final class CommentInitial extends CommentState {}

final class CommentSuccess extends CommentState {
  final CommentData commentModel;

  const CommentSuccess(this.commentModel);

  @override
  List<Object> get props => [commentModel];
}

final class EditingSuccess extends CommentState {
  final CommentData commentModel;

  const EditingSuccess(this.commentModel);

  @override
  List<Object> get props => [commentModel];
}

final class CommentLoading extends CommentState {}

//final class CommentLoading1 extends CommentState {}

final class CommentFailure extends CommentState {
  final String errMessage;
  const CommentFailure({required this.errMessage});
}

final class SetCommentText extends CommentState {
  final String text;
  final String id;
  const SetCommentText(this.text, this.id);

  @override
  List<Object> get props => [text, id];
}
