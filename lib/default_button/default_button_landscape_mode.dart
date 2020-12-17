import 'package:flutter/material.dart';

class DefaultButtonLandScapeMode extends StatelessWidget {
  const DefaultButtonLandScapeMode({
    Key key,
    @required double screenWidth,
    @required double screenHeight,
    this.onPressed,
    this.text,
  })  : _screenWidth = screenWidth,
        _screenHeight = screenHeight,
        super(key: key);

  final double _screenWidth;
  final double _screenHeight;
  final Function onPressed;
  final String text;

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      padding: EdgeInsets.symmetric(
        horizontal: _screenWidth * 0.15,
        vertical: _screenHeight * 0.04,
      ),
      onPressed: onPressed,
      color: Color(0xff1e387d),
      child: Text(
        text,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: _screenHeight * 0.035,
        ),
      ),
    );
  }
}
