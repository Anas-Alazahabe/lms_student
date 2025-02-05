import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:lms_student/constants.dart';
import 'package:lms_student/core/cubits/base_cubit/base_cubit.dart';
import 'package:lms_student/features/auth/data/models/user_model/user.dart';
import 'package:lms_student/features/subject_data/data/models/teacher_profile_model/users_model.dart';
import 'package:lms_student/features/subject_data/presentation/manager/fetch_teacher_profile_cubit.dart';

import 'best_course_Item.dart';

class BestCourseListView extends StatefulWidget {
  const BestCourseListView({super.key});

  @override
  State<BestCourseListView> createState() => _BestCourseListViewState();
}

class _BestCourseListViewState extends State<BestCourseListView> {
  var box = Hive.box<User>(kUser);

  @override
  void initState() {
    if (box.values.first.id != null) {
      BlocProvider.of<FetchTeacherProfileCubit>(context)
          .fetchUser(userId: box.values.first.id.toString(), isTeacher: false);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FetchTeacherProfileCubit, BaseState>(
      builder: (context, state) {
        if (state is Success<UsersModel>) {
          return ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.zero,
            itemCount: state.data.data!.first.subjects!.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child:  BestCourseListViewItem(subject: state.data.data!.first.subjects![index],),
              );
            },
          );
        }
        return Container();
      },
    );
  }
}
