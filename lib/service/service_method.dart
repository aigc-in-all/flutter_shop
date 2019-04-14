import 'package:dio/dio.dart';
import 'dart:async';
import 'dart:io';
import '../config/service_url.dart';

Future request(url, {formData}) async {
  print('开始获取数据: url=$url, params=$formData');
  try {
    Response response;
    Dio dio = new Dio();
    dio.options.contentType =
        ContentType.parse('application/x-www-form-urlencoded');
    if (formData == null) {
      response = await dio.post(servicePath[url]);
    } else {
      response = await dio.post(servicePath[url], data: formData);
    }
    if (response.statusCode == 200) {
      return response.data;
    } else {
      throw Exception('后端接口出现异常');
    }
  } catch (e) {
    return print('ERROR: ==============>$e');
  }
}

// 获取首页主体内容
Future getHomePageContent() async {
  print('开始获取首页数据...');
  try {
    Response response;
    Dio dio = new Dio();
    dio.options.contentType =
        ContentType.parse('application/x-www-form-urlencoded');
    var formData = {'lon': '115.02932', 'lat': '35.76189'};
    response = await dio.post(servicePath['homePageContent'], data: formData);
    if (response.statusCode == 200) {
      return response.data;
    } else {
      throw Exception('后端接口出现异常');
    }
  } catch (e) {
    return print('ERROR: ==============>$e');
  }
}

// 获取火爆专区端口
Future getHomePageBelowContent() async {
  print('开始获取火爆专区数据...');
  try {
    Response response;
    Dio dio = new Dio();
    dio.options.contentType =
        ContentType.parse('application/x-www-form-urlencoded');
    int page = 1;
    response = await dio.post(servicePath['homePageBelowContent'], data: page);
    if (response.statusCode == 200) {
      return response.data;
    } else {
      throw Exception('后端接口出现异常');
    }
  } catch (e) {
    return print('ERROR: ==============>$e');
  }
}
