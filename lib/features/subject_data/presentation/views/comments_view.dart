import 'package:comment_tree/data/comment.dart';
import 'package:comment_tree/widgets/comment_tree_widget.dart';
import 'package:comment_tree/widgets/tree_theme_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lms_student/constants.dart';
import 'package:lms_student/core/cubits/shared_preferences_cubit/shared_preferences_cubit.dart';
import 'package:lms_student/core/utils/assets.dart';
import 'package:lms_student/core/utils/functions/custom_toast.dart';
import 'package:lms_student/core/utils/service_locator.dart';
import 'package:lms_student/core/widgets/custom_error.dart';
import 'package:lms_student/core/widgets/custom_loading.dart';
import 'package:lms_student/features/subject_data/data/models/comments_model/comemnt_data.dart';
import 'package:lms_student/features/subject_data/data/models/comments_model/comment_model.dart';
import 'package:lms_student/features/subject_data/presentation/manager/comment_cubit/comment_cubit.dart';
import 'package:lms_student/features/subject_data/presentation/manager/comments_cubit/comments_cubit.dart';
import 'package:lms_student/features/subject_data/presentation/views/widgets/new_comment.dart';
import 'package:shimmer/shimmer.dart';

class CommentsView extends StatefulWidget {
  final String lessonId;

  const CommentsView({super.key, required this.lessonId});

  @override
  State<CommentsView> createState() => _CommentsViewState();
}

class _CommentsViewState extends State<CommentsView> {
  late int length;
  bool lengthSet = false;
  bool posting = false;
  final sharedPreferencesCubit = getIt<SharedPreferencesCubit>();
  List<CommentData> comments = [];
  List<CommentData> editedComments = [];

