import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app/authentication/loginpage/desktopview/loginpagedesktopview.dart';
import 'package:flutter_ecommerce_app/authentication/loginpage/mobileview/loginpagemobileview.dart';
import 'package:responsive_builder/responsive_builder.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, size) {
        if (size.isMobile) return LoginPageMobileView();
        return LoginPageDesktopView();
      },
    );
  }
}
