// ignore_for_file: use_build_context_synchronously, depend_on_referenced_packages

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lms_student/constants.dart';
import 'package:lms_student/core/cubits/shared_preferences_cubit/shared_preferences_cubit.dart';
import 'package:lms_student/core/utils/app_router.dart';
import 'package:lms_student/core/utils/service_locator.dart';
import 'package:lms_student/features/downloads/data/models/file_state/file_state.dart';
import 'package:hive/hive.dart';
import 'package:lms_student/features/subject_data/data/models/units_model/video.dart';
import 'package:path/path.dart' as p;

class FoldersScreen extends StatefulWidget {
  final Directory directory;

  const FoldersScreen({super.key, required this.directory});

  @override
  FoldersScreenState createState() => FoldersScreenState();
}

class FoldersScreenState extends State<FoldersScreen> {
  late List<FileSystemEntity> entities;
  var videoData = Hive.box<Video>(kVideo);
  var fileStates = Hive.box<FileState>(kFileState);
  final sharedPreferencesCubit = getIt<SharedPreferencesCubit>();

  @override
  void initState() {
    super.initState();
    entities = widget.directory.listSync().toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(p.basename(widget.directory.path)),
        actions: [
          IconButton(
              onPressed: () {
                context.pushReplacement(AppRouter.kHomeView,
                    extra: sharedPreferencesCubit.getGrade());
              },
              icon: const Icon(Icons.home)),
        ],
      ),
      body: ListView.builder(
        itemCount: entities.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              // elevation: 10,
              child: ListTile(
                leading: entities[index] is File
                    ? _getFileIcon(p.extension(entities[index].path))
                    : const Icon(Icons.folder_copy_rounded),
                title: entities[index] is File
                    ? Text(p.basenameWithoutExtension(entities[index].path))
                    : Text(p.basename(entities[index].path)),
                onTap: () {
                  if (entities[index] is Directory) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FoldersScreen(
                          directory: entities[index] as Directory,
                        ),
                      ),
                    );
                  } else if (entities[index] is File) {
                    _openFile(
                      entities[index].path,
                    );
                  }
                },
                trailing: entities[index] is File
                    ? IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () async {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('تأكيد'),
                                content: const Text('هل تريد حذف هذا الملف؟'),
                                actions: <Widget>[
                                  TextButton(
                                    child: const Text('إلغاء'),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                  TextButton(
                                    child: const Text('حذف'),
                                    onPressed: () async {
                                      await _deleteFile(index, context);
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      )
                    : null,
              ),
            ),
          );
        },
      ),
    );
  }

  Future<void> _deleteFile(int index, BuildContext context) async {
    for (var videoState in videoData.values) {
      if (videoState.name == p.basenameWithoutExtension(entities[index].path)) {
        videoData.delete(videoState.id);
        break;
      }
    }
    for (var fileState in fileStates.values) {
      if (fileState.fileTitle ==
          p.basenameWithoutExtension(entities[index].path)) {
        fileState.delete();
        break;
      }
    }
    await entities[index].delete();
    Navigator.of(context).pop();
    setState(() {
      entities.removeAt(index);
    });
  }

  Icon _getFileIcon(String extension) {
    switch (extension) {
      case '.mp4':
        return const Icon(Icons.video_collection);
      case '.jpg':
        return const Icon(Icons.image);
      case '.pdf':
        return const Icon(Icons.picture_as_pdf);
      default:
        return const Icon(Icons.insert_drive_file);
    }
  }

  void _openFile(String path) {
    String extension = p.extension(path);
    switch (extension) {
      case '.mp4':
        {
          var video = videoData.values.firstWhere(
              (element) => element.name == p.basenameWithoutExtension(path));
          context.push(AppRouter.kVideoView, extra: {
            'video': video,
            'path': path,
          });
        }
        break;
      case '.jpg':
        break;
      case '.pdf':
        context.push(AppRouter.kPdfView, extra: path);
        break;
      default:
        break;
    }
  }
}
