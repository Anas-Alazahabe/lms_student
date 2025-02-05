import 'package:equatable/equatable.dart';
import 'package:lms_student/features/auth/data/models/user_model/user.dart';
import 'package:lms_student/features/subject_data/data/models/units_model/file.dart';

class Subject extends Equatable {
  final String? id;
  final String? name;
  final String? description;
  final int? price;
  final int? categoryId;
  final String? imageData;
  final dynamic videoId;
  final dynamic fileId;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final List<User>? users;
  final List<Filee>? files;

  const Subject({
    this.id,
    this.name,
    this.description,
    this.price,
    this.categoryId,
    this.imageData,
    this.videoId,
    this.fileId,
    this.createdAt,
    this.updatedAt,
    this.files,
    this.users,
  });

  factory Subject.fromJson(Map<String, dynamic> json) => Subject(
        id: json["id"].toString(),
        name: json['name'] as String?,
        description: json['description'] as String?,
        price: json['price'] as int?,
        files: (json['files'] as List<dynamic>?)
            ?.map((e) => Filee.fromJson(e as Map<String, dynamic>))
            .toList(),
        categoryId: json['category_id'] as int?,
        imageData: json['image_data'] as String?,
        videoId: json['video_id'] as dynamic,
        fileId: json['file_id'] as dynamic,
        createdAt: json['created_at'] == null
            ? null
            : DateTime.parse(json['created_at'] as String),
        updatedAt: json['updated_at'] == null
            ? null
            : DateTime.parse(json['updated_at'] as String),
        users: (json['users'] as List<dynamic>?)
            ?.map((e) => User.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'description': description,
        'price': price,
        'category_id': categoryId,
        'image_data': imageData,
        'video_id': videoId,
        'file_id': fileId,
        'created_at': createdAt?.toIso8601String(),
        'updated_at': updatedAt?.toIso8601String(),
        'files': files?.map((e) => e.toJson()).toList(),
        'users': users?.map((e) => e.toJson()).toList(),
      };

  @override
  List<Object?> get props {
    return [
      id,
      name,
      description,
      price,
      categoryId,
      imageData,
      videoId,
      fileId,
      createdAt,
      updatedAt,
      users,
    ];
  }
}
