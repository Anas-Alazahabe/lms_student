import 'package:lms_student/core/cubits/base_cubit/base_cubit.dart';
import 'package:lms_student/features/home/data/models/subjects_model/subjects_model.dart';
import 'package:lms_student/features/home/data/repos/home_repo.dart';

class SubjectsCubit extends BaseCubit<SubjectsModel> {
  final HomeRepo homeRepo;

  SubjectsCubit(this.homeRepo) : super();

  Future<void> fetchSubjects({required String? yearId}) async {
    emitLoading();
    final result = await homeRepo.fetchSubjects(yearId: yearId);
    result.fold(
      (failure) => emitFailure(failure.errMessage),
      (subjects) => emitSuccess(subjects),
    );
  }
}
