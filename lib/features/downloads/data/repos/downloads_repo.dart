import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:lms_student/core/errors/failures.dart';

abstract class DownloadsRepo {
  Future<Either<Failure, dynamic>> downloadFile(
      {required String urlEndPoint,
      required String downloadPath,
      required CancelToken cancelToken,
      required void Function(int received, int total)? onReceiveProgress});
}
