import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:lms_student/constants.dart';
import 'package:lms_student/core/cubits/token_cubit/token_cubit.dart';
import 'package:lms_student/core/errors/failures.dart';
import 'package:lms_student/core/utils/api_service.dart';
import 'package:lms_student/core/utils/service_locator.dart';
import 'package:lms_student/features/downloads/data/repos/downloads_repo.dart';

class DownloadsRepoImpl implements DownloadsRepo {
  final ApiService _apiService;
  final TokenCubit tokenCubit = getIt<TokenCubit>();
  DownloadsRepoImpl(this._apiService);

  @override
  Future<Either<Failure, dynamic>> downloadFile(
      {required String urlEndPoint,
      required String downloadPath,
      required CancelToken cancelToken,
      required void Function(int count, int total)? onReceiveProgress}) async {
    try {
      final result = await _apiService.download(
          url: '$kBaseUrlAsset/$urlEndPoint',
          token: tokenCubit.state,
          downloadPath: downloadPath,
          onReceiveProgress: onReceiveProgress,
          cancelToken: cancelToken);
      return right(result);
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioException(e));
      }
      return Left(ServerFailure(e.toString()));
    }
  }
}
