import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hive/hive.dart';
import 'package:lms_student/constants.dart';
import 'package:lms_student/core/cubits/base_cubit/base_cubit.dart';
import 'package:lms_student/core/utils/app_router.dart';
import 'package:lms_student/core/utils/assets.dart';
import 'package:lms_student/core/utils/functions/kick_user_dialog.dart';
import 'package:lms_student/core/utils/functions/reset_app.dart';
import 'package:lms_student/core/widgets/custom_error.dart';
import 'package:lms_student/core/widgets/custom_loading.dart';
import 'package:lms_student/features/auth/data/models/user_model/user.dart';
import 'package:lms_student/features/home/data/models/favorite_model/favorite.dart';
import 'package:lms_student/features/home/data/models/subjects_model/subjects_model.dart';
import 'package:lms_student/features/home/presentation/manager/ad_cubit.dart';
import 'package:lms_student/features/home/presentation/manager/bookmark_cubit/fetch_mark_cubit.dart';
import 'package:lms_student/features/home/presentation/manager/get_fav_cubit.dart';
import 'package:lms_student/features/home/presentation/manager/subjects_cubit.dart';
import 'package:lms_student/features/home/presentation/views/widgets/favorite_view.dart';
import 'package:lms_student/features/home/presentation/views/widgets/shimmer_subjects_list_view.dart';
import 'package:lms_student/features/subject_data/presentation/manager/fetch_teacher_profile_cubit.dart';

import 'bestcourse_list_view.dart';
import 'category_item.dart';
import 'home_ads.dart';
import 'home_view_body_header.dart';
import 'my_search.dart';
import 'navigation_bar.dart';

class HomeViewBody extends StatefulWidget {
  const HomeViewBody({
    super.key,
    required this.rand,
// required this.screenHeight,
// required this.gradeId,
    required this.action,
  });
  final VoidCallback action;
// final String gradeId;
  final int rand;
// final double screenHeight;

  @override
  State<HomeViewBody> createState() => _HomeViewBodyState();
}

class _HomeViewBodyState extends State<HomeViewBody> {
  var box = Hive.box<User>(kUser);
  @override
  void initState() {
// BlocProvider.of<SubjectsCubit>(context)
// .fetchSubjects(gradeId: widget.gradeId);
    BlocProvider.of<AdCubit>(context).fetchAds(all: false);
    BlocProvider.of<SubjectsCubit>(context)
        .fetchSubjects(yearId: box.values.first.yearId);

    BlocProvider.of<FetchFavoriteCubit>(context).get();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        SliverToBoxAdapter(
          child: HomeViewBodyHeader(
            rand: widget.rand,
            action: widget.action,
          ),
        ),
        // SliverToBoxAdapter(
        //   child: GestureDetector(
        //     child: Container(
        //       color: Colors.red,
        //       child: const Text('search'),
        //     ),
        //     onTap: () {
        //       showSearch(
        //           context: context,
        //           delegate: MySearch()); // replace this with your actual data
        //     },
        //   ),
        // ),
        const SliverToBoxAdapter(
          child: HomeAds(),
        ),
        SliverToBoxAdapter(
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20)),
              // color: Colors.grey[300],
              //color: Colors.grey.shade200,
              color: Theme.of(context).colorScheme.onBackground,
              //color: Color(0xfff8f7f4),
              //color: Color(0xfffcfcf7),

              // image: DecorationImage(
              //   fit: BoxFit.cover,
              //   image: AssetImage(AssetsData.background),
              // ),
            ),
            child: Column(
              children: [
                BlocConsumer<SubjectsCubit, BaseState>(
                    listener: (context, state) {
                  if (state is Failure && state.errorMessage == 'غير مصرح') {
                    kickUserDialog(context);
                    resetApp();
                  }
                }, builder: (context, state) {
                  if (state is Failure) {
                    return SizedBox(
                        height: 600,
                        child: CustomError(errMessage: state.errorMessage));
                  }
                  if (state is Loading) {
                    return const ShimmerSubjectsListView();
                  }
                  if (state is Success<SubjectsModel>) {
                    return SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SingleChildScrollView(
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 5),
                                  child: Text('Categories:',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge
                                          ?.copyWith(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          )),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 200,
                            child: BlocConsumer<FetchFavoriteCubit, BaseState>(
                              listener: (context, state1) {
                                if (state1 is Failure &&
                                    state1.errorMessage == 'the device_id is null') {
                                  kickUserDialog(context);
                                  resetApp();
                                }
                              },
                              builder: (context, state1) {
                                if (state1 is Loading) {
                                  return const CustomLoading();
                                }
                                if (state1 is Success<List<Favorite>>) {
                                  return ListView.builder(
                                    shrinkWrap: true,
                                    // physics: const NeverScrollableScrollPhysics(),
                                    itemCount: state.data.data!.length,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, index) {
                                      return CategoryItem(
                                        favs: state1.data,
                                        cateName: state.data.data![index]
                                            .category!.category!,
                                        subjectss:
                                            state.data.data![index].subjects!,
                                      );
                                    },
                                  );
                                }
                                return ListView.builder(
                                  shrinkWrap: true,
                                  // physics: const NeverScrollableScrollPhysics(),
                                  itemCount: state.data.data!.length,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) {
                                    return CategoryItem(
                                      favs: const [],
                                      cateName: state.data.data![index]
                                          .category!.category!,
                                      subjectss:
                                          state.data.data![index].subjects!,
                                    );
                                  },
                                );
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            child: Text(
                              ' Courses',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          ),
                          const BestCourseListView(),
                        ],
                      ),
                    );
                  }
                  return Container();
                }),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
