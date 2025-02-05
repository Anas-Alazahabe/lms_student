// import 'package:flutter/material.dart';
// import 'package:lms_student/constants.dart';

// class HomeViewBodyHeader extends StatelessWidget {
//   final VoidCallback action;
//   const HomeViewBodyHeader({
//     super.key,
//     required this.rand,
//     required this.action,
//   });

//   final int rand;

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         SizedBox(
//           width: double.infinity,
//           child: Padding(
//             padding: const EdgeInsets.only(top: 30, left: 5, right: 10),
//             child: Row(
//               children: [
//         //         const Text(
//         //           'مرحبا مجدداً',
//         //           style: TextStyle(fontSize: 30),
//         //         ),
//         //         const Spacer(),
//         //         CircleAvatar(
//         //           backgroundColor: Colors.black,
//         //           child: IconButton(
//         //               color: Colors.white,
//         //               onPressed: action,
//         //               icon: const Icon(Icons.density_medium_rounded)),
//         //         )
//         //       ],
//         //     ),
//         //   ),
//         // ),
//         // SizedBox(
//         //   width: double.infinity,
//         //   child: Padding(
//         //     padding:
//         //         const EdgeInsets.only(top: 0, left: 10, right: 10, bottom: 20),
//         //     child: Text(
//         //       says[rand],
//         //       style: const TextStyle(fontSize: 16),
//         //     ),
//         //   ),
//         // ),
//       ],
//     );
//   }
// }

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:lms_student/constants.dart';

import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:lms_student/constants.dart';
import 'package:lms_student/core/cubits/base_cubit/base_cubit.dart';
import 'package:lms_student/core/utils/service_locator.dart';
import 'package:lms_student/core/widgets/custom_error.dart';
import 'package:lms_student/features/auth/data/models/user_model/user.dart';
import 'package:lms_student/features/home/data/models/search_result_model/search_result_model.dart';
import 'package:lms_student/features/home/data/models/subjects_model/search_subjects_model.dart';
import 'package:lms_student/features/home/data/models/subjects_model/subjects_model.dart';
import 'package:lms_student/features/home/data/repos/home_repo_impl.dart';
import 'package:lms_student/features/home/presentation/manager/ad_cubit.dart';
import 'package:lms_student/features/home/presentation/manager/search_cubits/subjects_seach_cubit.dart';
import 'package:lms_student/features/home/presentation/manager/subjects_cubit.dart';
import 'package:lms_student/features/home/presentation/views/widgets/my_search.dart';
import 'package:lms_student/features/home/presentation/views/widgets/shimmer_subjects_list_view.dart';

import 'home_ads.dart';
import 'home_view_body_header.dart';

class HomeViewBodyHeader extends StatefulWidget {
  final VoidCallback action;
  const HomeViewBodyHeader({
    super.key,
    required this.rand,
    required this.action,
  });

  final int rand;

  @override
  State<HomeViewBodyHeader> createState() => _HomeViewBodyHeaderState();
}

class _HomeViewBodyHeaderState extends State<HomeViewBodyHeader> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      decoration: BoxDecoration(
          color: kAppColor,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(0), topRight: Radius.circular(0))),
      child: Column(
        children: [
          SizedBox(
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.only(top: 30, left: 5, right: 10),
              child: Row(
                children: [
                  Container(
                    width: 45,
                    decoration: BoxDecoration(
                      //color: kStrokeColor,
                      color: Theme.of(context).colorScheme.background,
                      border: Border.all(
                        color: Theme.of(context).colorScheme.background,
                        // color: Color(0XFFE0E0E0), // Grey color for the border
                        width: 1, // You can adjust the border width as needed
                      ),
                      borderRadius: BorderRadius.circular(
                          10), // Optional: If you want rounded corners
                    ),
                    child: IconButton(
                        color: Theme.of(context).iconTheme.color,
                        // color: Colors.white,
                        onPressed: widget.action,
                        icon: const Icon(Icons.density_medium_rounded)),
                  ),
                  const SizedBox(
                    width: 7,
                  ),

                  //Search
                  GestureDetector(
                    child: Container(
                      width: MediaQuery.of(context).size.width - 67,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.background,
                        // color: Colors.white,
                        border: Border.all(
                          color: Theme.of(context).colorScheme.background,
                          // color: Colors.grey,
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 15,
                          ),
                          Icon(Icons.search),
                          Text(
                            'Search'.tr(),
                            textAlign: TextAlign.start,
                          ),
                        ],
                      ),
                    ),
                    onTap: () {
                      showSearch(context: context, delegate: MySearch());
                    },
                  ),

                  // const Text(
                  //   'مرحبا مجدداً',
                  //   style: TextStyle(fontSize: 30),
                  // ),

                  // CircleAvatar(
                  //   backgroundColor: Colors.black,
                  //   child: IconButton(
                  //       color: Colors.white,
                  //       onPressed: action,
                  //       icon: const Icon(Icons.density_medium_rounded)),
                  // )
                ],
              ),
            ),
          ),
          // SizedBox(
          //   width: double.infinity,
          //   child: Padding(
          //     padding:
          //         const EdgeInsets.only(top: 0, left: 10, right: 10, bottom: 20),
          //     child: Text(
          //       says[widget.rand],
          //       style: const TextStyle(fontSize: 16),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}

