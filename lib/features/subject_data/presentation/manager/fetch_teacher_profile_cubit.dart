import 'package:lms_student/core/cubits/base_cubit/base_cubit.dart';
import 'package:lms_student/features/subject_data/data/models/teacher_profile_model/users_model.dart';
import 'package:lms_student/features/subject_data/data/repo/subject_repo.dart';

class FetchTeacherProfileCubit extends BaseCubit<UsersModel> {
  final SubjectRepo subjectRepo;

  FetchTeacherProfileCubit(this.subjectRepo) : super();

  Future<void> fetchUser({required String userId,required bool isTeacher}) async {
    emitLoading();
    final result = await subjectRepo.fetchTeacherProfile(userId: userId,isTeacher: isTeacher);
    result.fold(
      (failure) => emitFailure(failure.errMessage),
      (teacher) => emitSuccess(teacher),
    );
  }
}
