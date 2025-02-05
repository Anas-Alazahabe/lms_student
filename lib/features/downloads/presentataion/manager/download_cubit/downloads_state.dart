part of 'downloads_cubit.dart';

abstract class DownloadsState extends Equatable {
  final String uniqueName;

  const DownloadsState(this.uniqueName);

  @override
  List<Object> get props => [uniqueName];
}

class DownloadsInitial extends DownloadsState {
  const DownloadsInitial(super.uniqueName);
}

class DownloadsPendingLoading extends DownloadsState {
  const DownloadsPendingLoading({required String uniqueName})
      : super(uniqueName);
}

class DownloadsLoading extends DownloadsState {
  final num progress;
  final num total;
  final num recived;

  const DownloadsLoading(
      {required this.total,
      required this.recived,
      required this.progress,
      required String uniqueName})
      : super(uniqueName);

  @override
  List<Object> get props => [progress, uniqueName];
}

class DownloadsFailure extends DownloadsState {
  final String errMessage;

  const DownloadsFailure({required this.errMessage, required String uniqueId})
      : super(uniqueId);

  @override
  List<Object> get props => [errMessage, uniqueName];
}

class DownloadsSuccess extends DownloadsState {
  const DownloadsSuccess({required String uniqueName}) : super(uniqueName);

  @override
  List<Object> get props => [uniqueName];
}
