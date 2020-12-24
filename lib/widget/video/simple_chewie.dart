import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/services.dart';
import 'package:half_body_fox/ext/ext.dart';
import 'package:half_body_fox/resource/color_resource.dart';
import 'package:half_body_fox/util/logger_util.dart';
import 'package:half_body_fox/util/toast_util.dart';
import 'package:video_player/video_player.dart';

class SimpleCheWie extends StatefulWidget {
  double width;
  double height;
  String url;

  SimpleCheWie({Key key, this.width, this.height, this.url}) : super(key: key);

  @override
  State<StatefulWidget> createState() => SimpleCheWieState();
}

class SimpleCheWieState extends State<SimpleCheWie> {
  VideoPlayerController _videoPlayerController;
  ChewieController _chewieController;

  @override
  void initState() {
    super.initState();
    logger.e("url = ${widget.url}");
    initializePlayer();
  }

  initializePlayer() async {
    // _videoPlayerController = VideoPlayerController.network(widget.url);
    _videoPlayerController = VideoPlayerController.network(widget.url,formatHint: VideoFormat.hls, );
    await _videoPlayerController.initialize();
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController,
      autoPlay: false,
      allowFullScreen: true,
      looping: false,
      // Try playing around with some of these other options:
      // showControls: false,
      materialProgressColors: ChewieProgressColors(
        playedColor: color_mainBlue,
        handleColor: Colors.white,
        backgroundColor: Colors.grey,
        bufferedColor: Colors.white,
      ),
      // placeholder: Container(
      //   color: Colors.grey,
      // ),
      autoInitialize: true,
      systemOverlaysOnEnterFullScreen: [SystemUiOverlay.top],
      deviceOrientationsOnEnterFullScreen: [DeviceOrientation.portraitUp],
    );
    if (_videoPlayerController != null && _chewieController != null) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData.dark().copyWith(
          primaryColorDark: Colors.white,
          canvasColor: Colors.white,
          accentColor: Colors.white,
          primaryColorLight: Colors.white,
          primaryColor: Colors.white,
          platform: TargetPlatform.android),
      child: Container(
        height: widget.height,
        width: widget.width,
        child: _buildPlayer(),
      ),
    );
  }

  @override
  void dispose() {
    _videoPlayerController?.dispose();
    _chewieController?.dispose();
    super.dispose();
  }

  Widget _buildPlayer() {
    try {
      return _chewieController != null && _chewieController.videoPlayerController.value.initialized
          ? Chewie(controller: _chewieController)
          : CircularProgressIndicator().intoCenter();
    } catch (e) {
      logger.e(e);
      return Center(child: "Load failed".intoText(textColor: Colors.white));
    }
  }
}
