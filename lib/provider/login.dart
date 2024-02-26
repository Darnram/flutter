

import 'dart:convert';
import 'package:daram/controller/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../main.dart';
import '../models/user.dart';

Future<void> deleteAutoLogin() async{
  final UserController userController = Get.find<UserController>();
  final prefs = await SharedPreferences.getInstance();
  await prefs.remove('memUserId');
  await Future.value([
    prefs.remove('memberId'),
    prefs.remove('accessToken'),
    prefs.remove('refreshToken'),
    prefs.remove('nickname'),
    prefs.remove('email'),
    prefs.remove('img'),
    prefs.remove('pro'),
    prefs.remove('ban'),
  ]);
}
Future<void> deleteLoginMethod()async{
  final prefs = await SharedPreferences.getInstance();
  await prefs.remove('loginMethod');
}

Future<void> setLoginMethod({required String memUserId}) async {
  final prefs = await SharedPreferences.getInstance();
}
/// 자동 로그인 on / off 설정
Future<void> setAutoLogin({required bool autoLogin,required String memUserId, bool? isLogin}) async {
  final UserController userController = Get.find<UserController>();
  final prefs = await SharedPreferences.getInstance();
  await Future.value([
    prefs.setString('memberId','${userController.memberId.value}'),
    prefs.setString('accessToken','${userController.accessToken.value}'),
    prefs.setString('refreshToken','${userController.refreshToken.value}'),
    prefs.setString('nickname','${userController.nickname.value}'),
    prefs.setString('email','${userController.email.value}'),
    prefs.setString('img','${userController.img.value}'),
    prefs.setBool('pro',userController.pro.value),
    prefs.setBool('ban',userController.ban.value),
  ]);
}
Future<Map<String,String?>> getLoginInfo() async {
  final UserController userController = Get.find<UserController>();
  Map<String,String?> result = {};
  final prefs = await SharedPreferences.getInstance();
  if(prefs.getString('memberId') != ''){
    userController.memberId.value = int.parse(prefs.getString('memberId') ?? '0');
  userController.accessToken.value = prefs.getString('accessToken') ?? '';
  userController.refreshToken.value =  prefs.getString('refreshToken') ?? '';
  userController.nickname.value = prefs.getString('nickname') ?? '';
  userController.email.value = prefs.getString('email') ?? '';
  userController.img.value =  prefs.getString('img') ?? '';
  String? pro = prefs.getString('pro');
  if(pro == 'true'){

  }
  }
  return result;
}

Future<UserForm?> loginSignUp({required String data})async{
try{
  var url = Uri.parse('${dotenv.env['DARNRAM_URL']}/login/sign-up');
  debugPrint('API 주소 = $url');
  debugPrint('보내는 데이터 = ${data.runtimeType}');
  final postResponse = await http.post(url, headers: {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  },body: data);
  final body = postResponse.body;
  print('postResponse 값 = ${postResponse.statusCode}');

  if(postResponse.statusCode != 200){
    debugPrint('http 연결 문제');
    debugPrint('============= FAIL =============');
    return null;
  }else{
    /// 받아온 Api 데이터가 있을 경우
    if(body.isNotEmpty){
      var jsonBody = jsonDecode(body);
      print('jsonBody = $jsonBody');
      return UserForm.fromJson(jsonBody);
    }
    /// Todo : 모임 비어있을 경우 테스트 필요
    else{
      print('바디 비어있음');
      return null;
    }
  }
}catch(error){
  print('로그인 에러 뜸 =${error}');
  return null;
}

}