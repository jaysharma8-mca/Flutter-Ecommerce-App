import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app/authentication/authentication_page.dart';
import 'package:flutter_ecommerce_app/config/config.dart';
import 'package:flutter_ecommerce_app/constants/constants.dart';
import 'package:flutter_ecommerce_app/store/store_home.dart';
import 'package:responsive_builder/responsive_builder.dart';

import 'orientation/screen_orientation.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    displaySplash();
  }

  displaySplash() {
    Timer(Duration(seconds: 3), () async {
      //Route route = MaterialPageRoute(builder: (_) => AuthenticationScreen());
      //Navigator.pushReplacement(context, route);
      if (EcommerceApp.auth.currentUser != null) {
        Route route = MaterialPageRoute(builder: (_) => StoreHome());
        Navigator.pushReplacement(context, route);
      } else {
        Route route = MaterialPageRoute(builder: (_) => AuthenticationScreen());
        Navigator.pushReplacement(context, route);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, size) {
        if (size.isMobile) return SplashScreenMobileView();
        return SplashScreenDesktopView();
      },
    );
  }
}

class SplashScreenMobileView extends StatefulWidget {
  @override
  _SplashScreenMobileViewState createState() => _SplashScreenMobileViewState();
}

class _SplashScreenMobileViewState extends State<SplashScreenMobileView> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return OrientationBuilder(
      builder: (context, orientation) {
        return orientation == Orientation.portrait
            ? Scaffold(
                body: PortraitMode(width: width, height: height),
              )
            : Scaffold(
                body: LandScapeMode(width: width, height: height),
              );
      },
    );
  }
}

class SplashScreenDesktopView extends StatefulWidget {
  @override
  _SplashScreenDesktopViewState createState() =>
      _SplashScreenDesktopViewState();
}

class _SplashScreenDesktopViewState extends State<SplashScreenDesktopView> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        decoration: kBoxDecoration,
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
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
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
            ],
          ),
        ),
      ),
    );
  }
}
