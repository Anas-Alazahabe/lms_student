import 'package:equatable/equatable.dart';

class Favorite extends Equatable {
  final String? category;
  final String? subject;
  final String? teacher;
  final String? userId;
  final String? favoritableId;
  final String? favoritableType;
  final String? favoritableName;
  final int? id;

  const Favorite({
    this.category,
    this.subject,
    this.teacher,
    this.userId,
    this.favoritableId,
    this.favoritableType,
    this.favoritableName,
    this.id,
  });

  factory Favorite.fromJson(Map<String, dynamic> json) => Favorite(
        category: json['category'] as String?,
        subject: json['subject'] as String?,
        teacher: json['teacher'] as String?,
        userId: json['user_id']?.toString(),
        favoritableId: json['favoritable_id']?.toString(),
        favoritableType: json['favoritable_type'] as String?,
        favoritableName: json['favoritable_name'] as String?,
        id: json['id'] as int?,
      );

  Map<String, dynamic> toJson() => {
        if (category != null) 'category': category,
        if (subject != null) 'subject': subject,
        if (teacher != null) 'teacher': teacher,
        'user_id': userId,
        'favoritable_id': favoritableId,
        'favoritable_type': favoritableType,
        'favoritable_name': favoritableName,
        'id': id,
      };

  // Map<String, dynamic> toJsoncategory() => {

  //       'category': category,
  //       // 'subject': subject,
  //       // 'teacher': teacher,
  //       // 'user_id': userId,
  //       // 'favoritable_id': favoritableId,
  //       // 'favoritable_type': favoritableType,
  //       // 'favoritable_name': favoritableName,
  //       // 'id': id,
  //     };

  // Map<String, dynamic> toJsonteacher() => {

  //       // 'category': category,
  //       // 'subject': subject,
  //       'teacher': teacher,
  //       // 'user_id': userId,
  //       // 'favoritable_id': favoritableId,
  //       // 'favoritable_type': favoritableType,
  //       // 'favoritable_name': favoritableName,
  //       // 'id': id,
  //     };

  @override
  List<Object?> get props {
    return [
      category,
      subject,
      teacher,
      userId,
      favoritableId,
      favoritableType,
      favoritableName,
      id,
    ];
  }
}
