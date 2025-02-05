import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lms_student/constants.dart';
import 'package:lms_student/core/cubits/base_cubit/base_cubit.dart';
import 'package:lms_student/core/utils/assets.dart';
import 'package:lms_student/core/widgets/custom_error.dart';
import 'package:lms_student/core/widgets/custom_loading.dart';
import 'package:lms_student/core/widgets/not_favoraite.dart';
import 'package:lms_student/core/widgets/yes_favorite.dart';
import 'package:lms_student/features/auth/data/models/user_model/user.dart';
import 'package:lms_student/features/home/data/models/favorite_model/favorite.dart';
import 'package:lms_student/features/home/presentation/manager/favorite_cubit.dart';
import 'package:lms_student/features/home/presentation/manager/get_fav_cubit.dart';
import 'package:lms_student/features/subject_data/data/models/teacher_profile_model/users_model.dart';
import 'package:lms_student/features/subject_data/presentation/manager/fetch_teacher_profile_cubit.dart';
import 'package:lms_student/features/subject_data/presentation/views/widgets/quizzes_teacher.dart';

import 'widgets/test.dart';

class TeacherProfileView extends StatefulWidget {
  final String teacherId;
  const TeacherProfileView({super.key, required this.teacherId});

  @override
  State<TeacherProfileView> createState() => _TeacherProfileViewState();
}

class _TeacherProfileViewState extends State<TeacherProfileView> {
  int isProfilesuction = 0;
  var width, height;

  @override
  void initState() {
    super.initState();

    BlocProvider.of<FetchFavoriteCubit>(context).get();
    BlocProvider.of<FetchTeacherProfileCubit>(context)
        .fetchUser(userId: widget.teacherId, isTeacher: true);
  }

  void initState2() {
    // TODO: implement initState
    super.initState();
    isProfilesuction = 0;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocBuilder<FetchTeacherProfileCubit, BaseState>(
        builder: (context, state) {
          if (state is Loading) {
            return const Scaffold(
              body: CustomLoading(),
            );
          }

          if (state is Success<UsersModel>) {
            return Scaffold(
              appBar: AppBar(
                foregroundColor: Colors.black,
                backgroundColor: Colors.white,
                elevation: 0,
                centerTitle: true,
                leading: Builder(
                  builder: (BuildContext context) {
                    return IconButton(
                      icon: const Icon(
                        Icons.arrow_back,
                        color: kAppColor,
                      ),
                      onPressed: () {
                        context.pop();
                      },
                    );
                  },
                ),
                actions: [
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: BlocListener<FavoriteCubit, BaseState>(
                      listener: (context, state) {
                        // if (state is Success<FavoriteModel>) {
                        BlocProvider.of<FetchFavoriteCubit>(context).get();
                        // }
                      },
                      child: IconButton(
                        onPressed: () {
                          BlocProvider.of<FavoriteCubit>(context).post(
                            teacherName: state.data.data!.first.name,
                          );
                        },
                        icon: BlocBuilder<FetchFavoriteCubit, BaseState>(
                          builder: (context, state1) {
                            if (state1 is Loading) {
                              return const CustomLoading();
                            }
                            if (state1 is Success<List<Favorite>>) {
                              for (var element in state1.data) {
                                if (element.favoritableType ==
                                        'App\\Models\\User' &&
                                    element.favoritableName ==
                                        state.data.data!.first.name) {
                                  return const YesFavorite();
                                }
                              }
                            }
                            return const NotFavoraite();
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              body: Container(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image(
                            image: AssetImage(AssetsData.profile),
                            height: 50,
                            width: 50,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Column(
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Welcom'.tr(),
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              state.data.data!.first.name!,
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black.withOpacity(0.7)),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                        decoration: BoxDecoration(
                          color: Color(0xfff5f3ff),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Material(
                              color: isProfilesuction == 0
                                  ? kAppColor
                                  : kAppColor.withOpacity(0.6),
                              borderRadius: BorderRadius.circular(10),
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    isProfilesuction = 0;
                                  });
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 5, horizontal: 18),
                                  child: Text(
                                    'personal Info'.tr(),
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 2,
                            ),
                            Material(
                              color: isProfilesuction == 1
                                  ? kAppColor
                                  : kAppColor.withOpacity(0.6),
                              borderRadius: BorderRadius.circular(10),
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    isProfilesuction = 1;
                                  });
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 5, horizontal: 25),
                                  child: Text(
                                    'Subject'.tr(),
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 2,
                            ),
                            Material(
                              color: isProfilesuction == 2
                                  ? kAppColor
                                  : kAppColor.withOpacity(0.6),
                              borderRadius: BorderRadius.circular(10),
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    isProfilesuction = 2;
                                  });
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 5, horizontal: 30),
                                  child: Text(
                                    'Quizes'.tr(),
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    if (isProfilesuction == 0)
                      profileinfo(
                        email: state.data.data!.first.email!,
                        brith: state.data.data!.first.birthDate!,
                      )
                    else if (isProfilesuction == 1)
                      subjectteachers(
                        subject: state.data.data!.first.subjects!,
                      )
                    else
                      quizzesTeacher(quiz: state.data.data!.first.exams??[])
                  ],
                ),
              ),
            );
          }
          return Scaffold(body: Container());
        },
      ),
    );
  }
}

class profileinfo extends StatelessWidget {
  final String email;
  final String brith;

  const profileinfo({
    super.key,
    required this.email,
    required this.brith,
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              // Icon(
              //   Icons.date_range_outlined,
              //   size: 20,
              //   color: Colors.black38,
              // ),
              SizedBox(width: 4),
              Text(
                'email'.tr(),
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: 4),
          Text(
            email,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Divider(
            color: Colors.grey[900],
          ),
          SizedBox(height: 16),
          SizedBox(
            height: 10,
          ),
          SizedBox(height: 16),
          Row(
            children: [
              // Icon(
              //   Icons.email_outlined,
              //   size: 20,
              //   color: Colors.black38,
              // ),
              SizedBox(width: 4),
              Text(
                'Date of Birth:'.tr(),
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: 4),
          Text(
            brith,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Divider(
            color: Colors.grey[900],
          ),
          SizedBox(height: 16),
          // Row(
          //   children: [
          //     // Icon(
          //     //   Icons.check_circle_outline,
          //     //   size: 20,
          //     //   color: Colors.black38,
          //     // ),
          //     SizedBox(width: 4),
          //     Text(
          //       'Exist'.tr(),
          //       style: TextStyle(
          //         fontSize: 18,
          //         fontWeight: FontWeight.bold,
          //       ),
          //     ),
          //   ],
          // ),
          // SizedBox(height: 4),
          // Padding(
          //   padding: const EdgeInsets.only(left: 8.0),
          //   child: Text(
          //     'Yes',
          //     style: TextStyle(
          //       fontSize: 16,
          //       color: Colors.grey[600],
          //     ),
          //   ),
          // ),
          // SizedBox(
          //   height: 10,
          // ),
          // Divider(
          //   color: Colors.grey[900],
          // ),
          SizedBox(height: 16),
        ],
      ),
    );
  }
}
