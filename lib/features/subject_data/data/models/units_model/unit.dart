import 'package:equatable/equatable.dart';
import 'package:lms_student/features/subject_data/data/models/units_model/file.dart';

import 'unit_data.dart';

class Unitt extends Equatable {
  final String? message;
  final List<UnitData>? data;
  final bool? isSubscription;
  // final List<Filee>? files;

  const Unitt({
    this.message,
    this.data,
    this.isSubscription,
  });

  factory Unitt.fromJson(Map<String, dynamic> json) => Unitt(
        message: json['message'] as String?,
        data: (json['data'] as List<dynamic>?)
            ?.map((e) => UnitData.fromJson(e as Map<String, dynamic>))
            .toList(),
        isSubscription: json['isSubscription'] as bool?,
      );

  Map<String, dynamic> toJson() => {
        'message': message,
        'data': data?.map((e) => e.toJson()).toList(),
        'isSubscription': isSubscription
      };

  @override
  List<Object?> get props => [message, data, isSubscription];
}
