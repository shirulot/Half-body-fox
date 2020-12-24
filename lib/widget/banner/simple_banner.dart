import 'package:flutter/material.dart';
import 'package:half_body_fox/widget/video/simple_chewie.dart';
import 'package:video_player/video_player.dart';
import 'package:half_body_fox/base/routes.dart';
import 'package:half_body_fox/resource/key_resource.dart';
import 'package:half_body_fox/util/ui_tools.dart';
import 'package:half_body_fox/ext/ext.dart';
import 'package:half_body_fox/widget/net_img.dart';
import 'package:half_body_fox/widget/number_indicator.dart';

class SimpleBanner extends StatefulWidget {
  double width;
  double height;
  List<String> pathList = [];
  bool hasVideo;

  SimpleBanner({
    Key key,
    @required this.width,
    @required this.height,
    List<String> imgList = const [],
    List<String> videoList = const [],
    this.hasVideo = false,
  }) : super(key: key) {
    if (hasVideo && !videoList.isNullOrEmpty()) pathList.add(videoList[0]);
    pathList.addAll(imgList);
  }

  @override
  State<StatefulWidget> createState() => SimpleBannerState();
}

class SimpleBannerState extends State<SimpleBanner> {
  PageController _bannerController;
  VideoPlayerController _videoPlayerController;
  GlobalKey<NumberIndicatorState> indicatorKey = GlobalKey();
  int selection = 0;
  int count = 0;

  @override
  void initState() {
    super.initState();
    if (_bannerController == null) _bannerController = PageController(initialPage: selection);
    if (widget.hasVideo) {
      _videoPlayerController = VideoPlayerController.network(widget.pathList[0])
        ..initialize().then((_) {
          // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
          setState(() {});
        });
    }

    this.count = widget.pathList.length ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        PageView.builder(
          controller: _bannerController,
          itemBuilder: (BuildContext context, int position) => _buildBannerChild(context, position),
          scrollDirection: Axis.horizontal,
          reverse: false,
          itemCount: widget.pathList.length,
          onPageChanged: (int position) {
            setState(() {
              selection = position;
            });
          },
        ),
        Container(
          width: 36.w,
          height: 18.w,
          decoration: getCornersDecoration(bgColor: Colors.black54, circular: 50.w),
          child: "${selection + (widget.hasVideo ? 0 : 1)}/${count - (widget.hasVideo ? 1 : 0)}"
              .intoText(textSize: 11.w, textColor: Colors.white)
              .intoCenter(),
        ).isShow(!(selection == 0 && widget.hasVideo)).intoPositioned(right: 14.w, bottom: 14.w),
      ],
    ).setSize(widget.width, widget.height);
  }

  _buildBannerChild(BuildContext context, int position) {
    if (widget.hasVideo && position == 0) {
      return SimpleCheWie(
        url: widget.pathList[0],
        width: widget.width,
        height: widget.height,
      ).setBGColor(Colors.black);
    }

    return GestureDetector(
      // onTap: () => Navigator.of(context).pushNamed(route_preview, arguments: {
      //   key_data: widget.pathList,
      //   key_page: position - (widget.hasVideo ? 1 : 0),
      // }),
      onTap: () {},
      child: NetImage(width: widget.width, height: widget.height, url: widget.pathList[position]),
    );
  }

  Widget _buildVideo() {
    return Stack(
      children: [
        _videoPlayerController.value.initialized
            ? AspectRatio(aspectRatio: _videoPlayerController.value.aspectRatio, child: VideoPlayer(_videoPlayerController)).intoCenter()
            : Image.asset("images/ic_default.webp", width: widget.width, height: widget.height),
        IconButton(
          onPressed: () => setState(() {
            _videoPlayerController.value.isPlaying ? _videoPlayerController.pause() : _videoPlayerController.play();
          }),
          icon: Icon(
            _videoPlayerController.value.isPlaying ? Icons.pause_presentation : Icons.play_arrow_outlined,
            size: 30.w,
            color: Colors.white,
          ),
        ).intoCenter(),
      ],
    ).setBGColor(Colors.black);
  }
}
