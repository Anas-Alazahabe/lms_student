import 'package:equatable/equatable.dart';

class Reply extends Equatable {
  final int? id;
  final String? text;
  // final int? parentId;
  // final int? userId;
  // final int? courseId;
  final String? name;
  final String? imageIndex;

  const Reply({
    this.id,
    this.text,
    this.name,
    this.imageIndex,
  });

  factory Reply.fromJson(Map<String, dynamic> json) => Reply(
        id: json['Id'] as int?,
        text: json['Text'] as String?,
        name: json['name'] as String?,
        imageIndex: json['user_image']?.toString(),
      );

  Map<String, dynamic> toJson() => {
        'Id': id,
        'Text': text,
        'name': name,
        'user_image': imageIndex,
      };

  @override
  List<Object?> get props {
    return [
      id,
      text,
      name,
      imageIndex,
    ];
  }
}
