import 'package:equatable/equatable.dart';

class Ad extends Equatable {
  final int? id;
  final String? title;
  final String? description;
  final String? imageUrl;
  final int? isExpired;
  final dynamic stageId;
  final dynamic yearId;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const Ad({
    this.id,
    this.title,
    this.description,
    this.imageUrl,
    this.isExpired,
    this.stageId,
    this.yearId,
    this.createdAt,
    this.updatedAt,
  });

  factory Ad.fromJson(Map<String, dynamic> json) => Ad(
        id: json['id'] as int?,
        title: json['title'] as String?,
        description: json['description'] as String?,
        imageUrl: json['image_url'] as String?,
        isExpired: json['isExpired'] as int?,
        stageId: json['stage_id'] as dynamic,
        yearId: json['year_id'] as dynamic,
        createdAt: json['created_at'] == null
            ? null
            : DateTime.parse(json['created_at'] as String),
        updatedAt: json['updated_at'] == null
            ? null
            : DateTime.parse(json['updated_at'] as String),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'description': description,
        'image_url': imageUrl,
        'isExpired': isExpired,
        'stage_id': stageId,
        'year_id': yearId,
        'created_at': createdAt?.toIso8601String(),
        'updated_at': updatedAt?.toIso8601String(),
      };

  @override
  List<Object?> get props {
    return [
      id,
      title,
      description,
      imageUrl,
      isExpired,
      stageId,
      yearId,
      createdAt,
      updatedAt,
    ];
  }
}
