import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:photo_view/photo_view.dart';

class NetImage extends StatelessWidget {
  double height;
  double width;
  int compressHeight;
  int compressWidth;
  String url;
  double windowWidth;
  bool openCache;
  bool cdnCompress;
  bool isPhoto;
  String defPath;
  String errorPath;

  NetImage({
    @required this.url,
    this.height,
    this.width,
    this.compressHeight,
    this.compressWidth,
    this.cdnCompress = true,
    this.openCache = true,
    this.isPhoto = false,
    this.defPath = "images/ic_default.webp",
    this.errorPath = "images/ic_default.webp",
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    windowWidth = size.width;
    return isPhoto ? photoImage() : (openCache ? cacheImg() : nonCache());
  }

  Widget nonCache() {
    return Image.network(
      cdnCompress
          ? "$url?x-oss-process=image/resize,h_${compressHeight * 3 ?? height.toInt() * 3},w_${(compressWidth * 3 ?? (width == double.infinity ? windowWidth : width * 3)).toInt()}"
          : url,
      loadingBuilder: (c, o, s) => _defaultIcon(width, height, defPath),
      errorBuilder: (c, o, s) => _defaultIcon(width, height, errorPath),
      fit: BoxFit.cover,
      width: width,
      height: height,
    );
  }

  ///从网络读取图片
  Widget cacheImg() {
    if (!openCache) {
      CachedNetworkImage.evictFromCache(url);
      CachedNetworkImage.evictFromCache(cdnCompress
          ? "$url?x-oss-process=image/resize,h_${compressHeight ?? height.toInt() * 3},w_${(compressWidth  ?? (width == double.infinity ? windowWidth : width * 3)).toInt()}"
          : url);
    }

    if (height == 0) {
      return CachedNetworkImage(
        placeholder: (context, url) => _defaultIcon(width, height, defPath),
        errorWidget: (context, url, error) => _defaultIcon(width, height, errorPath),
        imageUrl: url,
        width: width,
        fit: BoxFit.cover,
      );
    } else {
      return CachedNetworkImage(
        placeholder: (context, url) => _defaultIcon(width, height, defPath),
        errorWidget: (context, url, error) => _defaultIcon(width, height, errorPath),
        imageUrl: cdnCompress
            ? "$url?x-oss-process=image/resize,h_${compressHeight ?? height.toInt()* 3},w_${(compressWidth?? (width == double.infinity ? windowWidth : width* 3)).toInt()}"
            : url,
        width: width,
        height: height,
        fit: BoxFit.cover,
      );
    }
  }

  /// 未加载、加载失败时用的默认图片
  static Image _defaultIcon(double width, double height, String defPath) {
    return Image.asset(
      defPath,
      width: width,
      height: height,
      fit: BoxFit.cover,
    );
  }

  Widget photoImage() {
    return Container(
        width: width,
        height: height,
        child: PhotoView(
          imageProvider: CachedNetworkImageProvider(url),
        ));
  }
}
