import 'package:hive/hive.dart';

part 'failed_request.g.dart';

@HiveType(typeId: 2)
class FailedRequest extends HiveObject {
  @HiveField(0)
  final String quizId;
  @HiveField(1)
  final String points;
  @HiveField(2)
  final String marks;
  @HiveField(3)
  final String courseId;

  FailedRequest({
    required this.quizId,
    required this.points,
    required this.marks,
    required this.courseId,
  });
}
