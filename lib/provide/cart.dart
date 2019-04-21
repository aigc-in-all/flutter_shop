import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_shop/model/cartInfo.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartProvide with ChangeNotifier {
  String cartString = '[]';

  List<CartInfoModel> cartList = [];

  double allPrice = 0; // 总价格
  int allGoodsCount = 0; // 商品总数量
  bool isAllCheck = true; // 是否全选

  save(goodsId, goodsName, count, price, images) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    cartString = sp.getString('cartInfo');
    var temp = cartString == null ? [] : json.decode(cartString.toString());
    List<Map> tempList = (temp as List).cast();

    bool isHave = false;
    int ival = 0;
    allPrice = 0;
    allGoodsCount = 0;
    tempList.forEach((item) {
      if (item['goodsId'] == goodsId) {
        tempList[ival]['count'] = item['count'] + 1;
        cartList[ival].count++;
        isHave = true;
      }
      if (item['isCheck']) {
        allPrice += (cartList[ival].price * cartList[ival].count);
        allGoodsCount += cartList[ival].count;
      }
      ival++;
    });

    if (!isHave) {
      Map<String, dynamic> newGoods = {
        'goodsId': goodsId,
        'goodsName': goodsName,
        'count': count,
        'price': price,
        'images': images,
        'isCheck': true,
      };
      tempList.add(newGoods);
      cartList.add(CartInfoModel.fromJson(newGoods));

      allPrice += (price * count);
      allGoodsCount += count;
    }

    cartString = json.encode(tempList).toString();
//    print(cartString);

    sp.setString('cartInfo', cartString);
    notifyListeners();
  }

  remove() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.remove('cartInfo');
    cartList.clear();
    print('清空完成');
    notifyListeners();
  }

  getCartInfo() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    cartString = sp.getString('cartInfo');
    cartList.clear();
    if (cartString == null) {
      cartList.clear();
    } else {
      List<Map> tempList = (json.decode(cartString.toString()) as List).cast();
      allPrice = 0;
      allGoodsCount = 0;
      isAllCheck = true;
      tempList.forEach((item) {
        if (item['isCheck']) {
          allPrice += (item['count'] * item['price']);
          allGoodsCount += item['count'];
        } else {
          isAllCheck = false;
        }
        cartList.add(CartInfoModel.fromJson(item));
      });
    }
    notifyListeners();
  }

  // 删除单个购物车商品
  deleteGoods(String goodsId) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    cartString = sp.getString('cartInfo');
    List<Map> tempList = (json.decode(cartString.toString()) as List).cast();
    int tempIndex = 0;
    int delIndex = -1;
    tempList.forEach((item) {
      if (item['goodsId'] == goodsId) {
        delIndex = tempIndex;
      }
      tempIndex++;
    });

    if (delIndex >= 0) {
      cartList.removeAt(delIndex);
      tempList.removeAt(delIndex);
      cartString = json.encode(tempList).toString();
      sp.setString('cartInfo', cartString);

      await getCartInfo();
      notifyListeners();
    }
  }

  changeCheckState(CartInfoModel cartItem) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    cartString = sp.getString('cartInfo');
    List<Map> tempList = (json.decode(cartString.toString()) as List).cast();
    int tempIndex = 0;
    int changeIndex = -1;
    tempList.forEach((item) {
      if (item['goodsId'] == cartItem.goodsId) {
        changeIndex = tempIndex;
      }
      tempIndex++;
    });
    tempList[changeIndex] = cartItem.toJson();
    cartString = json.encode(tempList).toString();
    sp.setString('cartInfo', cartString);
    await getCartInfo();
  }

  // 点击全选按钮操作
  changeAllCheckButtonState(bool isCheck) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    cartString = sp.getString('cartInfo');
    List<Map> tempList = (json.decode(cartString.toString()) as List).cast();
    List<Map> newList;
    tempList.forEach((item) {
      item['isCheck'] = isCheck;
    });
    cartString = json.encode(tempList).toString();
    sp.setString('cartInfo', cartString);
    await getCartInfo();
  }

  // 商品数量加减
  addOrReduceAction(CartInfoModel cartItem, bool add) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    cartString = sp.getString('cartInfo');
    List<Map> tempList = (json.decode(cartString.toString()) as List).cast();
    tempList.forEach((item) {
      if (item['goodsId'] == cartItem.goodsId) {
        if (add) {
          item['count'] += 1;
        } else {
          item['count'] -= 1;
        }
      }
    });
    cartString = json.encode(tempList).toString();
    sp.setString('cartInfo', cartString);
    await getCartInfo();
  }
}
