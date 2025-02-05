import 'package:hive/hive.dart';

part 'file_state.g.dart';

@HiveType(typeId: 1)
class FileState extends HiveObject {
  @HiveField(0)
  final String fileTitle;

  FileState({required this.fileTitle});
}
