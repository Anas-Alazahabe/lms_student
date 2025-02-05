import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lms_student/constants.dart';
import 'package:lms_student/core/cubits/base_cubit/base_cubit.dart';
import 'package:lms_student/core/utils/app_router.dart';
import 'package:lms_student/core/widgets/custom_loading.dart';
import 'package:lms_student/core/widgets/not_favoraite.dart';
import 'package:lms_student/core/widgets/yes_favorite.dart';
import 'package:lms_student/features/home/data/models/bookmark_model/bookmark.dart';
import 'package:lms_student/features/home/data/models/favorite_model/favorite.dart';
import 'package:lms_student/features/home/presentation/manager/bookmark_cubit/fetch_mark_cubit.dart';
import 'package:lms_student/features/home/presentation/manager/bookmark_cubit/post_mark_cubit.dart';
import 'package:lms_student/features/subject_data/data/models/units_model/lesson.dart';
import 'package:lms_student/features/subject_data/data/models/units_model/unit_data.dart';

// class UnitListViewItem extends StatefulWidget {
//   final UnitData unit;
//   final String subjectName;
//   final String subjectId;
//   const UnitListViewItem({
//     super.key,
//     required this.unit,
//     required this.subjectName, required this.subjectId,
//   });

//   @override
//   State<UnitListViewItem> createState() => _UnitListViewItemState();
// }

// class _UnitListViewItemState extends State<UnitListViewItem> {
//   late List<Lesson> unitsLesson;

