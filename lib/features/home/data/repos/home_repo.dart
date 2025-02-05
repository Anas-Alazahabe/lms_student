import 'dart:ffi';

import 'package:dartz/dartz.dart';
import 'package:lms_student/core/errors/failures.dart';
import 'package:lms_student/features/home/data/models/ad_model/ad_model.dart';
import 'package:lms_student/features/home/data/models/bookmark_model/bookmark.dart';
import 'package:lms_student/features/home/data/models/bookmark_model/bookmark_model.dart';
import 'package:lms_student/features/home/data/models/favorite_model/favorite.dart';
import 'package:lms_student/features/home/data/models/favorite_model/favorite_model.dart';
import 'package:lms_student/features/home/data/models/search_result_model/search_result_model.dart';
import 'package:lms_student/features/home/data/models/subjects_model/subjects_model.dart';

abstract class HomeRepo {
  Future<Either<Failure, SubjectsModel>> fetchSubjects(
      {required String? yearId});
  Future<Either<Failure, AdModel>> fetchAds({required bool all});

  Future<Either<Failure, SearchResultModel>> searchSubject(
      {required String? name, required String? yearId});

  Future<Either<Failure, FavoriteModel>> postFav({
    String? categoryName,
    String? subjectName,
    String? teacherName,
  });
  Future<Either<Failure, List<Favorite>>> getFav();

  Future<Either<Failure,BookmarkModel>> postBook({
    String? unitName,
    String? lessonName,
    String? videoName,
    String? fileName,

  });
  Future<Either<Failure, List<Bookmark>>> fetchBook();
}
