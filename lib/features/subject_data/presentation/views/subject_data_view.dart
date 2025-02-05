import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lms_student/constants.dart';
import 'package:lms_student/core/cubits/base_cubit/base_cubit.dart';
import 'package:lms_student/core/widgets/custom_loading.dart';
import 'package:lms_student/features/home/data/models/favorite_model/favorite.dart';
import 'package:lms_student/features/home/data/models/subjects_model/subject.dart';
import 'package:lms_student/features/home/presentation/manager/favorite_cubit.dart';
import 'package:lms_student/features/home/presentation/manager/get_fav_cubit.dart';
import 'package:lms_student/features/subject_data/presentation/views/widgets/subject_data_view_body.dart';

import '../../../../core/widgets/not_favoraite.dart';
import '../../../../core/widgets/yes_favorite.dart';

class SubjectDataView extends StatefulWidget {
  final Subject subject;
  const SubjectDataView({super.key, required this.subject});

  @override
  State<SubjectDataView> createState() => _SubjectDataViewState();
}

class _SubjectDataViewState extends State<SubjectDataView> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<FetchFavoriteCubit>(context).get();
  }

  @override
  Widget build(BuildContext context) {
    // bool isfavorited = false;
    // Favorite? favorite;
    return SafeArea(
      child: Scaffold(
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
          title: Text(
            widget.subject.name!,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              letterSpacing: 1,
            ),
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
                      subjectName: widget.subject.name!,
                    );
                  },
                  icon: BlocBuilder<FetchFavoriteCubit, BaseState>(
                    builder: (context, state) {
                      if (state is Loading) {
                        return const CustomLoading();
                      }
                      if (state is Success<List<Favorite>>) {
                        for (var element in state.data) {
                          if (element.favoritableType ==
                                  'App\\Models\\Subject' &&
                              element.favoritableName == widget.subject.name) {
                            return YesFavorite();
                          }
                        }
                      }
                      return NotFavoraite();
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
        body: SubjectDataViewBody(
          subject: widget.subject,
        ),
      ),
    );
  }
}
