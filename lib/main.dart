import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:lms_student/constants.dart';
import 'package:lms_student/core/cubits/device_token_cubit.dart/device_token_cubit.dart';
import 'package:lms_student/core/cubits/directory_cubit/directory_cubit.dart';
import 'package:lms_student/core/cubits/hydrated_cubit_instance.dart';
import 'package:lms_student/core/cubits/shared_preferences_cubit/shared_preferences_cubit.dart';
import 'package:lms_student/core/cubits/token_cubit/token_cubit.dart';
import 'package:lms_student/core/utils/app_bloc_observer.dart';
import 'package:lms_student/core/utils/app_router.dart';
import 'package:lms_student/core/utils/service_locator.dart';
import 'package:lms_student/core/utils/size_config.dart';
import 'package:lms_student/features/auth/data/models/user_model/user.dart';
import 'package:lms_student/features/downloads/data/models/file_state/file_state.dart';
import 'package:lms_student/features/downloads/presentataion/manager/download_cubit/downloads_cubit.dart';
import 'package:lms_student/features/home/data/repos/home_repo_impl.dart';
import 'package:lms_student/features/home/presentation/manager/bookmark_cubit/fetch_mark_cubit.dart';
import 'package:lms_student/features/home/presentation/manager/bookmark_cubit/post_mark_cubit.dart';
import 'package:lms_student/features/home/presentation/manager/favorite_cubit.dart';
import 'package:lms_student/features/home/presentation/manager/get_fav_cubit.dart';
import 'package:lms_student/features/home/presentation/manager/search_cubits/subjects_seach_cubit.dart';
import 'package:lms_student/features/subject_data/data/models/units_model/video.dart';
import 'package:lms_student/features/subject_data/data/repo/subject_repo_impl.dart';
import 'package:lms_student/features/subject_data/presentation/manager/fetch_teacher_profile_cubit.dart';

import 'core/cubits/theme_cubit/theme_cubit.dart';
import 'theme/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupServiceLocator();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: kAppColor, // Status bar color
    statusBarIconBrightness: Brightness.light, // Status bar icons' color
  ));

  final tokenCubit = getIt<TokenCubit>();
  // final gradeCubit = getIt<GradeCubit>();
  final sharedPreferencesCubit = getIt<SharedPreferencesCubit>();
  final deviceTokenCubit = getIt<DeviceTokenCubit>();
  final directoryCubit = getIt<DirectoryCubit>();
  final hydratedCubit = getIt<HydratedCubitInstance>();
  await Hive.initFlutter();
  Hive.registerAdapter(UserAdapter());
  Hive.registerAdapter(VideoAdapter());
  Hive.registerAdapter(FileStateAdapter());

  await Future.wait([
    Hive.openBox<User>(kUser),
    Hive.openBox<Video>(kVideo),
    Hive.openBox<FileState>(kFileState),

    sharedPreferencesCubit.setup(),
     //sharedPreferencesCubit.deleteAll(),
     //tokenCubit.deleteSavedToken(),
    tokenCubit.fetchSavedToken(),
    directoryCubit.fetchDocsDir(),
    deviceTokenCubit.fetchDeviceToken(),
    EasyLocalization.ensureInitialized(),
  ]);
  await hydratedCubit.setup();
  final router = AppRouter.setupRouter(tokenCubit.state, deviceTokenCubit.state,
      sharedPreferencesCubit.getGrade());
  Bloc.observer = AppBlocObserver();
  runApp(
    EasyLocalization(
        supportedLocales: const [Locale('ar', 'AE'), Locale('en', 'US')],
        path: 'assets/translations',
        fallbackLocale: const Locale('ar', 'AE'),
        startLocale: const Locale('en', 'US'),
        child: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => getIt<SharedPreferencesCubit>(),
            ),

            //   BlocProvider(create: (context) => getIt<DirectoryCubit>(),),
            BlocProvider(
              create: (context) => getIt<DownloadsCubit>(),
            ),
            BlocProvider(
                create: (context) => SearchSubjectsCubit(
                      getIt<HomeRepoImpl>(),
                    )),
            BlocProvider(
                create: (context) => FavoriteCubit(
                      getIt<HomeRepoImpl>(),
                    )),
            BlocProvider(
                create: (context) => FetchFavoriteCubit(
                      getIt<HomeRepoImpl>(),
                    )),
            BlocProvider(
                create: (context) => FetchBookMarkCubit(
                      getIt<HomeRepoImpl>(),
                    )),
            BlocProvider(
                create: (context) => PostBookMarkcubit(
                      getIt<HomeRepoImpl>(),
                    )),

            BlocProvider(
                create: (context) => FetchTeacherProfileCubit(
                      getIt<SubjectRepoImpl>(),
                    )),
            BlocProvider(
              create: (context) => ThemeCubit(), //هنا اضافة ال theme cubit
            ),
          ],
          child: LMSApp(
            router: router,
          ),
        )),
  );
}

