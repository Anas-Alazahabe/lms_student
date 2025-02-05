import 'package:equatable/equatable.dart';
import 'package:lms_student/features/home/data/models/subjects_model/category.dart';
import 'package:lms_student/features/home/data/models/subjects_model/subject.dart';
import 'package:lms_student/features/subject_data/data/models/units_model/lesson.dart';
import 'package:lms_student/features/subject_data/data/models/units_model/unit_data.dart';
import 'teacher.dart';

class SearchResultModel extends Equatable {
  final String? message;
  final List<Categoryy>? categories;
  final List<Teacher>? teachers;
  final List<UnitData>? units;
  final List<Lesson>? lessons;
  final List<Subject>? subjects;

  const SearchResultModel({
    this.message,
    this.categories,
    this.teachers,
    this.units,
    this.lessons,
    this.subjects,
  });

  factory SearchResultModel.fromJson(Map<String, dynamic> json) {
    return SearchResultModel(
      message: json['message'] as String?,
      categories: (json['categories'] as List<dynamic>?)
          ?.map((e) => Categoryy.fromJson(e as Map<String, dynamic>))
          .toList(),
      teachers: (json['teachers'] as List<dynamic>?)
          ?.map((e) => Teacher.fromJson(e as Map<String, dynamic>))
          .toList(),
      units: (json['units'] as List<dynamic>?)
          ?.map((e) => UnitData.fromJson(e as Map<String, dynamic>))
          .toList(),
      lessons: (json['lessons'] as List<dynamic>?)
          ?.map((e) => Lesson.fromJson(e as Map<String, dynamic>))
          .toList(),
      subjects: (json['subjects'] as List<dynamic>?)
          ?.map((e) => Subject.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'message': message,
        'categories': categories?.map((e) => e.toJson()).toList(),
        'teachers': teachers?.map((e) => e.toJson()).toList(),
        'units': units?.map((e) => e.toJson()).toList(),
        'lessons': lessons?.map((e) => e.toJson()).toList(),
        'subjects': subjects?.map((e) => e.toJson()).toList(),
      };

  @override
  List<Object?> get props {
    return [
      message,
      categories,
      teachers,
      units,
      lessons,
      subjects,
    ];
  }
}
