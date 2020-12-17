import 'package:flutter/material.dart';

class PortraitMode extends StatelessWidget {
  const PortraitMode({
    Key key,
    @required this.width,
    @required this.height,
  }) : super(key: key);

  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xffc1dde7),
            Color(0xff7ab5cb),
          ],
          begin: FractionalOffset(
            0.0,
            0.0,
          ),
          end: FractionalOffset(
            1.0,
            0.0,
          ),
          stops: [
            0.0,
            1.0,
          ],
          tileMode: TileMode.clamp,
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "images/welcome.png",
              width: width * 0.9,
            ),
            SizedBox(
              height: height * 0.07,
            ),
            Text(
              "Online Shoppee",
              style: TextStyle(
                fontSize: height * 0.05,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            //Spacer(),
            SizedBox(
              height: height * 0.02,
            ),
            Text(
              "V 1.0",
              style: TextStyle(
                fontSize: height * 0.02,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LandScapeMode extends StatelessWidget {
  const LandScapeMode({
    Key key,
    @required this.width,
    @required this.height,
  }) : super(key: key);

  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xffc1dde7),
            Color(0xff7ab5cb),
          ],
          begin: FractionalOffset(
            0.0,
            0.0,
          ),
          end: FractionalOffset(
            1.0,
            0.0,
          ),
          stops: [
            0.0,
            1.0,
          ],
          tileMode: TileMode.clamp,
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "images/welcome.png",
              width: width * 0.5,
            ),
            SizedBox(
              height: height * 0.05,
            ),
            Text(
              "Online Shoppee",
              style: TextStyle(
                fontSize: height * 0.08,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            //Spacer(),
            SizedBox(
              height: height * 0.02,
            ),
            Text(
              "V 1.0",
              style: TextStyle(
                fontSize: height * 0.03,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
