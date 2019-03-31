import 'package:flutter/material.dart';
import '../model/categoryGoodsList.dart';

class CategoryGoodsListProvide with ChangeNotifier {
  List<CategoryListData> goodsList = [];

  // 点击大类时更换商品列表
  setGoodsList(List<CategoryListData> list) {
    goodsList = list;
    notifyListeners();
  }

  setMoreGoodsList(List<CategoryListData> list) {
    goodsList.addAll(list);
    notifyListeners();
  }
}
