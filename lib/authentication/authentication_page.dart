import 'package:flutter/material.dart';
import 'file:///C:/Users/jaysh/FlutterProjects/flutter_ecommerce_app/lib/authentication/loginpage/login_page.dart';
import 'file:///C:/Users/jaysh/FlutterProjects/flutter_ecommerce_app/lib/authentication/registerpage/register_page.dart';
import 'package:flutter_ecommerce_app/constants/constants.dart';

class AuthenticationScreen extends StatefulWidget {
  @override
  _AuthenticationScreenState createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends State<AuthenticationScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          flexibleSpace: Container(
            decoration: kBoxDecorationAppBar,
          ),
          title: Text(
            "e-Shop",
            style: TextStyle(
                fontSize: 55.0, color: Colors.white, fontFamily: "Signatra"),
          ),
          centerTitle: true,
          bottom: TabBar(
            tabs: [
              Tab(
                icon: Icon(
                  Icons.lock,
                  color: Colors.white,
                ),
                text: "Login",
              ),
              Tab(
                icon: Icon(
                  Icons.perm_contact_calendar,
                  color: Colors.white,
                ),
                text: "Register",
              ),
            ],
            indicatorColor: Colors.white38,
            indicatorWeight: 5.0,
          ),
        ),
        body: Container(
          decoration: kBoxDecoration,
          child: TabBarView(
            children: [
              LoginPage(),
              RegisterPage(),
            ],
          ),
        ),
      ),
    );
  }
}
