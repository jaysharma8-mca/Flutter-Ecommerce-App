import 'package:flutter/material.dart';

class ImageSizeOrientation extends StatelessWidget {
  final Orientation orientation;
  final double screenWidthPortrait;
  final double screenWidthLandScape;
  final String image;

  const ImageSizeOrientation(
      {Key key,
      this.orientation,
      this.screenWidthPortrait,
      this.screenWidthLandScape,
      this.image})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomCenter,
      child: orientation == Orientation.portrait
          ? Image.asset(
              image,
              width: screenWidthPortrait,
            )
          : Image.asset(
              image,
              width: screenWidthLandScape,
            ),
    );
  }
}
