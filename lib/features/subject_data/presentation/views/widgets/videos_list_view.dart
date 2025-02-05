import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hive/hive.dart';
import 'package:lms_student/constants.dart';
import 'package:lms_student/core/cubits/directory_cubit/directory_cubit.dart';
import 'package:lms_student/core/utils/app_router.dart';
import 'package:lms_student/core/utils/assets.dart';
import 'package:lms_student/core/utils/functions/custom_toast.dart';
import 'package:lms_student/core/utils/service_locator.dart';
import 'package:lms_student/core/widgets/custom_loading.dart';
import 'package:lms_student/features/downloads/presentataion/manager/download_cubit/downloads_cubit.dart';
import 'package:lms_student/features/subject_data/data/models/units_model/video.dart';

class VideosListView extends StatefulWidget {
  final String lessonName;
  final String subjectName;
  final String unitName;
  final List<Video> videos;
  final String imageUrl;

  const VideosListView({
    super.key,
    required this.videos,
    required this.lessonName,
    required this.imageUrl,
    required this.subjectName,
    required this.unitName,
  });

  @override
  State<VideosListView> createState() => _VideosListViewState();
}

class _VideosListViewState extends State<VideosListView> {
  var videoData = Hive.box<Video>(kVideo);
  var dir = getIt<DirectoryCubit>();
  @override
  Widget build(BuildContext context) {
    return widget.videos.isEmpty
        ? const Text('لا يوجد فيديوهات')
        : Container(
            margin: const EdgeInsets.all(10),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            child: ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: widget.videos.length,
              itemBuilder: (context, index) {
                return BlocConsumer<DownloadsCubit, DownloadsState>(
                  listener: (context, state) {
                    if (state is DownloadsSuccess &&
                        state.uniqueName ==
                            '${widget.videos[index].name}${widget.videos[index].id}') {
                      setState(() {
                        videoData.put(
                          widget.videos[index].id,
                          widget.videos[index],
                        );
                      });
                      BlocProvider.of<DownloadsCubit>(context)
                          .deleteDownloadState(state.uniqueName);
                    }
                    if (state is DownloadsFailure) {
                      customToast(state.errMessage);
                    }
                  },
                  builder: (context, state) {
                    var video = widget.videos[index];
                    var videoState =
                        context.read<DownloadsCubit>().downloadStates[
                            '${video.name}${widget.videos[index].id}'];
                    bool loading = videoState is DownloadsLoading;
                    bool pending = videoState is DownloadsPendingLoading;
                    bool exists = false;
                    for (var videoItem in videoData.values) {
                      if (videoItem.id == video.id!) {
                        exists = true;
                        break;
                      }
                    }
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: Colors.grey, width: 2)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  SizedBox(
                                    height: 100,
                                    width: 100,
                                    child: AspectRatio(
                                      aspectRatio: 16 / 9,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(20),
                                        child: CachedNetworkImage(
                                          fit: BoxFit.cover,
                                          imageUrl:
                                              '$kBaseUrlAsset/${widget.imageUrl}',
                                          progressIndicatorBuilder:
                                              (context, url, progress) {
                                            return const CustomLoading();
                                          },
                                          errorWidget: (context, url, error) {
                                            return Image.asset(AssetsData.logo);
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  Text(
                                    widget.videos[index].name!,
                                    style: const TextStyle(fontSize: 24),
                                  ),
                                  const Spacer(),
                                  Row(
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          context.push(AppRouter.kVideoView,
                                              extra: {
                                                'path':
                                                    widget.videos[index].video,
                                                'network': true
                                              });
                                        },
                                        icon: const Icon(
                                            Icons.play_arrow_rounded),
                                      ),
                                      if (!exists)
                                        IconButton(
                                          onPressed: exists //loading
                                              ? () {
                                                  var categoryDir = Directory(
                                                      '${dir.state!.path}/${widget.subjectName}/Units/${widget.unitName}/${widget.lessonName}/Videos');
                                                  context.push(
                                                      AppRouter.kVideoView,
                                                      extra: {
                                                        'path':
                                                            ('${categoryDir.path}/${video.name}.mp4'),
                                                      });
                                                }
                                              : () async {
                                                  if (loading || pending) {
                                                    BlocProvider.of<
                                                                DownloadsCubit>(
                                                            context)
                                                        .cancelDownload(
                                                            '${widget.videos[index].name}${widget.videos[index].id}');
                                                    return;
                                                  }

                                                  pending = true;

                                                  var categoryDir = Directory(
                                                      '${dir.state!.path}/${widget.subjectName}/Units/${widget.unitName}/${widget.lessonName}/Videos');
                                                  await BlocProvider.of<
                                                              DownloadsCubit>(
                                                          context)
                                                      .downloadFile(
                                                    dir: categoryDir,
                                                    uniqeName:
                                                        '${widget.videos[index].name}${widget.videos[index].id}',
                                                    urlEndPoint:
                                                        '${video.video}',
                                                    downloadPath:
                                                        ('${categoryDir.path}/${video.name}.mp4')
                                                            .trim(),
                                                    onReceiveProgress: null,
                                                  );
                                                },
                                          icon: exists
                                              ? const Icon(
                                                  Icons.check,
                                                  color: Colors.green,
                                                )
                                              : loading || pending
                                                  ? const Icon(Icons.cancel)
                                                  : const Icon(Icons.download),
                                        ),
                                    ],
                                  ),
                                  const Spacer(),
                                ],
                              ),
                              if (videoState is DownloadsLoading &&
                                  videoState.uniqueName ==
                                      '${widget.videos[index].name}${widget.videos[index].id}' &&
                                  !exists)
                                Column(
                                  children: [
                                    Text(
                                        '${(videoState.recived / 1000000).toStringAsFixed(1)} / ${(videoState.total / 1000000).toStringAsFixed(1)}'),
                                    LinearProgressIndicator(
                                      value: videoState.progress / 100,
                                    ),
                                  ],
                                ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ));
  }
}
