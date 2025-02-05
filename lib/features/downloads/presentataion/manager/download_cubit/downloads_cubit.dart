import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lms_student/features/downloads/data/repos/downloads_repo.dart';
import 'package:equatable/equatable.dart';

part 'downloads_state.dart';

class DownloadsCubit extends Cubit<DownloadsState> {
  final DownloadsRepo downloadsRepo;
  // Add a map to track download states for each video
  Map<String, DownloadsState> downloadStates = {};
  Map<String, CancelToken> cancelTokens = {};

  DownloadsCubit(this.downloadsRepo) : super(const DownloadsInitial('0'));

  Future<void> downloadFile({
    required Directory? dir,
    required String urlEndPoint,
    required String downloadPath,
    required String uniqeName, // Add a videoId parameter
    required void Function(int count, int total)? onReceiveProgress,
  }) async {
    //  emit(DownloadsPendingLoading(uniqueName: uniqeName));
    if (dir != null) {
      if (!await dir.exists()) {
        await dir.create(recursive: true);
      }
    }

    // Create a CancelToken and store it in the map
    cancelTokens[uniqeName] = CancelToken();

    try {
      final result = await downloadsRepo.downloadFile(
        cancelToken: cancelTokens[uniqeName]!, // Use the CancelToken
        urlEndPoint: urlEndPoint,
        downloadPath: downloadPath,
        onReceiveProgress: (received, total) {
          if (received == total) {
            emit(DownloadsSuccess(uniqueName: uniqeName));
            deleteDownloadState(state.uniqueName);
          }
          var progress = (received / total * 100);
          // Update the download state for the specific video
          downloadStates[uniqeName] = DownloadsLoading(
              recived: received,
              total: total,
              progress: progress,
              uniqueName: uniqeName);

          // Emit a new state to trigger a UI update
          emit(DownloadsLoading(
              recived: received,
              total: total,
              progress: progress,
              uniqueName: uniqeName));
        },
      );
      result.fold((failure) {
        downloadStates[uniqeName] = DownloadsFailure(
            errMessage: failure.errMessage, uniqueId: uniqeName);

        // Emit a new state to trigger a UI update
        emit(DownloadsFailure(
            errMessage: failure.errMessage, uniqueId: uniqeName));
      }, (r) {
        emit(DownloadsSuccess(uniqueName: uniqeName));
      });
    } catch (e) {
      // Update the download state for the specific video
      downloadStates[uniqeName] =
          DownloadsFailure(errMessage: e.toString(), uniqueId: uniqeName);

      // Emit a new state to trigger a UI update
      emit(DownloadsFailure(errMessage: e.toString(), uniqueId: uniqeName));
    }
  }

  void deleteDownloadState(String uniqueName) {
    downloadStates.remove(uniqueName);
  }

  void cancelDownload(String uniqueName) {
    cancelTokens[uniqueName]?.cancel("User cancelled the download");
    deleteDownloadState(uniqueName);
    downloadStates.remove(uniqueName);
    emit(DownloadsInitial(uniqueName));
  }
}
