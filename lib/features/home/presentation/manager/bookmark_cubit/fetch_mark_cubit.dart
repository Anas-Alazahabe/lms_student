import 'package:lms_student/core/cubits/base_cubit/base_cubit.dart';
import 'package:lms_student/features/home/data/models/bookmark_model/bookmark.dart';
import 'package:lms_student/features/home/data/repos/home_repo.dart';

class FetchBookMarkCubit extends BaseCubit<List<Bookmark>> {
  final HomeRepo homeRepo;

  FetchBookMarkCubit(this.homeRepo) : super();

  Future<void> get() async {
    emitLoading();
    final result = await homeRepo.fetchBook();
    result.fold(
      (f) => emitFailure(f.errMessage),
      (books) => emitSuccess(books),
    );
  }
}
