import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:lms_student/core/cubits/device_token_cubit.dart/device_token_cubit.dart';
import 'package:lms_student/core/cubits/directory_cubit/directory_cubit.dart';
import 'package:lms_student/core/cubits/hydrated_cubit_instance.dart';
import 'package:lms_student/core/cubits/shared_preferences_cubit/shared_preferences_cubit.dart';
import 'package:lms_student/core/cubits/token_cubit/token_cubit.dart';
import 'package:lms_student/core/utils/api_service.dart';
import 'package:lms_student/features/auth/data/repos/auth_repo_impl.dart';
import 'package:lms_student/features/downloads/data/repos/downloads_repo_impl.dart';
import 'package:lms_student/features/downloads/presentataion/manager/download_cubit/downloads_cubit.dart';
import 'package:lms_student/features/home/data/repos/home_repo_impl.dart';
import 'package:lms_student/features/subject_data/data/repo/subject_repo_impl.dart';

GetIt getIt = GetIt.instance;

void setupServiceLocator() {
  getIt.registerLazySingleton<Dio>(() => Dio());
  getIt.registerLazySingleton<ApiService>(() => ApiService(getIt<Dio>()));
  getIt.registerLazySingleton<AuthRepoImpl>(
      () => AuthRepoImpl(getIt<ApiService>()));
  getIt.registerLazySingleton<HomeRepoImpl>(
      () => HomeRepoImpl(getIt<ApiService>()));
  getIt.registerLazySingleton<SubjectRepoImpl>(
      () => SubjectRepoImpl(getIt<ApiService>()));
  getIt.registerLazySingleton<DownloadsRepoImpl>(
      () => DownloadsRepoImpl(getIt<ApiService>()));

  getIt.registerLazySingleton<TokenCubit>(() => TokenCubit());
  getIt.registerLazySingleton<DeviceTokenCubit>(() => DeviceTokenCubit());
  getIt.registerLazySingleton<SharedPreferencesCubit>(
      () => SharedPreferencesCubit());
  getIt.registerLazySingleton<DirectoryCubit>(() => DirectoryCubit());
  getIt.registerLazySingleton<HydratedCubitInstance>(
      () => HydratedCubitInstance());
  getIt.registerLazySingleton<DownloadsCubit>(
      () => DownloadsCubit(getIt<DownloadsRepoImpl>()));
  // getIt.registerLazySingleton<TempDirectoryCubit>(() => TempDirectoryCubit());
  // getIt.registerLazySingleton<AuthorizeCubit>(() => AuthorizeCubit());
}
