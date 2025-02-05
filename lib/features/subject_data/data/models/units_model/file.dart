import 'package:equatable/equatable.dart';

class Filee extends Equatable {
  final int? id;
  final String? name;
  final String? content;
  final String? subjectId;
  final String? unitId;
  final String? lessonId;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const Filee({
    this.id,
    this.name,
    this.content,
    this.subjectId,
    this.unitId,
    this.lessonId,
    this.createdAt,
    this.updatedAt,
  });

  factory Filee.fromJson(Map<String, dynamic> json) => Filee(
        id: json['id'] as int?,
        name: json['name'] as String?,
        content: json['content'] as String?,
        subjectId: json['subject_id'].toString(),
        unitId: json['unit_id'].toString(),
        lessonId: json['lesson_id'].toString(),
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
        'content': content,
        'subject_id': subjectId,
        'unit_id': unitId,
        'lesson_id': lessonId,
        'created_at': createdAt?.toIso8601String(),
        'updated_at': updatedAt?.toIso8601String(),
      };

  @override
  List<Object?> get props {
    return [
      id,
      name,
      content,
      subjectId,
      unitId,
      lessonId,
      createdAt,
      updatedAt,
    ];
  }
}
