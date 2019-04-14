import 'package:flutter/material.dart';
import 'package:flutter_shop/provide/details_info.dart';
import 'package:provide/provide.dart';

class DetailsPage extends StatelessWidget {
  final String goodsId;

  DetailsPage({this.goodsId});
  @override
  Widget build(BuildContext context) {
    getBackInfo(context);
    return Container(
      child: Center(
        child: Text('商品ID: $goodsId'),
      ),
    );
  }

  void getBackInfo(BuildContext context) async {
    await Provide.value<DetailsInfoProvide>(context).getGoodsInfo(goodsId);
    print('加载完成');
  }
}
