import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app/admin/uploadItems.dart';
import 'package:flutter_ecommerce_app/authentication/authentication_page.dart';
import 'package:flutter_ecommerce_app/constants/constants.dart';
import 'package:flutter_ecommerce_app/default_button/default_button_landscape_mode.dart';
import 'package:flutter_ecommerce_app/default_button/default_button_portrait_mode.dart';
import 'package:flutter_ecommerce_app/dialog_box/errorDialog.dart';
import 'package:flutter_ecommerce_app/dialog_box/loadingDialog.dart';
import 'package:flutter_ecommerce_app/orientation/imageorientation.dart';
import 'package:flutter_ecommerce_app/orientation/screen_orientation.dart';
import 'package:flutter_ecommerce_app/widgets/customTextField.dart';
import 'package:responsive_builder/responsive_builder.dart';

class AdminSignInPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, size) {
        if (size.isMobile) return AdminSignInPageMobileView();
        return Container();
      },
    );
  }
}

class AdminSignInPageMobileView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      ),
      body: AdminSignInScreen(),
    );
  }
}

class AdminSignInScreen extends StatefulWidget {
  @override
  _AdminSignInScreenState createState() => _AdminSignInScreenState();
}

class _AdminSignInScreenState extends State<AdminSignInScreen> {
  final TextEditingController _adminIDTextEditingController =
      TextEditingController();
  final TextEditingController _passwordTextEditingController =
      TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    double _screenHeight = MediaQuery.of(context).size.height;
    double _screenWidth = MediaQuery.of(context).size.width;
    final orientation = MediaQuery.of(context).orientation;
    return SingleChildScrollView(
      child: Container(
        decoration: kBoxDecoration,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            SizedBox(
              height: _screenHeight * 0.02,
            ),
            ImageSizeOrientation(
              orientation: orientation,
              screenWidthPortrait: _screenWidth * 0.85,
              screenWidthLandScape: _screenWidth * 0.55,
              image: "images/admin.png",
            ),
            SizedBox(
              height: _screenHeight * 0.01,
            ),
            Padding(
                padding: EdgeInsets.all(10.0),
                child: orientation == Orientation.portrait
                    ? OrientationPortrait(
                        screenHeight: _screenHeight,
                        text: "Login to your account",
                        color: Colors.white,
                      )
                    : OrientationLandScape(
                        screenHeight: _screenHeight,
                        text: "Login to your account",
                        color: Colors.white,
                      )),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  CustomTextField(
                    controller: _adminIDTextEditingController,
                    data: Icons.email,
                    hintText: "Username",
                    isObscure: false,
                  ),
                  CustomTextField(
                    controller: _passwordTextEditingController,
                    data: Icons.person,
                    hintText: "Password",
                    isObscure: true,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: _screenHeight * 0.03,
            ),
            orientation == Orientation.portrait
                ? DefaultButtonPortraitMode(
                    screenWidth: _screenWidth,
                    screenHeight: _screenHeight,
                    text: "Login",
                    onPressed: () {
                      _adminIDTextEditingController.text.isNotEmpty &&
                              _passwordTextEditingController.text.isNotEmpty
                          ? loginAdmin()
                          : showDialog(
                              context: context,
                              builder: (c) {
                                return ErrorAlertDialog(
                                  message:
                                      "Please enter correct username and password",
                                );
                              });
                    },
                  )
                : DefaultButtonLandScapeMode(
                    screenWidth: _screenWidth,
                    screenHeight: _screenHeight,
                    text: "Login",
                    onPressed: () {
                      _adminIDTextEditingController.text.isNotEmpty &&
                              _passwordTextEditingController.text.isNotEmpty
                          ? loginAdmin()
                          : showDialog(
                              context: context,
                              builder: (c) {
                                return ErrorAlertDialog(
                                  message:
                                      "Please enter correct username and password",
                                );
                              });
                    },
                  ),
            SizedBox(
              height: 50.0,
            ),
            Container(
              height: _screenHeight * 0.002,
              width: _screenWidth * 0.8,
              color: Color(0xff1e387d),
            ),
            FlatButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return AuthenticationScreen();
                    },
                  ),
                );
              },
              icon: (Icon(
                Icons.nature_people,
                color: Color(0xff1e387d),
                size: _screenHeight * 0.04,
              )),
              label: orientation == Orientation.portrait
                  ? OrientationPortrait(
                      screenHeight: _screenHeight,
                      text: "I\'am not Admin",
                      color: Color(0xff1e387d),
                    )
                  : OrientationLandScape(
                      screenHeight: _screenHeight,
                      text: "I\'am not Admin",
                      color: Color(0xff1e387d),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  loginAdmin() {
    FirebaseFirestore.instance.collection("admins").get().then((snapshot) {
      snapshot.docs.forEach((result) {
        if (result.data()["id"] !=
            _adminIDTextEditingController.text.toString().trim()) {
          Scaffold.of(context).showSnackBar(
            SnackBar(
              content: Text("Invalid Username"),
            ),
          );
        } else if (result.data()["password"] !=
            _passwordTextEditingController.text.toString().trim()) {
          Scaffold.of(context).showSnackBar(
            SnackBar(
              content: Text("Invalid Password"),
            ),
          );
        } else {
          showDialog(
              context: context,
              builder: (c) {
                return LoadingAlertDialog(
                  message: "Authentication... Please Wait...",
                );
              });
          /*Scaffold.of(context).showSnackBar(
            SnackBar(
              content: Text(
                "Welcome" + result.data()["name"],
              ),
            ),
          );*/
          setState(() {
            _adminIDTextEditingController.text = "";
            _passwordTextEditingController.text = "";
          });
          Route route = MaterialPageRoute(
            builder: (c) => UploadPage(),
          );
          Navigator.pushReplacement(
            context,
            route,
          );
        }
      });
    });
  }
}
