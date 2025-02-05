import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lms_student/constants.dart';
import 'package:lms_student/core/cubits/base_cubit/base_cubit.dart';
import 'package:lms_student/core/utils/app_router.dart';
import 'package:lms_student/core/utils/assets.dart';
import 'package:lms_student/core/widgets/not_favoraite.dart';
import 'package:lms_student/core/widgets/yes_favorite.dart';
import 'package:lms_student/features/home/data/models/favorite_model/favorite.dart';
import 'package:lms_student/features/home/data/models/subjects_model/subject.dart';
import 'package:lms_student/features/home/presentation/manager/favorite_cubit.dart';
import 'package:lms_student/features/home/presentation/manager/get_fav_cubit.dart';
import 'package:lms_student/features/home/presentation/views/widgets/favorite_view.dart';

class CategoryItem extends StatefulWidget {
  const CategoryItem(
      {super.key,
      required this.cateName,
      required this.subjectss,
      required this.favs});
  final String cateName;
  final List<Subject> subjectss;
  final List<Favorite> favs;

  @override
  State<CategoryItem> createState() => _CategoryItemState();
}

class _CategoryItemState extends State<CategoryItem> {
  bool isFav = false;
  @override
  void initState() {
    for (var element in widget.favs) {
      if (element.favoritableType == 'App\\Models\\Category' &&
          element.favoritableName == widget.cateName) {
        isFav = true;
        return;
      }
      isFav = false;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () {
          context.push(AppRouter.kSubject, extra: widget.subjectss);
        },
        child: Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
            // margin: EdgeInsets.symmetric(horizontal: 5),
            child: Stack(children: [
              Container(
                // width: 170,
                // height: 150,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        // spreadRadius: 2,
                        blurRadius: 0,
                      )
                    ]),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    //و حطت بادينغ هوريزنتال10
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        alignment: Alignment.center,
                        child: const Image(
                          image: AssetImage(
                            AssetsData.logoIcon,
                          ),
                          width: 80,
                          height: 100,
                        ),
                      ),
                      Text(
                        widget.cateName.tr(),
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ],
                  ),
                ),
              ),
              BlocListener<FavoriteCubit, BaseState>(
                listener: (context, state) {
                  // if (state is Success<FavoriteModel>) {
                  BlocProvider.of<FetchFavoriteCubit>(context).get();
                  // }
                },
                child: Positioned(
                    top: 0,
                    right: 0,
                    child: IconButton(
                        onPressed: () {
                          BlocProvider.of<FavoriteCubit>(context)
                              .post(categoryName: widget.cateName);
                        },
                        icon: isFav
                            ? const YesFavorite()
                            : const NotFavoraite())),
              )
            ])));
  }
}
