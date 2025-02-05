import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lms_student/constants.dart';
import 'package:lms_student/core/cubits/base_cubit/base_cubit.dart';
import 'package:lms_student/core/cubits/directory_cubit/directory_cubit.dart';
import 'package:lms_student/core/cubits/shared_preferences_cubit/shared_preferences_cubit.dart';
import 'package:lms_student/core/utils/app_router.dart';
import 'package:lms_student/core/utils/assets.dart';
import 'package:go_router/go_router.dart';
import 'package:lms_student/core/cubits/base_cubit/base_cubit.dart';
import 'package:lms_student/core/cubits/directory_cubit/directory_cubit.dart';
import 'package:lms_student/core/cubits/shared_preferences_cubit/shared_preferences_cubit.dart';
import 'package:lms_student/core/enums/types_enum.dart';
import 'package:lms_student/core/utils/functions/custom_toast.dart';
import 'package:lms_student/core/utils/service_locator.dart';
import 'package:lms_student/core/widgets/custom_error.dart';
import 'package:lms_student/core/widgets/custom_loading.dart';
import 'package:lms_student/features/home/data/models/subjects_model/subject.dart';
import 'package:lms_student/features/home/presentation/views/widgets/subject_widget/unit_section.dart';
import 'package:lms_student/features/subject_data/data/models/units_model/unit.dart';
import 'package:lms_student/features/subject_data/data/repo/subject_repo_impl.dart';
import 'package:lms_student/features/subject_data/presentation/manager/buy_subject_cubit.dart';
import 'package:lms_student/features/subject_data/presentation/manager/units_cubit.dart';
import 'package:lms_student/features/subject_data/presentation/views/widgets/files_list_view.dart';
import 'package:lms_student/features/subject_data/presentation/views/widgets/unit_list_view_item.dart';
import 'package:lms_student/features/subject_data/presentation/views/widgets/quizzes_list_view.dart';
import 'package:lms_student/features/subject_data/presentation/views/widgets/units_list_view.dart';

import 'header_image.dart';

class SubjectDataViewBody extends StatefulWidget {
  final Subject subject;

  const SubjectDataViewBody({super.key, required this.subject});

  @override
  State<SubjectDataViewBody> createState() => _SubjectDataViewBodyState();
}