//   @override
//   void initState() {
//     unitsLesson = widget.unit.lessons!;
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Card(
//         //  elevation: 10,
//         child: ExpansionTile(
//             // leading: ClipRRect(
//             //   child: SizedBox(

//             //     width: 100,
//             //     child: CachedNetworkImage(
//             //       fit: BoxFit.cover,
//             //       imageUrl: '$kBaseUrlAsset/images/${unit.photo}',
//             //       progressIndicatorBuilder: (context, url, progress) {
//             //         return const CustomLoading();
//             //       },
//             //       errorWidget: (context, url, error) {
//             //         return Image.asset(AssetsData.logo);
//             //       },
//             //     ),
//             //   ),
//             // ),
//             title: Text(widget.unit.name!),
//             children: [
//               ...unitsLesson.map((lesson) {
//                 return InkWell(
//                   onTap: () {
//                     context.push(AppRouter.kLessonView, extra: {
//                       'lesson': lesson,
//                       'subjectName': widget.subjectName,
//                       'unitName': widget.unit.name,
//                       'subject_id': widget.subjectId
//                     });
//                   },
//                   child: Card(child: ListTile(title: Text(lesson.name!))),
//                 );
//               }),
//             ]),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lms_student/core/utils/app_router.dart';
import 'package:lms_student/features/subject_data/data/models/units_model/lesson.dart';
import 'package:lms_student/features/subject_data/data/models/units_model/unit_data.dart';

enum SampleItem { itemOne, itemTwo, itemThree }

class UnitListViewItem extends StatefulWidget {
  final UnitData unit;
  final String subjectName;
  final String subjectId;
  // final String unitname;
  // final List<Bookmark> books;
  const UnitListViewItem({
    super.key,
    required this.unit,
    required this.subjectName,
    required this.subjectId,
    // required this.unitname,
    // required this.books,
  });

  @override
  State<UnitListViewItem> createState() => _UnitListViewItemState();
}

class _UnitListViewItemState extends State<UnitListViewItem> {
  SampleItem? selectedMenu;
  bool isExpanded = false;

  // bool isbook = false;
  // @override
  // void initState() {
  //   for (var element in widget.books) {
  //     if (element.bookmarkableType == 'App\\Models\\Unit' &&
  //         element.bookmarkName == widget.unitname) {
  //       isbook = true;
  //       return;
  //     }
  //     isbook = false;
  //   }
  //   super.initState();
  // }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<FetchBookMarkCubit>(context).get();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Color(0XFFDEE1E6),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      elevation: 0.5,
      margin: const EdgeInsets.all(10),
      child: Column(
          // leading: ClipRRect(
          //   child: SizedBox(

          //     width: 100,
          //     child: CachedNetworkImage(
          //       fit: BoxFit.cover,
          //       imageUrl: '$kBaseUrlAsset/images/${unit.photo}',
          //       progressIndicatorBuilder: (context, url, progress) {
          //         return const CustomLoading();
          //       },
          //       errorWidget: (context, url, error) {
          //         return Image.asset(AssetsData.logo);
          //       },
          //     ),
          //   ),
          // ),

          children: <Widget>[
            ListTile(
              title: Text(widget.unit.name!,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    //color: kAppColor
                    color: Theme.of(context).textTheme.bodyLarge?.color,
                  )),
              // subtitle: Text('data'),
              subtitle: BlocListener<PostBookMarkcubit, BaseState>(
                listener: (context, state) {
                  BlocProvider.of<FetchBookMarkCubit>(context).get();
                },
                child: IconButton(
                  onPressed: () {
                    BlocProvider.of<PostBookMarkcubit>(context).post(
                      unitName: widget.unit.name,
                    );
                  },
                  icon: BlocBuilder<FetchBookMarkCubit, BaseState>(
                    builder: (context, state) {
                      if (state is Loading) {
                        return const CustomLoading();
                      }
                      if (state is Success<List<Bookmark>>) {
                        for (var element in state.data) {
                          if (element.bookmarkableType == 'App\\Models\\Unit' &&
                              element.bookmarkName == widget.unit.name) {
                            return YesFavorite();
                          }
                        }
                      }
                      return NotFavoraite();
                    },
                  ),
                ),
              ),

              trailing: IconButton(
                icon: Icon(isExpanded ? Icons.expand_less : Icons.expand_more),
                onPressed: () {
                  setState(() {
                    isExpanded = !isExpanded;
                  });
                },
              ),
            ),
            if (isExpanded)
              Column(
                children: [
                  ...widget.unit.lessons!
                      .map((lesson) => InkWell(
                            onTap: () {
                              context.push(AppRouter.kLessonView, extra: {
                                'lesson': lesson,
                                'subjectName': widget.subjectName,
                                'unitName': widget.unit.name,
                                'subject_id': widget.subjectId
                              });

                              // context.push(AppRouter.kLessonView, extra: {
                              //   'lesson': lesson,
                              //   'subjectName': Widget.,
                              //   'unitName': widget.unit.name,
                              //   'subject_id': widget.subjectId
                              // }

                              // );
                            },
                            child: Container(
                              margin: EdgeInsets.all(15),
                              height: 55,
                              decoration: BoxDecoration(
                                  // color: Colors.grey,
                                  ),
                              child: Card(
                                color: Colors.grey[200],
                                elevation: 2,
                                child: Row(
                                  children: [
                                    SizedBox(width: 10),
                                    Icon(Icons.book,
                                        size: 20, color: kAppColor),
                                    SizedBox(width: 10),
                                    Text(lesson.name!,
                                        style: TextStyle(fontSize: 16)),
                                  ],
                                ),
                              ),
                            ),
                          ))
                      .toList(),
                ],
              ),

            //  ...unitsLesson.map((lesson) {
            //    return InkWell(
            //      onTap: () {
            //        context.push(AppRouter.kLessonView, extra: {
            //          'lesson': lesson,
            //          'subjectName': widget.subjectName,
            //          'unitName': widget.unit.name,
            //        });
            //      },
            //      child: Card(child: ListTile(title: Text(lesson.name!))),
            //    );
            //  }),
          ]),
    );

    //  Padding(
    //   padding: const EdgeInsets.all(8.0),
    //   child: ExpansionTile(
    //       // leading: ClipRRect(
    //       //   child: SizedBox(

    //       //     width: 100,
    //       //     child: CachedNetworkImage(
    //       //       fit: BoxFit.cover,
    //       //       imageUrl: '$kBaseUrlAsset/images/${unit.photo}',
    //       //       progressIndicatorBuilder: (context, url, progress) {
    //       //         return const CustomLoading();
    //       //       },
    //       //       errorWidget: (context, url, error) {
    //       //         return Image.asset(AssetsData.logo);
    //       //       },
    //       //     ),
    //       //   ),
    //       // ),
    //       title: Text(
    //         unit.name!,
    //         style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
    //       ),
    //       children: [
    //         ...unit.lessons!.map((lesson) {
    //           return InkWell(
    //             onTap: () {
    //               context.push(AppRouter.kLessonView, extra: {
    //                 'lesson': lesson,
    //                 'subjectName': subjectName,
    //                 'unitName': unit.name,
    //               });
    //             },
    //             child: Text(
    //               lesson.name!,
    //               style: TextStyle(
    //                 fontSize: 20,
    //                 fontWeight: FontWeight.w600,
    //               ),
    //             ),
    //           );
    //         })
    //       ]),
    // );
  }
}
