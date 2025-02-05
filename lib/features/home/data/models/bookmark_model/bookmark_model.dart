import 'package:equatable/equatable.dart';

import 'bookmark.dart';

class BookmarkModel extends Equatable {
  final String? message;
  final Bookmark? bookmark;

  const BookmarkModel({this.message, this.bookmark});

  factory BookmarkModel.fromJson(Map<String, dynamic> json) => BookmarkModel(
        message: json['message'] as String?,
        bookmark: json['bookmark'] == null
            ? null
            : Bookmark.fromJson(json['bookmark'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'message': message,
        'bookmark': bookmark?.toJson(),
      };

  @override
  List<Object?> get props => [message, bookmark];
}
