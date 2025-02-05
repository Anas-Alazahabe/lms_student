import 'package:lms_student/core/cubits/base_cubit/base_cubit.dart';
import 'package:lms_student/features/home/data/models/bookmark_model/bookmark_model.dart';
import 'package:lms_student/features/home/data/repos/home_repo.dart';

class PostBookMarkcubit extends BaseCubit<BookmarkModel> {
  final HomeRepo homeRepo;
  PostBookMarkcubit(this.homeRepo) : super();

  Future<void> post({
    String? unitName,
    String? lessonName,
    String? videoName,
    String? fileName,
  }) async {
    emitLoading();
    final result = await homeRepo.postBook(
      unitName: unitName,
      lessonName: lessonName,
      videoName: videoName,
      fileName: fileName,
    );
    result.fold((l) => emitFailure(l.errMessage), (r) => emitSuccess(r));
  }
}
