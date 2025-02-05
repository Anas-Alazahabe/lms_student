// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'failed_request.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FailedRequestAdapter extends TypeAdapter<FailedRequest> {
  @override
  final int typeId = 2;

  @override
  FailedRequest read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FailedRequest(
      quizId: fields[0] as String,
      points: fields[1] as String,
      marks: fields[2] as String,
      courseId: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, FailedRequest obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.quizId)
      ..writeByte(1)
      ..write(obj.points)
      ..writeByte(2)
      ..write(obj.marks)
      ..writeByte(3)
      ..write(obj.courseId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FailedRequestAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
