// import 'package:video_player/video_player.dart';
// import 'package:markhor/ext/ext.dart';
// import 'package:flutter/material.dart';
//
// class SimpleVideo extends StatefulWidget {
//   final double width;
//   final double height;
//   final String url;
//
//   SimpleVideo({
//     @required this.width,
//     @required this.height,
//     @required this.url,
//   });
//
//   @override
//   State<StatefulWidget> createState() => SimpleVideoState();
// }
//
// class SimpleVideoState extends State<SimpleVideo> {
//   VideoPlayerController _controller;
//   double height;
//   double width;
//   String url;
//   Duration _position;
//
//   @override
//   void initState() {
//     super.initState();
//     height = widget.height;
//     width = widget.width;
//     url = widget.url;
//     _controller = VideoPlayerController.network(url,videoPlayerOptions: )
//       ..initialize().then((_) {
//         setState(() {});
//       });
//     _controller.addListener(() {
//       _controller.position.then((d) {
//         _position = d;
//
//       });
//       // _controller.
//     });
//    var vpv =  VideoPlayerValue(duration: Duration());
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: Stack(
//         children: [
//           Container(
//             width: width,
//             height: height,
//             color: Colors.black,
//             child: _controller.value.initialized
//                 ? AspectRatio(aspectRatio: _controller.value.aspectRatio, child: VideoPlayer(_controller))
//                 : Center(child: CircularProgressIndicator()),
//           ),
//           Row(
//             // 加载完成时才渲染,flex布局
//             children: <Widget>[
//               IconButton(
//                 // 播放按钮
//                 padding: EdgeInsets.zero,
//                 iconSize: 26,
//                 icon: Icon(
//                   // 根据控制器动态变化播放图标还是暂停
//                   _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
//                   color: Colors.white,
//                 ),
//                 onPressed: _playOrPause,
//               ),
//               Expanded(
//                 // 相当于前端的flex: 1
//                 child: VideoPlayerSlider(
//                   startPlayControlTimer: _startPlayControlTimer,
//                   timer: _timer,
//                 ),
//               ),
//               Container(
//                 // 播放时间
//                 margin: EdgeInsets.only(left: 10),
//                 child: Text(
//                   '${DateUtil.formatDateMs(
//                     _position?.inMilliseconds,
//                     format: 'mm:ss',
//                   )}/${DateUtil.formatDateMs(
//                     _totalDuration?.inMilliseconds,
//                     format: 'mm:ss',
//                   )}',
//                   style: TextStyle(color: Colors.white),
//                 ),
//               ),
//               IconButton(
//                 // 全屏/横屏按钮
//                 padding: EdgeInsets.zero,
//                 iconSize: 26,
//                 icon: Icon(
//                   // 根据当前屏幕方向切换图标
//                   _isFullScreen ? Icons.fullscreen_exit : Icons.fullscreen,
//                   color: Colors.white,
//                 ),
//                 onPressed: () {
//                   // 点击切换是否全屏
//                   _toggleFullScreen();
//                 },
//               ),
//             ],
//           ).intoAlign(Alignment.bottomCenter)
//         ],
//       ),
//     );
//   }
//
//   void _playOrPause() {
//     /// 同样的，点击动态播放或者暂停
//     if (_controller.value.initialized) {
//       _controller.value.isPlaying ? _controller.pause() : _controller.play();
//       // _startPlayControlTimer(); // 操作控件后，重置延迟隐藏控件的timer
//     }
//   }
//
//   // void _startPlayControlTimer() {
//   //   /// 计时器，用法和前端js的大同小异
//   //   if (_timer != null) _timer.cancel();
//   //   _timer = Timer(Duration(seconds: 3), () {
//   //     /// 延迟3s后隐藏
//   //     setState(() {
//   //       _playControlOpacity = 0;
//   //       Future.delayed(Duration(milliseconds: 500)).whenComplete(() {
//   //         _hidePlayControl = true;
//   //       });
//   //     });
//   //   });
//   }
//
//   @override
//   void dispose() {
//     super.dispose();
//     _controller?.dispose();
//   }
// }
