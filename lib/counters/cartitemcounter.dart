import 'package:flutter/foundation.dart';
import 'package:flutter_ecommerce_app/config/config.dart';

class CartItemCounter extends ChangeNotifier {
  int _counter = EcommerceApp.sharedPreferences
          .getStringList(EcommerceApp.userCartList)
          .length -
      1;
  int get count => _counter;
}
