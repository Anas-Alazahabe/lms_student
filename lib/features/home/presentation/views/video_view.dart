import 'dart:io';

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:lms_student/constants.dart';
import 'package:video_player/video_player.dart';
import 'package:lms_student/core/utils/functions/secure_screen.dart';
// import 'C:\Users\USER\Documents\mob_project\lms-student\lib\core\utils\functions\secure_screen.dart';

class VideoView extends StatefulWidget {
  final String path;
  final bool network;
  const VideoView({super.key, required this.path, this.network = false});

  @override
  State<VideoView> createState() => _VideoViewState();
}

class _VideoViewState extends State<VideoView> {
  late VideoPlayerController _videoPlayerController;
  ChewieController? _chewieController;

  @override
  void initState() {
    super.initState();
    secureScreen();
    _initializeVideoPlayer();
  }

  void _initializeVideoPlayer() async {
    if (widget.network) {
      _videoPlayerController =
          VideoPlayerController.network('$kBaseUrlAsset/${widget.path}');
      await _videoPlayerController.initialize();
    } else {
      _videoPlayerController =
          VideoPlayerController.file(File.fromUri(Uri.file(widget.path)));
    }
    setState(() {
      _chewieController = ChewieController(
        videoPlayerController: _videoPlayerController,
        autoPlay: true,
        looping: false,
        zoomAndPan: true,
      );
    });
  }

  @override
  void dispose() {
    super.dispose();
    clearSecureScreen();
    _videoPlayerController.dispose();
    _chewieController?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: _chewieController != null
              ? Chewie(
                  controller: _chewieController!,
                )
              : const CircularProgressIndicator(), // Show a loading spinner if _chewieController is null
        ),
      ),
    );
  }
}
