import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:lms_student/constants.dart';
import 'package:lms_student/core/cubits/shared_preferences_cubit/shared_preferences_cubit.dart';
import 'package:lms_student/core/cubits/token_cubit/token_cubit.dart';
import 'package:lms_student/core/errors/failures.dart';
import 'package:lms_student/core/utils/api_service.dart';
import 'package:lms_student/core/utils/service_locator.dart';
import 'package:lms_student/features/home/data/models/ad_model/ad_model.dart';
import 'package:lms_student/features/home/data/models/bookmark_model/bookmark.dart';
import 'package:lms_student/features/home/data/models/bookmark_model/bookmark_model.dart';
import 'package:lms_student/features/home/data/models/favorite_model/favorite.dart';
import 'package:lms_student/features/home/data/models/favorite_model/favorite_model.dart';
import 'package:lms_student/features/home/data/models/search_result_model/search_result_model.dart';
import 'package:lms_student/features/home/data/models/subjects_model/subjects_model.dart';
import 'package:lms_student/features/home/data/repos/home_repo.dart';
import 'package:lms_student/features/home/presentation/views/widgets/book_mark.dart';

class HomeRepoImpl implements HomeRepo {
  final ApiService _apiService;
  final TokenCubit tokenCubit = getIt<TokenCubit>();
  final SharedPreferencesCubit sharedPreferencesCubit =
      getIt<SharedPreferencesCubit>();
  HomeRepoImpl(this._apiService);
  //:// tokenCubit = GetIt.instance<TokenCubit>(),
  // sharedPreferencesCubit = GetIt.instance<SharedPreferencesCubit>();

  @override
  Future<Either<Failure, AdModel>> fetchAds({required bool all}) async {
    try {
      final response = await _apiService.get(
        url: '$kBaseUrl/ad/showNewest',
        token: tokenCubit.state,
        body: null,
        queryParameters: null,
      );

      AdModel adModel = AdModel.fromJson(response);

      return right(adModel);
    } on Exception catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioException(e));
      }
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, SubjectsModel>> fetchSubjects(
      {required String? yearId}) async {
    try {
      final response = await _apiService.get(
          url: '$kBaseUrl/subject/index',
          token: tokenCubit.state,
          body: null,
          queryParameters: {
            'year_id': yearId,
          });

      SubjectsModel subjectsModel = SubjectsModel.fromJson(response);

      return right(subjectsModel);
    } on Exception catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioException(e));
      }
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, SearchResultModel>> searchSubject(
      {required String? name, required String? yearId}) async {
    try {
      final response = await _apiService.get(
          url: '$kBaseUrl/subject/search',
          token: tokenCubit.state,
          body: null,
          queryParameters: {
            'year_id': yearId,
            'name': name,
          });

      SearchResultModel resultModel = SearchResultModel.fromJson(response);

      return right(resultModel);
    } on Exception catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioException(e));
      }
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, FavoriteModel>> postFav(
      {String? categoryName, String? subjectName, String? teacherName}) async {
    try {
      final response = await _apiService.post(
        url: '$kBaseUrl/fav/toggle',
        token: tokenCubit.state,
        body: Favorite(
          category: categoryName,
          subject: subjectName,
          teacher: teacherName,
        ).toJson(),
      );

      // if (isfavorited == false)
      FavoriteModel favoriteModel = FavoriteModel.fromJson(response);
      // else
      // FavoriteModel favoriteModel = FavoriteModel.fromJsontrue(response);

      return right(favoriteModel);
    } on Exception catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioException(e));
      }
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Favorite>>> getFav() async {
    try {
      final response = await _apiService.get(
          url: '$kBaseUrl/fav/index',
          token: tokenCubit.state,
          body: null,
          queryParameters: null);

      if (response['message'] == "You do not have favorites") {
        return right([]);
      }
      // if (isfavorited == false)
      List<Favorite> favoriteModel = ((response['message']) as List<dynamic>?)!
          .map((e) => Favorite.fromJson(e as Map<String, dynamic>))
          .toList();
      // else
      // FavoriteModel favoriteModel = FavoriteModel.fromJsontrue(response);

      return right(favoriteModel);
    } on Exception catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioException(e));
      }
      return Left(ServerFailure(e.toString()));
    }
  }

  // @override
  // Future<Either<Failure, FavoriteModel>> postBook(
  //     {String? unitNameString? subjectName, String? teacherName}) async {
  //   try {
  //     final response = await _apiService.post(
  //       url: '$kBaseUrl/fav/toggle',
  //       token: tokenCubit.state,
  //       body: Favorite(
  //         category: categoryName,
  //         subject: subjectName,
  //         teacher: teacherName,
  //       ).toJson(),
  //     );

  //     // if (isfavorited == false)
  //     FavoriteModel favoriteModel = FavoriteModel.fromJson(response);
  //     // else
  //     // FavoriteModel favoriteModel = FavoriteModel.fromJsontrue(response);

  //     return right(favoriteModel);
  //   } on Exception catch (e) {
  //     if (e is DioException) {
  //       return Left(ServerFailure.fromDioException(e));
  //     }
  //     return Left(ServerFailure(e.toString()));
  //   }
  // }

  @override
  Future<Either<Failure, BookmarkModel>> postBook({
    String? unitName,
    String? lessonName,
    String? videoName,
    String? fileName,
  }) async {
    try {
      final response = await _apiService.post(
        url: '$kBaseUrl/bookmark/toggle',
        token: tokenCubit.state,
        body: Bookmark(
          unit: unitName,
          lesson: lessonName,
          video: videoName,
          file: fileName,
        ).toJson(),
      );
      BookmarkModel bookmarkModel = BookmarkModel.fromJson(response);
      return right(bookmarkModel);
    } on Exception catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioException(e));
      }
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Bookmark>>> fetchBook() async {
    try {
      final response = await _apiService.get(
          url: '$kBaseUrl/bookmark/index',
          token: tokenCubit.state,
          body: null,
          queryParameters: null);

      if (response['message'] == "You do not have any bookmarks") {
        return right([]);
      }

      final message = response['message'];
      if (message == null || message is! List) {
        return right([]);
      }

      List<Bookmark> bookmarkModel = message
          .map((e) => Bookmark.fromJson(e as Map<String, dynamic>))
          .toList();

      return right(bookmarkModel);
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioException(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  // @override
  // Future<Either<Failure, List<Bookmark>>> fetchBook() async {
  //   try {
  //     final response = await _apiService.get(
  //         url: '$kBaseUrl/bookmark/index',
  //         token: tokenCubit.state,
  //         body: null,
  //         queryParameters: null);

  //     if (response['message'] == "You do not have any bookmarks") {
  //       return right([]);
  //     }

  //     // if(response['message']==null) print('hh');
  //     // else
  //     // if (isfavorited == false)
  //     List<Bookmark> bookmarkModel = ((response['message']) as List<dynamic>?)!
  //         .map((e) => Bookmark.fromJson(e as Map<String, dynamic>))
  //         .toList();
  //     // else
  //     // FavoriteModel favoriteModel = FavoriteModel.fromJsontrue(response);

  //     return right(bookmarkModel);
  //   } on Exception catch (e) {
  //     if (e is DioException) {
  //       return Left(ServerFailure.fromDioException(e));
  //     }
  //     return Left(ServerFailure(e.toString()));
  //   }
  // }
}
