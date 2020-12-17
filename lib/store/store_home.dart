import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app/counters/cartitemcounter.dart';
import 'package:flutter_ecommerce_app/widgets/myDrawer.dart';
import 'package:provider/provider.dart';

import 'cart.dart';

class StoreHome extends StatefulWidget {
  @override
  _StoreHomeState createState() => _StoreHomeState();
}

class _StoreHomeState extends State<StoreHome> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
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
        ),
        title: Text(
          "e-Shop",
          style: TextStyle(
              fontSize: 55.0, color: Colors.white, fontFamily: "Signatra"),
        ),
        centerTitle: true,
        actions: [
          Stack(
            children: [
              IconButton(
                icon: Icon(Icons.shopping_cart),
                color: Color(0xff1e387d),
                onPressed: () {
                  Route route = MaterialPageRoute(builder: (c) => CartPage());
                  Navigator.pushReplacement(context, route);
                },
              ),
              Positioned(
                child: Stack(
                  children: [
                    Icon(
                      Icons.brightness_1,
                      size: 20.0,
                      color: Colors.green,
                    ),
                    Positioned(
                      top: 3.0,
                      bottom: 4.0,
                      child: Consumer<CartItemCounter>(
                        builder: (context, counter, _) {
                          return Text(
                            counter.count.toString(),
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12.0,
                              fontWeight: FontWeight.w500,
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      drawer: MyDrawer(),
    );
  }
}