  @override
  void initState() {
    super.initState();
    BlocProvider.of<CommentsCubit>(context)
        .fetchCommentsData(lessonId: widget.lessonId);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: buildAppBar(),
        body: buildBody(),
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      title: const Text('ساحة النقاش'),
    );
  }

  Widget buildBody() {
    return BlocListener<CommentCubit, CommentState>(
      listener: (context, state) => handleCommentState(context, state),
      child: BlocBuilder<CommentsCubit, CommentsState>(
        builder: (context, state) {
          if (state is CommentsLoading) {
            return const CustomLoading();
          } else if (state is CommentsFailure) {
            return CustomError(errMessage: state.errMessage);
          } else if (state is CommentsSuccess) {
            return buildCommentsList(state);
          }
          return Container();
        },
      ),
    );
  }

  Widget buildCommentsList(CommentsSuccess state) {
    if (!lengthSet) {
      length = state.commentsModel.data!.length;
    }
    lengthSet = true;

    return Column(
      children: [
        Expanded(
          child: state.commentsModel.data!.isEmpty && comments.isEmpty
              ? const Text('لا يوجد أسئلة')
              : buildCommentsListView(state),
        ),
        NewComment(lessonId: widget.lessonId, isPosting: posting),
      ],
    );
  }

  ListView buildCommentsListView(CommentsSuccess state) {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: length,
      itemBuilder: (context, index) =>
          buildCommentContainer(context, state, index),
    );
  }

  Container buildCommentContainer(
      BuildContext context, CommentsSuccess state, int index) {
    CommentData currentComment;

    // Check if the comment has been edited
    bool isEditedComment = false;
    CommentData? editedComment;

    for (var edited in editedComments) {
      if (index > state.commentsModel.data!.length - 1) {
        if (edited.id == comments[length - 1 - index].id) {
          isEditedComment = true;
          editedComment = edited;
          break;
        }
      } else {
        if (edited.id == state.commentsModel.data![index].id) {
          isEditedComment = true;
          editedComment = edited;
          break;
        }
      }
    }

    if (isEditedComment) {
      currentComment = editedComment!;
    } else {
      if (index > state.commentsModel.data!.length - 1) {
        currentComment = comments[length - 1 - index];
      } else {
        currentComment = CommentData.fromSingleJson(
            state.commentsModel.data![index].toJson());
      }
      // state.commentsModel.data![index];
    }

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: CommentTreeWidget<Comment, Comment>(
          Comment(
            avatar: 'null',
            userName: currentComment.name,
            content: currentComment.comment,
          ),
          index >= state.commentsModel.data!.length
              ? []
              : [
                  ...currentComment.replies!.map(
                    (e) => Comment(
                      avatar: 'null',
                      userName: e.name,
                      content: e.text,
                    ),
                  )
                ],
          treeThemeData: const TreeThemeData(
            lineColor: kAppColor,
            lineWidth: 3,
          ),
          avatarRoot: (context, data) => PreferredSize(
            preferredSize: const Size.fromRadius(18),
            child: CircleAvatar(
              radius: 18,
              backgroundColor: Colors.transparent,
              backgroundImage: AssetImage(currentComment.imageIndex == null
                  ? AssetsData.profile
                  : AssetsData.avatars[int.parse(currentComment.imageIndex!)]),
            ),
          ),
          avatarChild: (context, data) => const PreferredSize(
            preferredSize: Size.fromRadius(12),
            child: CircleAvatar(
              radius: 12,
              backgroundColor: Colors.transparent,
              backgroundImage: AssetImage(AssetsData.logo),
            ),
          ),
          contentChild: (context, data) {
            return contentChild(data, context);
          },
          contentRoot: (context, data) {
            return contentRoot(
              data,
              context,
              index,
              state,
              currentComment,
            );
          },
        ),
      ),
    );
  }

  Column contentChild(Comment data, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          constraints: const BoxConstraints(
            minWidth: 100,
            minHeight: 70,
          ),
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
          decoration: BoxDecoration(
              color: Colors.grey[300], borderRadius: BorderRadius.circular(12)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${data.userName}',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.w600, color: Colors.black),
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                '${data.content}',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.w300, color: Colors.black),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Column contentRoot(Comment data, BuildContext context, int index,
      CommentsSuccess state, CommentData currentComment) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          constraints: const BoxConstraints(
            minWidth: 100,
            minHeight: 70,
          ),
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
          decoration: BoxDecoration(
              color: Colors.grey[300], borderRadius: BorderRadius.circular(12)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${data.userName}',
                style: Theme.of(context)
                    .textTheme
                    .bodySmall! //Color(int.parse('0xff${currentComment.data!.color!.split('#')[0]}'))
                    .copyWith(
                      fontWeight: FontWeight.w600,
                    ),
              ),
              const SizedBox(
                height: 4,
              ),
              Text(
                '${data.content}',
                style: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(fontWeight: FontWeight.w300, color: Colors.black),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 4),
          child: Row(
            children: [
              const SizedBox(
                width: 8,
              ),
              if (index >= state.commentsModel.data!.length ||
                  currentComment.comment ==
                      sharedPreferencesCubit.getUsername())
                DefaultTextStyle(
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: Colors.grey[700], fontWeight: FontWeight.bold),
                  child: GestureDetector(
                      onTap: () {
                        BlocProvider.of<CommentCubit>(context).onSetCommentText(
                            data.content!, currentComment.id.toString());

                        //  FocusScope.of(context).requestFocus(FocusNode());
                      },
                      child: const Text('تعديل')),
                ),
            ],
          ),
        )
      ],
    );
  }

  void handleCommentState(BuildContext context, CommentState state) {
    if (state is CommentFailure) {
      customToast(state.errMessage);
      setState(() {
        posting = false;
      });
    } else if (state is CommentLoading) {
      setState(() {
        posting = true;
      });
    } else if (state is CommentSuccess) {
      comments.insert(0, state.commentModel);
      posting = false;
      setState(() {
        length++;
      });
    } else if (state is EditingSuccess) {
      posting = false;
      bool found = false;

      for (int i = 0; i < editedComments.length; i++) {
        if (state.commentModel.id == editedComments[i].id) {
          editedComments[i] = state.commentModel;
          found = true;
          break;
        }
      }
      if (found) {
        setState(() {});
      }

      if (!found) {
        setState(() {
          editedComments.add(state.commentModel);
        });
      }
    }
  }
}
