import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app/admin/adminLogin.dart';
import 'package:flutter_ecommerce_app/config/config.dart';
import 'package:flutter_ecommerce_app/default_button/default_button_landscape_mode.dart';
import 'package:flutter_ecommerce_app/default_button/default_button_portrait_mode.dart';
import 'package:flutter_ecommerce_app/dialog_box/errorDialog.dart';
import 'package:flutter_ecommerce_app/dialog_box/loadingDialog.dart';
import 'package:flutter_ecommerce_app/orientation/imageorientation.dart';
import 'package:flutter_ecommerce_app/orientation/screen_orientation.dart';
import 'package:flutter_ecommerce_app/store/store_home.dart';
import 'package:flutter_ecommerce_app/widgets/customTextField.dart';

class LoginPageMobileView extends StatefulWidget {
  const LoginPageMobileView({
    Key key,
  }) : super(key: key);

  @override
  _LoginPageMobileViewState createState() => _LoginPageMobileViewState();
}

class _LoginPageMobileViewState extends State<LoginPageMobileView> {
  final TextEditingController _emailTextEditingController =
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
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              alignment: Alignment.bottomCenter,
              child: ImageSizeOrientation(
                orientation: orientation,
                screenWidthPortrait: _screenWidth * 0.55,
                screenWidthLandScape: _screenWidth * 0.45,
                image: "images/login.png",
              ),
            ),
            Padding(
                padding: EdgeInsets.all(8.0),
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
                    controller: _emailTextEditingController,
                    data: Icons.email,
                    hintText: "Email",
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
                      _emailTextEditingController.text.isNotEmpty &&
                              _passwordTextEditingController.text.isNotEmpty
                          ? loginUser()
                          : showDialog(
                              context: context,
                              builder: (c) {
                                return ErrorAlertDialog(
                                  message:
                                      "Please enter correct email and password",
                                );
                              });
                    },
                  )
                : DefaultButtonLandScapeMode(
                    screenWidth: _screenWidth,
                    screenHeight: _screenHeight,
                    text: "Login",
                    onPressed: () {
                      _emailTextEditingController.text.isNotEmpty &&
                              _passwordTextEditingController.text.isNotEmpty
                          ? loginUser()
                          : showDialog(
                              context: context,
                              builder: (c) {
                                return ErrorAlertDialog(
                                  message:
                                      "Please enter correct email and password",
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
                      return AdminSignInPage();
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
                      text: "I\'am Admin",
                      color: Color(0xff1e387d),
                    )
                  : OrientationLandScape(
                      screenHeight: _screenHeight,
                      text: "I\'am Admin",
                      color: Color(0xff1e387d),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  FirebaseAuth _auth = FirebaseAuth.instance;
  void loginUser() async {
    showDialog(
        context: context,
        builder: (c) {
          return LoadingAlertDialog(
            message: "Authenticating... Please Wait...",
          );
        });

    User firebaseUser;
    await _auth
        .signInWithEmailAndPassword(
      email: _emailTextEditingController.text.toString().trim(),
      password: _passwordTextEditingController.text.toString().trim(),
    )
        .then((authUser) {
      firebaseUser = authUser.user;
    }).catchError((error) {
      Navigator.pop(context);
      showDialog(
          context: context,
          builder: (c) {
            return ErrorAlertDialog(
              message: error.message.toString(),
            );
          });
    });
    if (firebaseUser != null) {
      readData(firebaseUser).then((s) {
        Navigator.pop(context);
        Route route = MaterialPageRoute(
          builder: (C) => StoreHome(),
        );
        Navigator.pushReplacement(context, route);
      });
    }
  }

  Future readData(User fUser) async {
    FirebaseFirestore.instance
        .collection("users")
        .doc(fUser.uid)
        .get()
        .then((dataSnapshot) async {
      await EcommerceApp.sharedPreferences.setString(
        EcommerceApp.userUID,
        dataSnapshot.data()[EcommerceApp.userUID],
      );

      await EcommerceApp.sharedPreferences.setString(
        EcommerceApp.userEmail,
        dataSnapshot.data()[EcommerceApp.userEmail],
      );

      await EcommerceApp.sharedPreferences.setString(
        EcommerceApp.userName,
        dataSnapshot.data()[EcommerceApp.userName],
      );

      await EcommerceApp.sharedPreferences.setString(
        EcommerceApp.userAvatarUrl,
        dataSnapshot.data()[EcommerceApp.userAvatarUrl],
      );

      List<String> cartList = dataSnapshot
          .data()[EcommerceApp.userCartList]
          .cast<String>() as List<String>;
      await EcommerceApp.sharedPreferences
          .setStringList(EcommerceApp.userCartList, cartList);
    });
  }
}
