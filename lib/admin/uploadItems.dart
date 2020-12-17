import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app/admin/adminShiftOrders.dart';
import 'package:flutter_ecommerce_app/constants/constants.dart';
import 'package:flutter_ecommerce_app/splash_screen/splashScreen.dart';
import 'package:flutter_ecommerce_app/widgets/loadingWidget.dart';
import 'package:image_picker/image_picker.dart';

class UploadPage extends StatefulWidget {
  @override
  _UploadPageState createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage>
    with AutomaticKeepAliveClientMixin {
  bool get wantKeepAlive => true;

  final picker = ImagePicker();
  File file;
  TextEditingController _descriptionTextEditingController =
      TextEditingController();
  TextEditingController _priceTextEditingController = TextEditingController();
  TextEditingController _titleTextEditingController = TextEditingController();
  TextEditingController _shortTextEditingController = TextEditingController();
  String productId = DateTime.now().millisecondsSinceEpoch.toString();
  bool uploading = false;

  @override
  // ignore: must_call_super
  Widget build(BuildContext context) {
    return file == null
        ? displayAdminHomeScreen()
        : displayAdminUploadFromScreen();
  }

  displayAdminHomeScreen() {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: kBoxDecorationAppBar,
        ),
        leading: IconButton(
          icon: Icon(
            Icons.border_color,
            color: Colors.white,
          ),
          onPressed: () {
            Route route = MaterialPageRoute(
              builder: (c) => AdminShiftOrders(),
            );
            Navigator.pushReplacement(context, route);
          },
        ),
        actions: [
          FlatButton(
            onPressed: () {
              Route route = MaterialPageRoute(
                builder: (c) => SplashScreen(),
              );
              Navigator.pushReplacement(context, route);
            },
            child: Text(
              "Logout",
              style: TextStyle(
                color: kGenericColor,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          )
        ],
      ),
      body: getAdminHomeScreenBody(),
    );
  }

