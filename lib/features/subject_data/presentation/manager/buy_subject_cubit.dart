import 'package:lms_student/core/cubits/base_cubit/base_cubit.dart';
import 'package:lms_student/features/subject_data/data/repo/subject_repo.dart';

class BuySubjectCubit extends BaseCubit<String> {
  final SubjectRepo subjectRepo;

  BuySubjectCubit(this.subjectRepo) : super();

  Future<void> buySubject({required String? subjectId}) async {
    emitLoading();
    final result = await subjectRepo.buySubject(subjectId: subjectId);
    result.fold(
      (failure) => emitFailure(failure.errMessage),
      (units) => emitSuccess(units),
    );
  }
}
