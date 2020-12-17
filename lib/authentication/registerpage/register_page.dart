import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app/config/config.dart';
import 'package:flutter_ecommerce_app/default_button/default_button_landscape_mode.dart';
import 'package:flutter_ecommerce_app/default_button/default_button_portrait_mode.dart';
import 'package:flutter_ecommerce_app/dialog_box/errorDialog.dart';
import 'package:flutter_ecommerce_app/dialog_box/loadingDialog.dart';
import 'package:flutter_ecommerce_app/store/store_home.dart';
import 'package:flutter_ecommerce_app/widgets/customTextField.dart';
import 'package:image_picker/image_picker.dart';
import 'package:responsive_builder/responsive_builder.dart';

class RegisterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, size) {
        if (size.isMobile) return RegisterPageMobileView();
        return Container();
      },
    );
  }
}

class RegisterPageMobileView extends StatefulWidget {
  @override
  _RegisterPageMobileViewState createState() => _RegisterPageMobileViewState();
}

class _RegisterPageMobileViewState extends State<RegisterPageMobileView> {
  final TextEditingController _nameTextEditingController =
      TextEditingController();
  final TextEditingController _emailTextEditingController =
      TextEditingController();
  final TextEditingController _passwordTextEditingController =
      TextEditingController();
  final TextEditingController _cPasswordTextEditingController =
      TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String userImageUrl = "";
  File _imageFile;
  final picker = ImagePicker();

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
            SizedBox(
              height: _screenHeight * 0.04,
            ),
            InkWell(
              onTap: getImage,
              child: orientation == Orientation.portrait
                  ? CircleAvatar(
                      radius: _screenWidth * 0.15,
                      backgroundColor: Colors.white,
                      backgroundImage:
                          _imageFile == null ? null : FileImage(_imageFile),
                      child: _imageFile == null
                          ? Icon(
                              Icons.add_photo_alternate,
                              size: _screenWidth * 0.15,
                              color: Colors.grey,
                            )
                          : null,
                    )
                  : CircleAvatar(
                      radius: _screenWidth * 0.10,
                      backgroundColor: Colors.white,
                      backgroundImage:
                          _imageFile == null ? null : FileImage(_imageFile),
                      child: _imageFile == null
                          ? Icon(
                              Icons.add_photo_alternate,
                              size: _screenWidth * 0.10,
                              color: Colors.grey,
                            )
                          : null,
                    ),
            ),
            SizedBox(
              height: _screenHeight * 0.03,
            ),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  CustomTextField(
                    controller: _nameTextEditingController,
                    data: Icons.person,
                    hintText: "Name",
                    isObscure: false,
                  ),
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
                  CustomTextField(
                    controller: _cPasswordTextEditingController,
                    data: Icons.person,
                    hintText: "Confirm Password",
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
                    text: "Register",
                    onPressed: () {
                      uploadAndSaveImage();
                    },
                  )
                : DefaultButtonLandScapeMode(
                    screenWidth: _screenWidth,
                    screenHeight: _screenHeight,
                    text: "Register",
                    onPressed: () {
                      uploadAndSaveImage();
                    },
                  ),
            SizedBox(
              height: 30.0,
            ),
            Container(
              height: _screenHeight * 0.002,
              width: _screenWidth * 0.8,
              color: Color(0xff1e387d),
            ),
            SizedBox(
              height: 15.0,
            ),
          ],
        ),
      ),
    );
  }

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _imageFile = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Future<void> uploadAndSaveImage() async {
    if (_imageFile == null) {
      showDialog(
          context: context,
          builder: (c) {
            return ErrorAlertDialog(
              message: "Please select an image.",
            );
          });
    } else {
      _passwordTextEditingController.text.toString() ==
              _cPasswordTextEditingController.text.toString()
          ? _emailTextEditingController.text.toString().isNotEmpty &&
                  _passwordTextEditingController.text.toString().isNotEmpty &&
                  _cPasswordTextEditingController.text.toString().isNotEmpty &&
                  _nameTextEditingController.text.toString().isNotEmpty
              ? uploadToStorage()
              : displayDialog("Please fill up the complete registration form")
          : displayDialog("Password does not match");
    }
  }

  uploadToStorage() async {
    showDialog(
        context: context,
        builder: (c) {
          return LoadingAlertDialog(
            message: "Registering... Please Wait...",
          );
        });
    String imageFileName = DateTime.now().millisecondsSinceEpoch.toString();
    StorageReference storageReference =
        FirebaseStorage.instance.ref().child(imageFileName);
    StorageUploadTask storageUploadTask = storageReference.putFile(_imageFile);
    StorageTaskSnapshot taskSnapshot = await storageUploadTask.onComplete;
    await taskSnapshot.ref.getDownloadURL().then((urlImage) {
      userImageUrl = urlImage;

      _registerUser();
    });
  }

  FirebaseAuth _auth = FirebaseAuth.instance;
  void _registerUser() async {
    User firebaseUser;
    await _auth
        .createUserWithEmailAndPassword(
      email: _emailTextEditingController.text.toString().trim(),
      password: _passwordTextEditingController.text.toString().trim(),
    )
        .then((auth) {
      firebaseUser = auth.user;
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
      saveUserInfoToFireStore(firebaseUser).then((value) {
        Navigator.pop(context);
        Route route = MaterialPageRoute(
          builder: (C) => StoreHome(),
        );
        Navigator.pushReplacement(context, route);
      });
    }
  }

  Future saveUserInfoToFireStore(User fUser) async {
    FirebaseFirestore.instance.collection("users").doc(fUser.uid).set({
      "uid": fUser.uid,
      "email": fUser.email,
      "name": _nameTextEditingController.text.toString().trim(),
      "url": userImageUrl,
      EcommerceApp.userCartList: ["garbageValue"],
    });

    await EcommerceApp.sharedPreferences
        .setString(EcommerceApp.userUID, fUser.uid);
    await EcommerceApp.sharedPreferences
        .setString(EcommerceApp.userEmail, fUser.email);
    await EcommerceApp.sharedPreferences.setString(EcommerceApp.userName,
        _nameTextEditingController.text.toString().trim());
    await EcommerceApp.sharedPreferences
        .setString(EcommerceApp.userAvatarUrl, userImageUrl);
    await EcommerceApp.sharedPreferences
        .setStringList(EcommerceApp.userCartList, ["garbageValue"]);
  }

  displayDialog(String msg) {
    showDialog(
        context: context,
        builder: (c) {
          return ErrorAlertDialog(
            message: "msg",
          );
        });
  }
}
