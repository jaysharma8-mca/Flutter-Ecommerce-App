import 'package:flutter/material.dart';

class OrientationLandScape extends StatelessWidget {
  const OrientationLandScape({
    Key key,
    @required double screenHeight,
    this.text,
    this.color,
  })  : _screenHeight = screenHeight,
        super(key: key);

  final double _screenHeight;
  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: color,
        fontWeight: FontWeight.bold,
        fontSize: _screenHeight * 0.040,
      ),
    );
  }
}

class OrientationPortrait extends StatelessWidget {
  const OrientationPortrait({
    Key key,
    @required double screenHeight,
    this.text,
    this.color,
  })  : _screenHeight = screenHeight,
        super(key: key);

  final double _screenHeight;
  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: color,
        fontWeight: FontWeight.bold,
        fontSize: _screenHeight * 0.025,
      ),
    );
  }
}
