import 'package:equatable/equatable.dart';

class Bookmark extends Equatable {
  final String? unit;
  final String? lesson;
  final String? video;
  final String? file;
  final String? userId;
  final String? bookmarkableId;
  final String? bookmarkableType;
  final String? bookmarkName;
  final int? id;

  const Bookmark({
    this.unit,
    this.lesson,
    this.video,
    this.file,
    this.userId,
    this.bookmarkableId,
    this.bookmarkableType,
    this.bookmarkName,
    this.id,
  });

  factory Bookmark.fromJson(Map<String, dynamic> json) => Bookmark(
        unit: json['unit'] as String?,
        lesson: json['lesson'] as String?,
        video: json['video'] as String?,
        file: json['file'] as String?,
        userId: json['user_id']?.toString(),
        bookmarkableId: json['bookmarkable_id']?.toString(),
        bookmarkableType: json['bookmarkable_type'] as String?,
        bookmarkName: json['bookmark_name'] as String?,
        id: json['id'] as int?,
      );

  Map<String, dynamic> toJson() => {
        if (unit != null) 'unit': unit,
        if (lesson != null) 'lesson': lesson,
        if (video != null) 'video': video,
        if (file != null) 'file': file,
        'user_id': userId,
        'bookmarkable_id': bookmarkableId,
        'bookmarkable_type': bookmarkableType,
        'bookmark_name': bookmarkName,
        'id': id,
      };

  @override
  List<Object?> get props {
    return [
      unit,
      lesson,
      video,
      file,
      userId,
      bookmarkableId,
      bookmarkableType,
      bookmarkName,
      id,
    ];
  }
}
