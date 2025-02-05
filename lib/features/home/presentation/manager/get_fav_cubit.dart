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

class FetchFavoriteCubit extends BaseCubit<List<Favorite>> {
  final HomeRepo homeRepo;

  FetchFavoriteCubit(this.homeRepo) : super();

  Future<void> get() async {
    emitLoading();
    final result = await homeRepo.getFav();
    result.fold(
      (failure) => emitFailure(failure.errMessage),
      (favorite) => emitSuccess(favorite),
    );
  }
}
