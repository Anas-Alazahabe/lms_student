// import 'package:lms_student/core/cubits/base_cubit/base_cubit.dart';
// import 'package:lms_student/features/home/data/models/ad_model/ad_model.dart';
// import 'package:lms_student/features/home/data/repos/home_repo.dart';

// class FavoriteCubit extends BaseCubit<AdModel> {
//   final HomeRepo homeRepo;

//   FavoriteCubit(this.homeRepo) : super();

//   Future<void> fetchAds({required bool all}) async {
//     emitLoading();
//     final result = await homeRepo.fetchAds(all: all);
//     result.fold(
//       (failure) => emitFailure(failure.errMessage),
//       (ad) => emitSuccess(ad),
//     );
//   }
// }

import 'package:lms_student/core/cubits/base_cubit/base_cubit.dart';
import 'package:lms_student/features/home/data/models/favorite_model/favorite.dart';
import 'package:lms_student/features/home/data/models/favorite_model/favorite_model.dart';
import 'package:lms_student/features/home/data/repos/home_repo.dart';

class FavoriteCubit extends BaseCubit<FavoriteModel> {
  final HomeRepo homeRepo;

  FavoriteCubit(this.homeRepo) : super();

  Future<void> post({
    String? categoryName,
    String? subjectName,
    String? teacherName,
    // required bool isfavorited,
  }) async {
    emitLoading();
    final result = await homeRepo.postFav(
      categoryName: categoryName,
      subjectName: subjectName,
      teacherName: teacherName,
    );
    result.fold(
      (failure) => emitFailure(failure.errMessage),
      (favorite) => emitSuccess(favorite),
    );
  }
}