class _SubjectDataViewBodyState extends State<SubjectDataViewBody>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  final SharedPreferencesCubit sharedPreferencesCubit =
      getIt<SharedPreferencesCubit>();
  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
    tabController.addListener(_handleTabSelection);
    BlocProvider.of<UnitsCubit>(context)
        .fetchUnits(subjectId: widget.subject.id.toString());
  }

  void _handleTabSelection() {
    if (tabController.indexIsChanging) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    super.dispose();
    tabController.dispose();
    tabController.removeListener(_handleTabSelection);
  }

  final dir = getIt<DirectoryCubit>();
  int isUnitsSection = 0;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UnitsCubit, BaseState>(
      builder: (context, state) {
        if (state is Loading) {
          return const CustomLoading();
        }
        if (state is Failure) {
          return CustomError(errMessage: state.errorMessage);
        }
        if (state is Success<Unitt>) {
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: ListView(
              children: [
                Container(
                  padding: EdgeInsets.all(5),
                  width: MediaQuery.of(context).size.width,
                  height: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Color(0xfff5f3ff),
                    image: DecorationImage(
                        image: AssetImage(AssetsData.video), fit: BoxFit.cover),
                  ),
                  child: Center(
                    child: Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.play_arrow_rounded,
                        color: kAppColor,
                        size: 45,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    Text(
                      widget.subject.name!,
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const Spacer(),
                    if (!state.data.isSubscription!)
                      TextButton(
                        onPressed: () async {
                          final buySuccess = await showModalBottomSheet(
                            context: context,
                            builder: (context) => GooglePayBottomSheet(
                              subjectId: widget.subject.id!.toString(),
                            ),
                          );
                          if (buySuccess != null && buySuccess) {
                            BlocProvider.of<UnitsCubit>(context).fetchUnits(
                                subjectId: widget.subject.id.toString());
                          }
                        },
                        child: Text(
                          widget.subject.price.toString(),
                        ),
                      ),
                    const Spacer(),
                    IconButton(
                      icon: Icon(
                          state.data.isSubscription!
                              ? Icons.lock_open
                              : Icons.lock,
                          color: state.data.isSubscription!
                              ? Colors.green
                              : Colors.red),
                      onPressed: () {
                        customToast(
                            'you have to buy this course to be able to access its data');
                      },
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: () {
                    context.push(AppRouter.kTeacherProfileview,
                        extra: widget.subject.users!.first.id);
                  },
                  child: Text(
                    'By - ${widget.subject.users!.first.name}',
                    style: TextStyle(
                      color: Colors.blueAccent,
                    ),
                  ),
                ),
                SizedBox(
                  height: 3,
                ),
                Text(
                  '${widget.subject.description}',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.black.withOpacity(0.7),
                    fontSize: 16,
                  ),
                ),
                SizedBox(
                  height: 3,
                ),
                // Text(
                //   ' ${state.data.data!.length} Unit',
                //   style: TextStyle(
                //     fontSize: 15,
                //     fontWeight: FontWeight.w500,
                //     color: Colors.black.withOpacity(0.5),
                //   ),
                // ),
                // SizedBox(
                //   height: 20,
                // ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  decoration: BoxDecoration(
                    color: Color(0xfff5f3ff),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Material(
                        color: isUnitsSection == 0
                            ? kAppColor
                            : kAppColor.withOpacity(0.6),
                        borderRadius: BorderRadius.circular(10),
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              isUnitsSection = 0;
                            });
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 5, horizontal: 28),
                            child: Text(
                              '${state.data.data!.length} Units'.tr(),
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
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
                        color: isUnitsSection == 1
                            ? kAppColor
                            : kAppColor.withOpacity(0.6),
                        borderRadius: BorderRadius.circular(10),
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              isUnitsSection = 1;
                              // isComments= false;
                            });
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 5, horizontal: 28),
                            child: Text(
                              'Files'.tr(),
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
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
                        color: isUnitsSection == 2
                            ? kAppColor
                            : kAppColor.withOpacity(0.6),
                        borderRadius: BorderRadius.circular(10),
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              isUnitsSection = 2;
                            });
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 5, horizontal: 30),
                            child: Text(
                              'Quizes'.tr(),
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                if (isUnitsSection == 0)
                  UnitsListView(
                    subjectName: widget.subject.name!,
                    units: state.data,
                    subjectId: widget.subject.id.toString(),
                  )
                else if (isUnitsSection == 1)
                  FilesListView(
                    imageUrl: widget.subject.imageData ?? '',
                    files: widget.subject.files!,
                    lessonId: null,
                    subjectId: widget.subject.id,
                  )
                else
                  QuizzseListView(
                    parentId: widget.subject.id!.toString(),
                    subjectId: widget.subject.id!.toString(),
                    type: Types.subject.name,
                  )
              ],
            ),
          );
        }
        return Container();
      },
    );
  }
}