class LMSApp extends StatelessWidget {
  final GoRouter router;
  const LMSApp({super.key, required this.router});

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return BlocBuilder<ThemeCubit, ThemeMode>(
      builder: (context, themeMode) {
        return MaterialApp.router(
          // theme: ThemeData(
          //   useMaterial3: false,
          //   fontFamily: 'inter',
          // ).copyWith(
          //     appBarTheme: const AppBarTheme(
          //       color: kAppColor,
          //     ),
          //     // inputDecorationTheme: InputDecorationTheme(
          //     //   focusedBorder: OutlineInputBorder(
          //     //     borderSide: const BorderSide(color: Color.fromARGB(255, 0, 0, 0)),
          //     //     borderRadius: BorderRadius.circular(20),
          //     //   ),
          //     //   enabledBorder: OutlineInputBorder(
          //     //     borderSide: const BorderSide(color: Color.fromARGB(255, 0, 0, 0)),
          //     //     borderRadius: BorderRadius.circular(100),
          //     //   ),
          //     //   disabledBorder: OutlineInputBorder(
          //     //     borderRadius: BorderRadius.circular(100),
          //     //     borderSide: const BorderSide(color: Color.fromARGB(255, 0, 0, 0)),
          //     //   ),
          //     //   errorBorder: OutlineInputBorder(
          //     //     borderSide:
          //     //         const BorderSide(color: Color.fromARGB(255, 239, 14, 2)),
          //     //     borderRadius: BorderRadius.circular(100),
          //     //   ),
          //     //   focusedErrorBorder: OutlineInputBorder(
          //     //     borderSide:
          //     //         const BorderSide(color: Color.fromARGB(255, 239, 14, 2)),
          //     //     borderRadius: BorderRadius.circular(20),
          //     //   ),
          //     //   hintStyle: const TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
          //     //   suffixIconColor: const Color.fromARGB(255, 0, 0, 0),
          //     //   prefixIconColor: const Color.fromARGB(255, 0, 0, 0),
          //     // ),

          //     /////////////////////////////////////////////////////////////////

          //     // textTheme: const TextTheme(
          //     //   bodyLarge: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
          //     //   bodyMedium: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
          //     //   headlineSmall: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
          //     //   titleLarge: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
          //     //   titleMedium: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
          //     //   titleSmall: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
          //     //   bodySmall: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
          //     //   displayMedium: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
          //     //   displayLarge: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),

          //     // ),
          //     // iconTheme: const IconThemeData(
          //     //   color: kAppColor,
          //     // ),
          //     // iconButtonTheme: const IconButtonThemeData(
          //     //     style:
          //     //         ButtonStyle(iconColor: MaterialStatePropertyAll(kAppColor))),
          //     // elevatedButtonTheme: ElevatedButtonThemeData(
          //     //   style: ButtonStyle(
          //     //       backgroundColor: MaterialStateProperty.all(kAppColor)),
          //     // ),
          //     // progressIndicatorTheme: const ProgressIndicatorThemeData(
          //     //   color: Color(0xff0F0961),
          //     // ),
          //     // scaffoldBackgroundColor: const Color(0xfff4f6fa),
          //     // colorScheme: ColorScheme.fromSeed(seedColor: kAppColor)
          //     ),
          // theme: ThemeData().copyWith),
          theme: lightTheme.copyWith(), // الثيم النهاري
          darkTheme: darkTheme, // الثيم الليلي
          themeMode: themeMode, // تحديد الثيم بناءً على الحالة الحالية
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          routerConfig: router,
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}
