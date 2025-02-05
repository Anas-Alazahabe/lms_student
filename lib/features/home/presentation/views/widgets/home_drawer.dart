// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
// import 'package:hive/hive.dart';
// import 'package:lms_student/core/utils/app_router.dart';
// import 'package:lms_student/features/auth/data/models/user_model/user.dart';

// class HomeDrawer extends StatelessWidget {
//   const HomeDrawer({
//     super.key, required this.user,
//   });

//   final Box<User> user;

//   @override
//   Widget build(BuildContext context) {
//     return Drawer(
//       child: ListView(
//         children: <Widget>[
//           UserAccountsDrawerHeader(
//             accountName: Text(user.values.first.name??
//                 'زائر'), // Replace 'Username' with the actual username
//             accountEmail: null, // Replace with the actual user email
//             currentAccountPicture: CircleAvatar(
//               backgroundColor: Colors.white,
//               child: Text(
//                 user.values.first.name != null
//                     ? user.values.first.name![0]
//                     : 'ز',
//                 style: const TextStyle(fontSize: 40.0),
//               ),
//             ),
//           ),
//           if (user.values.first.name != null)
//             Builder(builder: (context) {
//               return ListTile(
//                 leading: const Icon(Icons.account_circle),
//                 title: const Text('الملف الشخصي'),
//                 onTap: () {
//                   Scaffold.of(context).closeDrawer();
//                   context.push(AppRouter.kProfileView,
//                       extra: user
//                       );
//                 },
//               );
//             }),
//           ListTile(
//             leading: const Icon(Icons.download),
//             title: const Text('الملفات المحملة'),
//             onTap: () {
//               Scaffold.of(context).closeDrawer();
//               context.push(
//                 AppRouter.kDownloadVeiw,
//               );
//             },
//           ),
//           // if (user.values.first.name != null)
//           //   Builder(builder: (context) {
//           //     return ListTile(
//           //       leading: const Icon(Icons.swap_horiz_rounded),
//           //       title: const Text('تبديل الفرع'),
//           //       onTap: () {
//           //         Scaffold.of(context).closeDrawer();
//           //         context.push(
//           //           AppRouter.kSpecificationView,
//           //         );
//           //       },
//           //     );
//           //   }),
//           if (user.values.first.name == null)
//             Builder(builder: (context) {
//               return ListTile(
//                 leading: const Icon(Icons.login),
//                 title: const Text('تسجيل الدخول'),
//                 onTap: () {
//                   Scaffold.of(context).closeDrawer();
//                   context.pop();
//                 },
//               );
//             }),
//         ],
//       ),
//     );
//   }
// }

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hive/hive.dart';
import 'package:lms_student/core/cubits/theme_cubit/theme_cubit.dart';
import 'package:lms_student/core/utils/app_router.dart';
import 'package:lms_student/features/auth/data/models/user_model/user.dart';

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({
    super.key,
    required this.user,
  });

  final Box<User> user;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text(
              user.values.first.name ?? 'زائر',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontSize: 20, // يمكنك تخصيص الحجم هنا إذا كنت تريد تخصيصه
                    fontWeight: FontWeight.w600, // يمكنك تخصيص الوزن هنا أيضًا
                  ),
            ),
            accountEmail: null,
            currentAccountPicture: CircleAvatar(
              backgroundColor: Theme.of(context)
                  .colorScheme
                  .secondary, // استخدام لون من الثيم
              child: Text(
                user.values.first.name != null
                    ? user.values.first.name![0]
                    : 'ز',
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge, // استخدام نمط النص من الثيم
              ),
            ),
            decoration: BoxDecoration(
              color: Theme.of(context)
                  .colorScheme
                  .primary, // استخدام لون الخلفية من الثيم
            ),
          ),
          if (user.values.first.name != null)
            Builder(builder: (context) {
              return ListTile(
                leading: Icon(
                  Icons.account_circle,
                  color: Theme.of(context)
                      .iconTheme
                      .color, // استخدام لون الأيقونة من الثيم
                ),
                title: Text(
                  'personal profile'.tr(),
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge, // استخدام نمط النص من الثيم
                ),
                onTap: () {
                  Scaffold.of(context).closeDrawer();
                  context.push(AppRouter.kProfileView, extra: user);
                },
              );
            }),
          ListTile(
            leading: Icon(
              Icons.download,
              color: Theme.of(context).iconTheme.color,
            ),
            title: Text(
              'uploaded files'.tr(),
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            onTap: () {
              Scaffold.of(context).closeDrawer();
              context.push(AppRouter.kDownloadVeiw);
            },
          ),

          ListTile(
            leading: Icon(
              Icons.language,
              color: Theme.of(context).iconTheme.color,
            ),
            title: Text(
              'Change language'.tr(),
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            onTap: () {
              Locale currentLocale = context.locale;

              if (currentLocale.languageCode == 'en') {
                context.setLocale(const Locale('ar', 'AE'));
              } else {
                context.setLocale(const Locale('en', 'US'));
              }
            },
          ),

          SwitchListTile(
            title: Text(
              'Change Theme'.tr(),
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            value: Theme.of(context).brightness == Brightness.dark,
            onChanged: (bool value) {
              context.read<ThemeCubit>().toggleTheme();
            },
            secondary: Icon(
              Theme.of(context).brightness == Brightness.dark
                  ? Icons.dark_mode_outlined
                  : Icons.light_mode,
              color: Theme.of(context).iconTheme.color,
            ),
          ),

          //
          // ListTile(
          //   leading: Icon(
          //     Icons.dark_mode_outlined,
          //     color: Theme.of(context)
          //         .iconTheme
          //         .color,
          //   ),
          //   title: Text(
          //     'Change Theme',
          //     style: Theme.of(context)
          //         .textTheme
          //         .bodyLarge,
          //   ),
          //   onTap: () {
          //     context
          //         .read<ThemeCubit>()
          //         .toggleTheme();
          //     // Scaffold.of(context).closeDrawer();
          //   },
          // ),

          if (user.values.first.name == null)
            Builder(builder: (context) {
              return ListTile(
                leading: Icon(
                  Icons.login,
                  color: Theme.of(context).iconTheme.color,
                ),
                title: Text(
                  'تسجيل الدخول',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                onTap: () {
                  Scaffold.of(context).closeDrawer();
                  context.pop();
                },
              );
            }),
        ],
      ),
    );
  }
}
