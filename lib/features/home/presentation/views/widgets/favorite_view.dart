import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lms_student/constants.dart';
import 'package:lms_student/core/cubits/base_cubit/base_cubit.dart';
import 'package:lms_student/core/utils/app_router.dart';
import 'package:lms_student/core/utils/assets.dart';
import 'package:lms_student/core/widgets/custom_loading.dart';
import 'package:lms_student/features/home/data/models/favorite_model/favorite.dart';
import 'package:lms_student/features/home/presentation/manager/get_fav_cubit.dart';

class FavoriteView extends StatefulWidget {
  const FavoriteView({super.key});

  @override
  State<FavoriteView> createState() => _FavoriteViewState();
}

class _FavoriteViewState extends State<FavoriteView> {
  int isFavorite = 0;
  @override
  void initState() {
    super.initState();
    isFavorite = 0;
  }

  var height, width;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      color: Theme.of(context)
          .colorScheme
          .onPrimaryContainer, // استخدام لون الخلفية من الثيم
      // color: Color(0xffebe6e0),
      child: Column(
        children: [
          Container(
            width: width,
            height: 70,
            decoration: const BoxDecoration(
              color: kAppColor,
              //Theme.of(context).colorScheme.onBackground,
            ),
            child: Row(
              children: [
                IconButton(
                  icon: Icon(
                    Icons.favorite,
                    color: Theme.of(context)
                        .colorScheme
                        .onPrimaryContainer, // استخدام اللون من الثيم
                  ),
                  onPressed: () {},
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  'Favorite',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontSize:
                            20, // يمكنك تخصيص الحجم هنا إذا كنت تريد تخصيصه
                        fontWeight:
                            FontWeight.w600, // يمكنك تخصيص الوزن هنا أيضًا
                      ),
                  // TextStyle(
                  //   fontSize: 20,
                  //   fontWeight: FontWeight.bold,
                  //   letterSpacing: 1,
                  // ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            padding: const EdgeInsets.only(
              left: 20,
              right: 10,
              top: 10,
            ),
            decoration: BoxDecoration(
              // color: Color(0xfff5f3ff),
              // color: Color(0xffebe6e0),
              color: Theme.of(context).colorScheme.onPrimaryContainer,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                Material(
                  color:
                      isFavorite == 0 ? kAppColor : kAppColor.withOpacity(0.6),
                  borderRadius: BorderRadius.circular(10),
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        isFavorite = 0;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 28),
                      child: const Text(
                        'Category',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                Material(
                  color:
                      isFavorite == 1 ? kAppColor : kAppColor.withOpacity(0.6),
                  borderRadius: BorderRadius.circular(10),
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        isFavorite = 1;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 28),
                      child: const Text(
                        'Subjects',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                Material(
                  color:
                      isFavorite == 2 ? kAppColor : kAppColor.withOpacity(0.6),
                  borderRadius: BorderRadius.circular(10),
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        isFavorite = 2;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 28),
                      child: const Text(
                        'Teachers',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          if (isFavorite == 0)
            const SubjectSection(
              type: 'Category',
            )
          else if (isFavorite == 1)
            const SubjectSection(
              type: 'Subject',
            )
          else
            const TeachersList()
        ],
      ),
    );
  }
}

class TeachersList extends StatelessWidget {
  const TeachersList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FetchFavoriteCubit, BaseState>(
      builder: (context, state) {
        if (state is Loading) {
          return const CustomLoading();
        }
        if (state is Success<List<Favorite>>) {
          List<Favorite> favTeachers = [];
          for (var element in state.data) {
            if (element.favoritableType == 'App\\Models\\User') {
              favTeachers.add(Favorite(
                  favoritableId: element.favoritableId,
                  favoritableName: element.favoritableName));
            }
          }

          return ListView.builder(
              itemCount: favTeachers.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () {
                      context.push(AppRouter.kTeacherProfileview,
                          extra: favTeachers[index].favoritableId);
                    },
                    child: Card(
                      child: Row(
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Image(
                              image: AssetImage(AssetsData.profile),
                              height: 50,
                              width: 50,
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            favTeachers[index].favoritableName!,
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.black.withOpacity(0.7)),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              });
        }
        return Container();
      },
    );
  }
}

class SubjectSection extends StatelessWidget {
  final String type;
  const SubjectSection({super.key, required this.type});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FetchFavoriteCubit, BaseState>(
      builder: (context, state) {
        if (state is Loading) {
          return const CustomLoading();
        }
        if (state is Success<List<Favorite>>) {
          List<Favorite> favSubjects = [];
          for (var element in state.data) {
            if (element.favoritableType == 'App\\Models\\$type') {
              favSubjects.add(Favorite(
                  favoritableId: element.favoritableId,
                  favoritableName: element.favoritableName));
            }
          }
          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 1.1,
              mainAxisSpacing: 25,
            ),
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: favSubjects.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {},
                child: Container(
                  margin:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Theme.of(context).colorScheme.onSecondary,
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26,
                        spreadRadius: 1,
                        blurRadius: 6,
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Image(
                        image: AssetImage(AssetsData.logo),
                        width: 50,
                      ),
                      Text(
                        favSubjects[index].favoritableName!,
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                      )
                    ],
                  ),
                ),
              );
            },
          );
        }
        return Container();
      },
    );
  }
}
