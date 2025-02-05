import 'package:lms_student/core/cubits/base_cubit/base_cubit.dart';
import 'package:lms_student/features/home/data/models/search_result_model/search_result_model.dart';
import 'package:lms_student/features/home/data/repos/home_repo.dart';

class SearchSubjectsCubit extends BaseCubit<SearchResultModel> {
  final HomeRepo homeRepo;

  SearchSubjectsCubit(this.homeRepo) : super();

  Future<void> search({
    required String? yearId,
    required String? name,
  }) async {
    emitLoading();
    final result = await homeRepo.searchSubject(yearId: yearId, name: name);
    result.fold(
      (failure) => emitFailure(failure.errMessage),
      (subjects) => emitSuccess(subjects),
    );
  }
}
