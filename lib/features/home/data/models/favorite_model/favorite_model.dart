import 'package:equatable/equatable.dart';

import 'favorite.dart';

class FavoriteModel extends Equatable {
  final String? message;
  final Favorite? favorite;
  // final bool isfavorited;

  const FavoriteModel({this.message, this.favorite
      // , required this.isfavorited
      });

  factory FavoriteModel.fromJson(Map<String, dynamic> json) => FavoriteModel(
        message: json['message'] as String?,
        favorite: json['favorite'] == null
            ? null
            : Favorite.fromJson(json['favorite'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'message': message,
        'favorite': favorite?.toJson(),
      };

  @override
  List<Object?> get props => [message, favorite];
}
