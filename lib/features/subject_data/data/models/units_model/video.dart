import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'video.g.dart'; // Name of the generated file

@HiveType(typeId: 10)
class Video extends Equatable {
  @HiveField(0)
  final int? id;
  @HiveField(1)
  final String? name;
  @HiveField(2)
  final String? video;
  @HiveField(3)
  final int? subjectId;
  @HiveField(4)
  final int? unitId;
  @HiveField(5)
  final int? lessonId;
  @HiveField(6)
  final int? adsId;
  @HiveField(7)
  final DateTime? createdAt;
  @HiveField(8)
  final DateTime? updatedAt;

  const Video({
    this.id,
    this.name,
    this.video,
    this.subjectId,
    this.unitId,
    this.lessonId,
    this.adsId,
    this.createdAt,
    this.updatedAt,
  });

  factory Video.fromJson(Map<String, dynamic> json) => Video(
        id: json['id'] as int?,
        name: json['name'] as String?,
        video: json['video'] as String?,
        subjectId: json['subject_id'] as int?,
        unitId: json['unit_id'] as int?,
        lessonId: json['lesson_id'] as int?,
        adsId: json['ads_id'] as int?,
        createdAt: json['created_at'] == null
            ? null
            : DateTime.parse(json['created_at'] as String),
        updatedAt: json['updated_at'] == null
            ? null
            : DateTime.parse(json['updated_at'] as String),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'video': video,
        'subject_id': subjectId,
        'unit_id': unitId,
        'lesson_id': lessonId,
        'ads_id': adsId,
        'created_at': createdAt?.toIso8601String(),
        'updated_at': updatedAt?.toIso8601String(),
      };

  @override
  List<Object?> get props {
    return [
      id,
      name,
      video,
      subjectId,
      unitId,
      lessonId,
      adsId,
      createdAt,
      updatedAt,
    ];
  }
}
