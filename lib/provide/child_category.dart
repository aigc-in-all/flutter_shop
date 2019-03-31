import 'package:flutter/material.dart';
import '../model/category.dart';

class ChildCategory with ChangeNotifier {
  List<BxMallSubDto> childCategoryList = [];
  int childIndex = 0; // 子类高亮索引，默认全部
  String categoryId = '4'; // 大类别ID，默认白酒id
  String subId = ''; // 子类别Id

  // 切换大类别
  setChildCategory(List<BxMallSubDto> list, String id) {
    childIndex = 0; // 每次点击大类的时候都要把子类清0

    BxMallSubDto all = BxMallSubDto();
    all.mallSubId = '00';
    all.mallCategoryId = '00';
    all.comments = 'null';
    all.mallSubName = '全部';
    childCategoryList = [all];
    childCategoryList.addAll(list);
    notifyListeners();
  }

  // 改变子类索引
  changeChildIndex(index, String id) {
    childIndex = index;
    subId = id;
    notifyListeners();
  }
}
