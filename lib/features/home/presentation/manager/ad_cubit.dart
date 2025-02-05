import 'package:lms_student/core/cubits/base_cubit/base_cubit.dart';
import 'package:lms_student/features/home/data/models/ad_model/ad_model.dart';
import 'package:lms_student/features/home/data/repos/home_repo.dart';

class AdCubit extends BaseCubit<AdModel> {
  final HomeRepo homeRepo;

  AdCubit(this.homeRepo) : super();

  Future<void> fetchAds({required bool all}) async {
    emitLoading();
    final result = await homeRepo.fetchAds(all: all);
    result.fold(
      (failure) => emitFailure(failure.errMessage),
      (ad) => emitSuccess(ad),
    );
  }
}