// class GooglePayBottomSheet extends StatelessWidget {
//   final String subjectId;
//   const GooglePayBottomSheet({super.key, required this.subjectId});

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) => BuySubjectCubit(
//         getIt<SubjectRepoImpl>(),
//       ),
//       child: Container(
//         padding: const EdgeInsets.all(16.0),
//         decoration: const BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.only(
//             topLeft: Radius.circular(16.0),
//             topRight: Radius.circular(16.0),
//           ),
//         ),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Container(
//               width: 40,
//               height: 4,
//               decoration: BoxDecoration(
//                 color: Colors.grey[300],
//                 borderRadius: BorderRadius.circular(2.0),
//               ),
//             ),
//             const SizedBox(height: 16.0),
//             // const Row(
//             //   children: [
//             //     CircleAvatar(
//             //       backgroundImage:
//             //           NetworkImage('https://example.com/user_image.jpg'),
//             //       radius: 20,
//             //     ),
//             //     SizedBox(width: 10),
//             //     Text(
//             //       'User Name',
//             //       style: TextStyle(
//             //         fontWeight: FontWeight.bold,
//             //         fontSize: 16,
//             //       ),
//             //     ),
//             //   ],
//             // ),
//             const SizedBox(height: 16.0),
//             const Divider(),
//             ListTile(
//               leading: const Icon(Icons.account_balance_wallet),
//               title: const Text('Add Bank Account'),
//               onTap: () {},
//             ),
//             ListTile(
//               leading: const Icon(Icons.credit_card),
//               title: const Text('Add Credit Card'),
//               onTap: () {},
//             ),
//             ListTile(
//               leading: const Icon(Icons.qr_code),
//               title: const Text('Scan QR Code'),
//               onTap: () {},
//             ),
//             ListTile(
//               leading: const Icon(Icons.history),
//               title: const Text('Transaction History'),
//               onTap: () {},
//             ),
//             const Divider(),
//             Row(mainAxisAlignment: MainAxisAlignment.center, children: [
//               BlocConsumer<BuySubjectCubit, BaseState>(
//                 listener: (context, state) {
//                   if (state is Success) {
//                     context.pop(true);
//                   } else if (state is Failure) {
//                     customToast(state.errorMessage);
//                   }
//                 },
//                 builder: (context, state) {
//                   return ElevatedButton(
//                     onPressed: state is Loading
//                         ? null
//                         : () {
//                             BlocProvider.of<BuySubjectCubit>(context)
//                                 .buySubject(subjectId: subjectId);
//                           },
//                     child: state is Loading
//                         ? const CustomLoading()
//                         : const Text('pay'),
//                   );
//                 },
//               ),
//             ]),
//           ],
//         ),
//       ),
//     );
//   }
// }

// =======
//                           const Spacer(),
//                           if (!state.data.isSubscription!)
//                             TextButton(
//                               onPressed: () async {
//                                 final buySuccess = await showModalBottomSheet(
//                                   context: context,
//                                   builder: (context) => GooglePayBottomSheet(
//                                     subjectId: widget.subject.id!.toString(),
//                                   ),
//                                 );
//                                 if (buySuccess) {
//                                   BlocProvider.of<UnitsCubit>(context)
//                                       .fetchUnits(
//                                           subjectId:
//                                               widget.subject.id.toString());
//                                 }
//                               },
//                               child: Text(
//                                 widget.subject.price.toString(),
//                               ),
//                             ),
//                           const Spacer(),
//                           IconButton(
//                             icon: Icon(
//                                 state.data.isSubscription!
//                                     ? Icons.lock_open
//                                     : Icons.lock,
//                                 color: state.data.isSubscription!
//                                     ? Colors.green
//                                     : Colors.red),
//                             onPressed: () {
//                               customToast(
//                                   'you have to buy this course to be able to access its data');
//                             },
//                           ),
//                         ],
//                       ),
//                     ),
//                     //  ShowTeacher(),
//                   ],
//                 ),
//               ),
//               SliverToBoxAdapter(
//                 child: TabBar(
//                   controller: tabController,
//                   labelColor: Colors.red, // Active label color
//                   unselectedLabelColor: Colors.grey, // Inactive label color
//                   indicatorColor: Colors.red, // Indicator color
//                   tabs: [
//                     Tab(
//                       text: 'الوحدات (${state.data.data!.length})',
//                     ),
//                     const Tab(text: 'المرفقات'),
//                     const Tab(text: 'الاختبارات'),
//                   ],
//                 ),
//               ),
//               SliverToBoxAdapter(
//                 child: Column(
//                   children: [
//                     if (tabController.index == 0)
//                       UnitsListView(
//                         subjectName: widget.subject.name!,
//                         units: state.data,
//                         subjectId: widget.subject.id.toString(),
//                       ),
//                     if (tabController.index == 1) const Text('files'),
//                     if (tabController.index == 2)  QuizzseListView(
//             parentId: widget.subject.id!.toString(),
//             subjectId: widget.subject.id!.toString(),
//             type: Types.subject.name,

//           )
//                   ],
// >>>>>>> 0c4b48a1923c1cf7ae2a260c60b47bac3c0a2a00

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:go_router/go_router.dart';
// import 'package:lms_student/core/cubits/base_cubit/base_cubit.dart';
// import 'package:lms_student/core/cubits/directory_cubit/directory_cubit.dart';
// import 'package:lms_student/core/cubits/shared_preferences_cubit/shared_preferences_cubit.dart';
// import 'package:lms_student/core/enums/types_enum.dart';
// import 'package:lms_student/core/utils/functions/custom_toast.dart';
// import 'package:lms_student/core/utils/service_locator.dart';
// import 'package:lms_student/core/widgets/custom_error.dart';
// import 'package:lms_student/core/widgets/custom_loading.dart';
// import 'package:lms_student/features/home/data/models/subjects_model/subject.dart';
// import 'package:lms_student/features/subject_data/data/models/units_model/unit.dart';
// import 'package:lms_student/features/subject_data/data/repo/subject_repo_impl.dart';
// import 'package:lms_student/features/subject_data/presentation/manager/buy_subject_cubit.dart';
// import 'package:lms_student/features/subject_data/presentation/manager/units_cubit.dart';
// import 'package:lms_student/features/subject_data/presentation/views/widgets/quizzes_list_view.dart';
// import 'package:lms_student/features/subject_data/presentation/views/widgets/units_list_view.dart';

// import 'header_image.dart';

// class SubjectDataViewBody extends StatefulWidget {
//   final Subject subject;

//   const SubjectDataViewBody({super.key, required this.subject});

//   @override
//   State<SubjectDataViewBody> createState() => _SubjectDataViewBodyState();
// }

// class _SubjectDataViewBodyState extends State<SubjectDataViewBody>
//     with SingleTickerProviderStateMixin {
//   late TabController tabController;
//   final SharedPreferencesCubit sharedPreferencesCubit =
//       getIt<SharedPreferencesCubit>();
//   @override
//   void initState() {
//     super.initState();
//     tabController = TabController(length: 3, vsync: this);
//     tabController.addListener(_handleTabSelection);
//     BlocProvider.of<UnitsCubit>(context)
//         .fetchUnits(subjectId: widget.subject.id.toString());
//   }

//   void _handleTabSelection() {
//     if (tabController.indexIsChanging) {
//       setState(() {});
//     }
//   }

//   @override
//   void dispose() {
//     super.dispose();
//     tabController.dispose();
//     tabController.removeListener(_handleTabSelection);
//   }

//   final dir = getIt<DirectoryCubit>();

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<UnitsCubit, BaseState>(
//       builder: (context, state) {
//         if (state is Loading) {
//           return const CustomLoading();
//         }
//         if (state is Failure) {
//           return CustomError(errMessage: state.errorMessage);
//         }
//         if (state is Success<Unitt>) {
//           return
//           CustomScrollView(
//             physics: const BouncingScrollPhysics(),
//             slivers: [
//               SliverToBoxAdapter(
//                 child: Column(
//                   children: [
//                     const Stack(
//                       alignment: AlignmentDirectional.center,
//                       children: [
//                         HeaderImage(
//                           imageUrl: '', //TODO add an actual image
//                         ),
//                         // ImageButton(
//                         //   courseIndex: widget.courseIndex,
//                         //   video: state.courseModel.data!.video!,
//                         //   subjectName: widget.datumSubjects.name!,
//                         // ),
//                       ],
//                     ),

//                     Padding(
//                       padding: const EdgeInsets.only(
//                           top: 16, left: 16, right: 16, bottom: 8),
//                       child: Row(
//                         children: [
//                           Text(
//                             widget.subject.name!,
//                             style: const TextStyle(
//                                 fontSize: 24, fontWeight: FontWeight.bold),
//                           ),
//                           const Spacer(),
//                           if (!state.data.isSubscription!)
//                             TextButton(
//                               onPressed: () async {
//                                 final buySuccess = await showModalBottomSheet(
//                                   context: context,
//                                   builder: (context) => GooglePayBottomSheet(
//                                     subjectId: widget.subject.id!.toString(),
//                                   ),
//                                 );
//                                 if (buySuccess) {
//                                   BlocProvider.of<UnitsCubit>(context)
//                                       .fetchUnits(
//                                           subjectId:
//                                               widget.subject.id.toString());
//                                 }
//                               },
//                               child: Text(
//                                 widget.subject.price.toString(),
//                               ),
//                             ),
//                           const Spacer(),
//                           IconButton(
//                             icon: Icon(
//                                 state.data.isSubscription!
//                                     ? Icons.lock_open
//                                     : Icons.lock,
//                                 color: state.data.isSubscription!
//                                     ? Colors.green
//                                     : Colors.red),
//                             onPressed: () {
//                               customToast(
//                                   'you have to buy this course to be able to access its data');
//                             },
//                           ),
//                         ],
//                       ),
//                     ),
//                     //  ShowTeacher(),
//                   ],
//                 ),
//               ),

//               SliverToBoxAdapter(
//                 child: TabBar(
//                   controller: tabController,
//                   labelColor: Colors.red, // Active label color
//                   unselectedLabelColor: Colors.grey, // Inactive label color
//                   indicatorColor: Colors.red, // Indicator color
//                   tabs: [
//                     Tab(
//                       text: 'الوحدات (${state.data.data!.length})',
//                     ),
//                     const Tab(text: 'المرفقات'),
//                     const Tab(text: 'الاختبارات'),
//                   ],
//                 ),
//               ),
//               SliverToBoxAdapter(
//                 child: Column(
//                   children: [
//                     if (tabController.index == 0)
//                       UnitsListView(
//                         subjectName: widget.subject.name!,
//                         units: state.data,
//                         subjectId: widget.subject.id.toString(),
//                       ),
//                     if (tabController.index == 1) const Text('files'),
//                     if (tabController.index == 2)
//                       QuizzseListView(
//                         parentId: widget.subject.id!.toString(),
//                         subjectId: widget.subject.id!.toString(),
//                         type: Types.subject.name,
//                       )
//                   ],
//                 ),
//               ),
//             ],
//           );
//         }
//         return Container();
//       },
//     );
//   }
// }

class GooglePayBottomSheet extends StatelessWidget {
  final String subjectId;
  const GooglePayBottomSheet({super.key, required this.subjectId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BuySubjectCubit(
        getIt<SubjectRepoImpl>(),
      ),
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16.0),
            topRight: Radius.circular(16.0),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2.0),
              ),
            ),
            const SizedBox(height: 16.0),
            // const Row(
            //   children: [
            //     CircleAvatar(
            //       backgroundImage:
            //           NetworkImage('https://example.com/user_image.jpg'),
            //       radius: 20,
            //     ),
            //     SizedBox(width: 10),
            //     Text(
            //       'User Name',
            //       style: TextStyle(
            //         fontWeight: FontWeight.bold,
            //         fontSize: 16,
            //       ),
            //     ),
            //   ],
            // ),
            const SizedBox(height: 16.0),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.account_balance_wallet),
              title: const Text('Add Bank Account'),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.credit_card),
              title: const Text('Add Credit Card'),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.qr_code),
              title: const Text('Scan QR Code'),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.history),
              title: const Text('Transaction History'),
              onTap: () {},
            ),
            const Divider(),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              BlocConsumer<BuySubjectCubit, BaseState>(
                listener: (context, state) {
                  if (state is Success) {
                    context.pop(true);
                  } else if (state is Failure) {
                    customToast(state.errorMessage);
                  }
                },
                builder: (context, state) {
                  return ElevatedButton(
                    onPressed: state is Loading
                        ? null
                        : () {
                            BlocProvider.of<BuySubjectCubit>(context)
                                .buySubject(subjectId: subjectId);
                          },
                    child: state is Loading
                        ? const CustomLoading()
                        : const Text('pay'),
                  );
                },
              ),
            ]),
          ],
        ),
      ),
    );
  }
}
