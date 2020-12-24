
import 'package:flutter/material.dart';
import 'package:half_body_fox/ext/ext.dart';
import 'package:half_body_fox/resource/color_resource.dart';
import 'package:half_body_fox/util/ui_tools.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

class ImageSelector extends StatefulWidget {
  bool canSelectionVideo;
  bool showSelectedCount;
  bool scrollable;
  int max;
  String text;
  Function onSelectedResultListener;

  ImageSelector({
    Key key,
    this.canSelectionVideo = false,
    this.showSelectedCount = true,
    this.scrollable = false,
    this.max = 9,
    this.text = "Add Photos",
    this.onSelectedResultListener,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => ImageSelectorState();
}

class ImageSelectorState extends State<ImageSelector> {
  List<Asset> list = [];
  double fullWidth;

  @override
  Widget build(BuildContext context) {
    fullWidth = MediaQuery.of(context).size.width;
    return GridView.builder(
      shrinkWrap: true,
      itemBuilder: _buildItem,
      padding: EdgeInsets.zero,
      itemCount: (list.length + 1).limit(min: 1, max: widget.max),
      physics: widget.scrollable ? null : NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, childAspectRatio: 1),
    );
  }

  Widget _buildItem(BuildContext context, int index) {
    if (list.length < widget.max && index == list.length) {
      return Container(
        margin: EdgeInsets.all(5.w),
        width: double.infinity,
        height: double.infinity,
        decoration: imagesBG("images/ic_border.png"),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(widget.canSelectionVideo ? "images/ic_camera.webp" : "images/ic_photo.webp", height: 35.w, width: 35.w),
            "Add Photo ${widget.showSelectedCount ? "\n(${list.length}/${widget.max})" : ""}"
                .intoText(textSize: 12.w, textColor: color_mainBlack, textAlign: TextAlign.center)
          ],
        ).intoFlatButton(() => _pickImage()),
      );
    } else {
      var imageWidth = (fullWidth - 50.w) / 3 + 20;
      return Container(
        width: double.infinity,
        height: double.infinity,
        child: Card(
          margin: EdgeInsets.all(5.w),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(2.w))),
          child: Stack(
            children: [
              AssetThumb(
                height: imageWidth.toInt(),
                width: imageWidth.toInt(),
                asset: list[index],
                spinner: Image.asset("images/ic_default.webp", height: imageWidth, width: imageWidth),
              ),
              Positioned(
                right: 0,
                top: 0,
                child: Image.asset(
                  "images/ic_clear_v2.png",
                  height: 10.w,
                  width: 10.w,
                ).intoPadding(EdgeInsets.all(5.w)).setClickListener(
                  () {
                    setState(() {
                      list.remove(list[index]);
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      );
    }
  }

  _pickImage() async {
    List<Asset> resultList = await MultiImagePicker.pickImages(
      maxImages: widget.max,
      enableCamera: false,
      selectedAssets: list,
      cupertinoOptions: CupertinoOptions(takePhotoIcon: "chat"),
      materialOptions: MaterialOptions(
        actionBarColor: "#000000",
        actionBarTitle: "Photos",
        allViewTitle: "All Photos",
        useDetailsView: false,
        selectCircleStrokeColor: "#ffffff",
      ),
    );
    widget.onSelectedResultListener?.call();
    setState(() {
      list.clear();
      list.addAll(resultList);
    });
  }
}