// //MySearch
// class MySearch extends SearchDelegate<String> {
//   var box = Hive.box<User>(kUser);
//   int index = 0;

//   MySearch();

//   @override
//   List<Widget> buildActions(BuildContext context) {
//     return [
//       IconButton(
//         icon: const Icon(Icons.clear),
//         onPressed: () {
//           query = '';
//         },
//       ),
//     ];
//   }

//   @override
//   Widget buildLeading(BuildContext context) {
//     return IconButton(
//       icon: AnimatedIcon(
//         icon: AnimatedIcons.menu_arrow,
//         progress: transitionAnimation,
//       ),
//       onPressed: () {
//         close(context, '');
//       },
//     );
//   }

//   @override
//   Widget buildResults(BuildContext context) {
//     context
//         .read<SearchSubjectsCubit>()
//         .search(yearId: box.values.first.yearId, name: query);
//     return BlocBuilder<SearchSubjectsCubit, BaseState>(
//       builder: (context, state) {
//         if (state is Loading) {
//           return const Center(child: CircularProgressIndicator());
//         } else if (state is Failure) {
//           return Text('Error: ${state.errorMessage}');
//         } else if (state is Success<SearchResultModel>) {
//           return buildSearchResults(state, index);
//         } else {
//           return Container();
//         }
//       },
//     );
//   }

//   @override
//   Widget buildSuggestions(BuildContext context) {
// // Use BlocBuilder to rebuild the UI based on cubit state
//     context
//         .read<SearchSubjectsCubit>()
//         .search(yearId: box.values.first.yearId, name: query);

//     return StatefulBuilder(
//       builder: (context, setState) {
//         return Column(
//           children: [
//             Wrap(
//               spacing: 8.0, // gap between adjacent chips
//               runSpacing: 4.0, // gap between lines
//               children: [
//                 ChoiceChip(
//                   label: const Text('تصنيفات'),
//                   selected: index == 0,
//                   onSelected: (selected) {
//                     setState(() {
//                       index = 0;
//                     });
//                   },
//                 ),
//                 ChoiceChip(
//                   label: const Text('مدرسين'),
//                   selected: index == 1,
//                   onSelected: (selected) {
//                     setState(() {
//                       index = 1;
//                     });
//                   },
//                 ),
//                 ChoiceChip(
//                   label: const Text('وحدات'),
//                   selected: index == 2,
//                   onSelected: (selected) {
//                     setState(() {
//                       index = 2;
//                     });
//                   },
//                 ),
//                 ChoiceChip(
//                   label: const Text('دروس'),
//                   selected: index == 3,
//                   onSelected: (selected) {
//                     setState(() {
//                       index = 3;
//                     });
//                   },
//                 ),
//                 ChoiceChip(
//                   label: const Text('مواد'),
//                   selected: index == 4,
//                   onSelected: (selected) {
//                     setState(() {
//                       index = 4;
//                     });
//                   },
//                 ),
//               ],
//             ),
//             BlocBuilder<SearchSubjectsCubit, BaseState>(
//               builder: (context, state) {
//                 if (state is Loading) {
//                   return const Center(child: CircularProgressIndicator());
//                 } else if (state is Failure) {
//                   return Text('Error: ${state.errorMessage}');
//                 } else if (state is Success<SearchResultModel>) {
//                   return buildSearchResults(state, index);
//                 } else {
//                   return Container();
//                 }
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }

//   Widget buildSearchResults(Success<SearchResultModel> state, int index) {
//     final subjetcsResults = state.data.subjects;
//     final lessonsResults = state.data.lessons;
//     final teachersResults = state.data.teachers;
//     final unitsResults = state.data.units;
//     final categoriesResults = state.data.categories;

//     final List<Widget> widgets = [
//       ListView.builder(
//         shrinkWrap: true,
//         itemBuilder: (context, index) => ListTile(
//           title: Text(subjetcsResults[index].name!),
//         ),
//         itemCount: subjetcsResults!.length,
//       ),
//       ListView.builder(
//         shrinkWrap: true,
//         itemBuilder: (context, index) => ListTile(
//           title: Text(lessonsResults[index].name!),
//         ),
//         itemCount: lessonsResults!.length,
//       ),
//       ListView.builder(
//         shrinkWrap: true,
//         itemBuilder: (context, index) => ListTile(
//           title: Text(teachersResults[index].name!),
//         ),
//         itemCount: teachersResults!.length,
//       ),
//       ListView.builder(
//         shrinkWrap: true,
//         itemBuilder: (context, index) => ListTile(
//           title: Text(unitsResults[index].name!),
//         ),
//         itemCount: unitsResults!.length,
//       ),
//       ListView.builder(
//         shrinkWrap: true,
//         itemBuilder: (context, index) => ListTile(
//           title: Text(categoriesResults[index].category!),
//         ),
//         itemCount: categoriesResults!.length,
//       ),
//     ];

//     return widgets[index];
//   }
// }