  getAdminHomeScreenBody() {
    return Container(
      decoration: kBoxDecoration,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.shop_two,
              color: Colors.white,
              size: 200.0,
            ),
            Padding(
              padding: EdgeInsets.only(top: 20.0),
              child: RaisedButton(
                onPressed: () {
                  takeImage(context);
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(9.0),
                ),
                child: Text(
                  "Add New Items",
                  style: TextStyle(fontSize: 20.0, color: Colors.white),
                ),
                color: kGenericColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  takeImage(mContext) {
    return showDialog(
      context: mContext,
      builder: (con) {
        return SimpleDialog(
          title: Column(
            children: [
              Row(
                //mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.image_search,
                    size: 40,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    "Item Image",
                    style: TextStyle(
                      color: kGenericColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 30.0,
                    ),
                  ),
                ],
              ),
              Divider(
                color: kGenericColor,
                indent: 5.0,
                endIndent: 5.0,
                thickness: 2.0,
              ),
            ],
          ),
          children: [
            SimpleDialogOption(
              child: Row(
                children: [
                  Icon(
                    Icons.camera_alt,
                    color: kGenericColor,
                    size: 30.0,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    "Capture with Camera",
                    style: TextStyle(
                      color: kGenericColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                    ),
                  ),
                ],
              ),
              onPressed: capturePhotoWithCamera,
            ),
            SimpleDialogOption(
              child: Row(
                children: [
                  Icon(
                    Icons.image,
                    color: kGenericColor,
                    size: 30.0,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    "Select from Gallery",
                    style: TextStyle(
                      color: kGenericColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                    ),
                  ),
                ],
              ),
              onPressed: selectPhotoFromGallery,
            ),
            SizedBox(
              height: 5.0,
            ),
            SimpleDialogOption(
              child: Align(
                alignment: Alignment.bottomRight,
                child: Icon(
                  Icons.cancel,
                  color: Colors.redAccent,
                  size: 30.0,
                ),
              ),
              /*Text(
                "Cancel",
                style: TextStyle(
                  color: kButtonColor,
                  fontWeight: FontWeight.bold,
                ),
              ),*/
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  capturePhotoWithCamera() async {
    Navigator.pop(context);
    final pickedFile = await picker.getImage(
      source: ImageSource.camera,
      maxHeight: 680.0,
      maxWidth: 970.0,
    );
    setState(() {
      if (pickedFile != null) {
        file = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  selectPhotoFromGallery() async {
    Navigator.pop(context);
    final pickedFile = await picker.getImage(
      source: ImageSource.gallery,
    );
    setState(() {
      if (pickedFile != null) {
        file = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  displayAdminUploadFromScreen() {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: kBoxDecorationAppBar,
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            clearFormInfo();
          },
        ),
        title: Text(
          "New Product",
          style: TextStyle(
            color: Colors.white,
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          FlatButton(
              onPressed: uploading ? null : () => uploadImageAndSaveItemInfo(),
              child: Text(
                "Add",
                style: TextStyle(
                  color: kGenericColor,
                  fontWeight: FontWeight.bold,
                ),
              ))
        ],
      ),
      body: ListView(
        children: [
          uploading ? linearProgress() : Text(""),
          Container(
            height: 230.0,
            width: MediaQuery.of(context).size.width * 0.8,
            child: Center(
              child: AspectRatio(
                aspectRatio: 15 / 9,
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: FileImage(file), fit: BoxFit.cover),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 12.0),
          ),
          ListTile(
            leading: Icon(
              Icons.perm_device_information,
              color: kGenericColor,
            ),
            title: Container(
              width: 250.0,
              child: TextField(
                style: TextStyle(
                  color: kGenericColor,
                ),
                controller: _shortTextEditingController,
                decoration: InputDecoration(
                  hintText: "Short Info",
                  hintStyle: TextStyle(
                    color: kGenericColor,
                  ),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          Divider(
            color: kGenericColor,
          ),
          ListTile(
            leading: Icon(
              Icons.title,
              color: kGenericColor,
            ),
            title: Container(
              width: 250.0,
              child: TextField(
                style: TextStyle(
                  color: kGenericColor,
                ),
                controller: _titleTextEditingController,
                decoration: InputDecoration(
                  hintText: "Title",
                  hintStyle: TextStyle(
                    color: kGenericColor,
                  ),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          Divider(
            color: kGenericColor,
          ),
          ListTile(
            leading: Icon(
              Icons.description,
              color: kGenericColor,
            ),
            title: Container(
              width: 250.0,
              child: TextField(
                style: TextStyle(
                  color: kGenericColor,
                ),
                controller: _descriptionTextEditingController,
                decoration: InputDecoration(
                  hintText: "Description",
                  hintStyle: TextStyle(
                    color: kGenericColor,
                  ),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          Divider(
            color: kGenericColor,
          ),
          ListTile(
            leading: Icon(
              Icons.monetization_on_outlined,
              color: kGenericColor,
            ),
            title: Container(
              width: 250.0,
              child: TextField(
                keyboardType: TextInputType.number,
                style: TextStyle(
                  color: kGenericColor,
                ),
                controller: _priceTextEditingController,
                decoration: InputDecoration(
                  hintText: "Price",
                  hintStyle: TextStyle(
                    color: kGenericColor,
                  ),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          Divider(
            color: kGenericColor,
          ),
        ],
      ),
    );
  }

  clearFormInfo() {
    setState(() {
      file = null;
      _descriptionTextEditingController.clear();
      _priceTextEditingController.clear();
      _shortTextEditingController.clear();
      _titleTextEditingController.clear();
    });
  }

  uploadImageAndSaveItemInfo() async {
    setState(() {
      uploading = true;
    });

    String imageDownloadUrl = await uploadItemImage(file);

    saveItemInfo(imageDownloadUrl);
  }

  Future<String> uploadItemImage(mFileImage) async {
    final StorageReference storageReference =
        FirebaseStorage.instance.ref().child("Items");
    StorageUploadTask storageUploadTask =
        storageReference.child("product_$productId.jpg").putFile(mFileImage);
    StorageTaskSnapshot taskSnapshot = await storageUploadTask.onComplete;
    String downloadUrl = await taskSnapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  saveItemInfo(String downloadUrl) {
    final itemRef = FirebaseFirestore.instance.collection("items");
    itemRef.doc(productId).set(
      {
        "shortInfo": _shortTextEditingController.text.trim(),
        "longDescription": _descriptionTextEditingController.text.trim(),
        "price": _priceTextEditingController.text.trim(),
        "publishedDate": DateTime.now(),
        "status": "available",
        "thumbnailUrl": downloadUrl,
        "title": _titleTextEditingController.text.trim(),
      },
    );
    setState(() {
      file = null;
      uploading = false;
      productId = DateTime.now().millisecondsSinceEpoch.toString();
      _descriptionTextEditingController.clear();
      _titleTextEditingController.clear();
      _shortTextEditingController.clear();
      _priceTextEditingController.clear();
    });
  }
}
