import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lms_student/core/widgets/custom_loading.dart';
import 'package:lms_student/features/subject_data/presentation/manager/comment_cubit/comment_cubit.dart';

class NewComment extends StatefulWidget {
  final String lessonId;
  final bool isPosting;
  const NewComment(
      {super.key, required this.isPosting, required this.lessonId});

  @override
  State<NewComment> createState() {
    return _NewCommentState();
  }
}

class _NewCommentState extends State<NewComment> {
  final _commentController = TextEditingController();
  final _focusNode = FocusNode();
  bool editing = false;
  late String commentId;
  @override
  @override
  void initState() {
    super.initState();
    _focusNode.addListener(_onFocusChange);
  }

  void _onFocusChange() {
    if (!_focusNode.hasFocus) {
      setState(() {
        editing = false;
        _commentController.text = '';
      });
    }
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChange);
    _commentController.dispose();
    _focusNode.dispose();

    super.dispose();
  }

  void _submitMessage() async {
    final enteredMessage = _commentController.text;

    if (enteredMessage.trim().isEmpty) {
      return;
    }
    _commentController.clear();
    FocusScope.of(context).unfocus();

    if (editing) {
      BlocProvider.of<CommentCubit>(context)
          .updateComment(comment: enteredMessage, commentId: commentId);
      editing = false;
      return;
    } else {
      BlocProvider.of<CommentCubit>(context)
          .postComment(comment: enteredMessage, lessonId: widget.lessonId);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 0, right: 0, bottom: 0),
      child: Row(
        children: [
          Expanded(
            child: BlocListener<CommentCubit, CommentState>(
              listener: (context, state) {
                if (state is SetCommentText) {
                  commentId = state.id;
                  editing = true;
                  _commentController.text = state.text;
                  _focusNode.requestFocus();
                }
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  focusNode: _focusNode,
                  autofocus: true,
                  controller: _commentController,
                  textCapitalization: TextCapitalization.sentences,
                  decoration: const InputDecoration(
                    labelText: 'كتابة سؤال...',
                  ),
                ),
              ),
            ),
          ),
          widget.isPosting
              ? const CustomLoading()
              : IconButton(
                  color: Theme.of(context).colorScheme.primary,
                  icon: const Icon(
                    Icons.arrow_upward_rounded,
                  ),
                  onPressed: _submitMessage,
                ),
        ],
      ),
    );
  }
}
