import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lms_student/core/cubits/base_cubit/base_cubit.dart';
import 'package:lms_student/core/utils/app_router.dart';
import 'package:lms_student/core/widgets/custom_loading.dart';
import 'package:lms_student/features/subject_data/data/models/quizzes_model/quiz.dart';
import 'package:lms_student/features/subject_data/data/models/quizzes_model/quizzes_model.dart';
import 'package:lms_student/features/subject_data/presentation/manager/quizzes/fetch_quizzes_cubit.dart';

class QuizzseListView extends StatefulWidget {
  final String subjectId;
  final String type;
  final String parentId;

  // final List<Video> videos;
  // final String imageUrl;

  const QuizzseListView({
    super.key,
    required this.subjectId,
    required this.type,
    required this.parentId,
    // required this.videos,
    // required this.lessonId,
    // required this.imageUrl,
    // required this.subjectName,
    // required this.unitName,
  });

  @override
  State<QuizzseListView> createState() => _QuizzseListViewState();
}

class _QuizzseListViewState extends State<QuizzseListView> {
  List<Quiz> quizzes = [];

  @override
  void initState() {
    // videos = widget.videos;
    super.initState();
    BlocProvider.of<FetchQuizzesCubit>(context).fetchQuizzes(
        subjectId: widget.subjectId,
        type: widget.type,
        typeId: widget.parentId);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            BlocConsumer<FetchQuizzesCubit, BaseState>(
              listener: (context, state) {
                if (state is Success<QuizzesModel>) {
                  quizzes.addAll(state.data.openQuizzes!);
                  quizzes.addAll(state.data.lockQuizzes!);
                }
              },
              builder: (context, state) {
                if (state is Loading) {
                  return const CustomLoading();
                }
                if (state is Success<QuizzesModel>) {
                  return Column(
                    children: [
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: state.data.lockQuizzes!.length,
                        itemBuilder: (context, index) {
                          return state.data.lockQuizzes!.isEmpty
                              ? const Text('لا يوجد اختبارات')
                              : Padding(
                                  padding: const EdgeInsets.only(bottom: 8),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        border: Border.all(
                                            color: Colors.grey, width: 2)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        children: [
                                          Row(children: [
                                            const Icon(Icons.quiz),
                                            const SizedBox(
                                              width: 20,
                                            ),
                                            Text(
                                              state.data.lockQuizzes![index]
                                                  .name!,
                                              style:
                                                  const TextStyle(fontSize: 24),
                                            ),
                                            const Spacer(),
                                            const Icon(Icons.lock),
                                          ])
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                        },
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: state.data.openQuizzes!.length,
                        itemBuilder: (context, index) {
                          return state.data.openQuizzes!.isEmpty
                              ? const Text('لا يوجد اختبارات')
                              : InkWell(
                                  onTap: () {
                                    context.push(AppRouter.kQuizView, extra: {
                                      'quiz': state.data.openQuizzes![index]
                                    });
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(bottom: 8),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          border: Border.all(
                                              color: Colors.grey, width: 2)),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          children: [
                                            Row(children: [
                                              const Icon(Icons.quiz),
                                              const SizedBox(
                                                width: 20,
                                              ),
                                              Text(
                                                state.data.openQuizzes![index]
                                                    .name!,
                                                style: const TextStyle(
                                                    fontSize: 24),
                                              ),
                                              const Spacer(),
                                            ])
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                        },
                      ),
                    ],
                  );
                }
                return Container();
              },
            ),
          ],
        ));
  }
}
