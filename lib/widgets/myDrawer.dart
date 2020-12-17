import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app/address/addAddress.dart';
import 'package:flutter_ecommerce_app/authentication/authentication_page.dart';
import 'package:flutter_ecommerce_app/config/config.dart';
import 'package:flutter_ecommerce_app/orders/myOrders.dart';
import 'package:flutter_ecommerce_app/store/Search.dart';
import 'package:flutter_ecommerce_app/store/cart.dart';
import 'package:flutter_ecommerce_app/store/store_home.dart';

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        child: ListView(
          children: [
            Container(
              padding: EdgeInsets.only(
                top: 25.0,
                bottom: 10.0,
              ),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xff7ab5cb),
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
              child: Column(
                children: [
                  Material(
                    borderRadius: BorderRadius.all(
                      Radius.circular(80.0),
                    ),
                    elevation: 8.0,
                    child: Container(
                      height: 160.0,
                      width: 160.0,
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(
                          EcommerceApp.sharedPreferences
                              .getString(EcommerceApp.userAvatarUrl),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    EcommerceApp.sharedPreferences
                        .getString(EcommerceApp.userName),
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 35.0,
                        fontFamily: "Signatra"),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 12.0,
            ),
            Container(
              padding: EdgeInsets.only(top: 1.0),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xff7ab5cb),
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
              child: Column(
                children: [
                  ListTile(
                    leading: Icon(
                      Icons.home,
                      color: Colors.white,
                    ),
                    title: Text(
                      "Home",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    onTap: () {
                      Route route = MaterialPageRoute(builder: (c) {
                        return StoreHome();
                      });
                      Navigator.pushReplacement(context, route);
                    },
                  ),
                  Divider(
                    height: 10.0,
                    color: Colors.white,
                    thickness: 6.0,
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.bookmark_border,
                      color: Colors.white,
                    ),
                    title: Text(
                      "My Orders",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    onTap: () {
                      Route route = MaterialPageRoute(builder: (c) {
                        return MyOrders();
                      });
                      Navigator.pushReplacement(context, route);
                    },
                  ),
                  Divider(
                    height: 10.0,
                    color: Colors.white,
                    thickness: 6.0,
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.shopping_cart,
                      color: Colors.white,
                    ),
                    title: Text(
                      "My Cart",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    onTap: () {
                      Route route = MaterialPageRoute(builder: (c) {
                        return CartPage();
                      });
                      Navigator.pushReplacement(context, route);
                    },
                  ),
                  Divider(
                    height: 10.0,
                    color: Colors.white,
                    thickness: 6.0,
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.search,
                      color: Colors.white,
                    ),
                    title: Text(
                      "Search",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    onTap: () {
                      Route route = MaterialPageRoute(builder: (c) {
                        return SearchProduct();
                      });
                      Navigator.pushReplacement(context, route);
                    },
                  ),
                  Divider(
                    height: 10.0,
                    color: Colors.white,
                    thickness: 6.0,
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.home_work_outlined,
                      color: Colors.white,
                    ),
                    title: Text(
                      "Add New Address",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    onTap: () {
                      Route route = MaterialPageRoute(builder: (c) {
                        return AddAddress();
                      });
                      Navigator.pushReplacement(context, route);
                    },
                  ),
                  Divider(
                    height: 10.0,
                    color: Colors.white,
                    thickness: 6.0,
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.logout,
                      color: Colors.white,
                    ),
                    title: Text(
                      "Logout",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    onTap: () {
                      EcommerceApp.auth.signOut().then((c) {
                        Route route = MaterialPageRoute(builder: (c) {
                          return AuthenticationScreen();
                        });
                        Navigator.pushReplacement(context, route);
                      });
                    },
                  ),
                  Divider(
                    height: 10.0,
                    color: Colors.white,
                    thickness: 6.0,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
