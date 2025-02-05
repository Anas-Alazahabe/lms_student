import 'package:equatable/equatable.dart';
import 'package:lms_student/features/subject_data/data/models/units_model/file.dart';
import 'package:lms_student/features/subject_data/data/models/units_model/video.dart';

import 'lesson.dart';

class UnitData extends Equatable {
  final int? id;
  final String? name;
  final String? description;
  final String? imageUrl;
  final int? videoId;
  final int? fileId;
  final int? subjectId;
  final List<Lesson>? lessons;
  final List<Filee>? files;
  final List<Video>? videos;

  const UnitData({
    this.id,
    this.name,
    this.description,
    this.imageUrl,
    this.videoId,
    this.fileId,
    this.subjectId,
    this.lessons,
    this.files,
    this.videos,
  });

  factory UnitData.fromJson(Map<String, dynamic> json) {
    print(json);
    return UnitData(
      id: json['id'] as int?,
      name: json['name'] as String?,
      description: json['description'] as String?,
      imageUrl: json['image_url'] as String?,
      videoId: json['video_id'] as int?,
      fileId: json['file_id'] as int?,
      subjectId: json['subject_id'] as int?,
      lessons: (json['lessons'] as List<dynamic>?)
          ?.map((e) => Lesson.fromJson(e as Map<String, dynamic>))
          .toList(),
      files: (json['files'] as List<dynamic>?)
          ?.map((e) => Filee.fromJson(e as Map<String, dynamic>))
          .toList(),
      videos: (json['videos'] as List<dynamic>?)
          ?.map((e) => Video.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'description': description,
        'image_url': imageUrl,
        'video_id': videoId,
        'file_id': fileId,
        'subject_id': subjectId,
        'lessons': lessons?.map((e) => e.toJson()).toList(),
        'files': files?.map((e) => e.toJson()).toList(),
        'videos': videos?.map((e) => e.toJson()).toList(),
      };

  @override
  List<Object?> get props {
    return [
      id,
      name,
      description,
      imageUrl,
      videoId,
      fileId,
      subjectId,
      lessons,
      files,
      videos,
    ];
  }
}
