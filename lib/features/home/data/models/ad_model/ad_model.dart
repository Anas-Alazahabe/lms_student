import 'package:equatable/equatable.dart';

import 'ad.dart';

class AdModel extends Equatable {
  final List<Ad>? message;

  const AdModel({this.message});

  factory AdModel.fromJson(Map<String, dynamic> json) => AdModel(
        message: (json['newestAds'] as List<dynamic>?)
            ?.map((e) => Ad.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'message': message?.map((e) => e.toJson()).toList(),
      };

  @override
  List<Object?> get props => [message];
}
