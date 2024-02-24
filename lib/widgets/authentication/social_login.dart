
import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_naver_login/flutter_naver_login.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart' as kakao;
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter_web_auth/flutter_web_auth.dart';

import '../../controller/user.dart';
import '../../main.dart';
import '../../models/user.dart';
import '../../provider/login.dart';
import '../../screen/login.dart';

enum SNS {apple, naver, kakao}

/// 로그인 Dep 2
Future<bool?> socialLogin({required Login loginType, required BuildContext context/*, required AppLocation location*/}) async {

  bool? loginSuccess = true;


  /// 로그인 Process 2-1
  switch(loginType){
    case Login.apple:

      break;
    case Login.naver:
      print('네이버 케이스');
      try{
        final NaverLoginResult result = await FlutterNaverLogin.logIn();
        print('결과 값 토큰=${result.accessToken}');
        if (result.status == NaverLoginStatus.loggedIn) {
          print('accessToken = ${result.accessToken}');
          print('id = ${result.account.id}');

          final data ={
            "email": result.account.email,
            "nickname": result.account.nickname,
            "profileImg": result.account.profileImage,
            "loginType": 2
          };
          print('네이버 받아온 데이터 = $data');
          final jsonData = jsonEncode(data);
          print('loginSignUp 시작함');
          final UserController userController = Get.put(UserController());
          final userData = await loginSignUp(data: jsonData);
          if(userData != null){
            userController.fetchUser(userForm: userData) ;
            userController.showUser();
          }
          print('loginSignUp 종료함');
        }
      }catch(error){
        print('에러 = $error');
        if (error is PlatformException && error.code == 'CANCELED') {
          return null;
        }
        debugPrint(error.toString());
        loginSuccess = null;
        return null;
      }
    case Login.kakao:
      print('카카오톡 버튼 클릭');
      try{
        final kakao.User? user = await KakaoSignIn();
        if (user == null) {
          print(' 유저 정보 없음');
        }
      }catch(error){
        print('error = $error');
      }
  }
  return loginSuccess;
}


Future<kakao.User?> KakaoSignIn() async {
  kakao.User? user;
  if (await kakao.isKakaoTalkInstalled()) {
    print('카카오톡 설치됨');
    try {
      await kakao.UserApi.instance.loginWithKakaoTalk();
      print('카톡 로그인 진행함');
      print('카카오톡 로그인 진행');
      user = await kakao.UserApi.instance.me();
      print('유저 정보 = $user');

    } catch (error) {
      debugPrint('카카오톡으로 로그인 실패 $error');

      // 사용자가 카카오톡 설치 후 디바이스 권한 요청 화면에서 로그인을 취소한 경우,
      // 의도적인 로그인 취소로 보고 카카오계정으로 로그인 시도 없이 로그인 취소로 처리 (예: 뒤로 가기)
      if (error is PlatformException && error.code == 'CANCELED') {
        return null;
      }
      // 카카오톡에 연결된 카카오계정이 없는 경우, 카카오계정으로 로그인
      try {
        print('카카오톡 로그인 다른걸로 진행');
        await kakao.UserApi.instance.loginWithKakaoAccount();
        print('카카오톡 로그인 진행');
        user = await kakao.UserApi.instance.me();
        print('유저 정보 = $user');
      } catch (error) {
        debugPrint('카카오계정으로 로그인 실패 $error');
      }
    }
  } else {
    print('카카오톡 설치 안되어 있음');
    try {
      print('카톡 로그인 시작');
      await kakao.UserApi.instance.loginWithKakaoAccount().then((value){
        print('토큰 value = $value');
      });
      print('카톡 로그인 진행함');
      final UserController userController = Get.put(UserController());
      user = await kakao.UserApi.instance.me();
      print('유저 정보 = $user');
      final Map<String,dynamic> data =
      {
        "email": user.kakaoAccount?.email,
        "nickname": user.properties?['nickname'] ?? user.kakaoAccount?.profile?.nickname,
        "profileImg": user.properties?['profile_image'] ?? user.kakaoAccount?.profile?.profileImageUrl,
        "loginType": 1,
      };
      final userData = await loginSignUp(data: jsonEncode(data));
      if(userData != null){
        userController.fetchUser(userForm: userData) ;
        userController.showUser();
      }

    } catch (error ) {
/*      print('ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ');
      print(await KakaoSdk.origin);
      print('ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ');*/
      debugPrint('error = ${error.runtimeType}');
      debugPrint('error = $error');

if(error is PlatformException){

        print('에로코드 = ${error.code}');
      }
      if (error is PlatformException && error.code == 'CANCELED') {
print('카카오톡 로그인 취소 누름');
        return null;
      }
      //userController.loginCancelBtn.value = true;
      return null;
    }
  }
  return user;
}


String truncateString({required String data,required  int length}) {
  return (data.length >= length) ? '${data.substring(0, length)}...' : data;
}

enum ErrorCase {login, update, delete, post}

String errorString({required ErrorCase errorCase}){
  String result = '';
  switch(errorCase){
    case ErrorCase.login:
      result = '로그인';
      break;
    case ErrorCase.update:
      result = '저장';
      break;
    case ErrorCase.delete:
      result = '탈퇴';
      break;
    case ErrorCase.post:
      result = '요청';
      break;
  }
  return result;
}

void errorDialog({required BuildContext context,required  ErrorCase? errorCase, required String stringOfLocation}){

  print('에러나는 위치 = $stringOfLocation');
  if(errorCase == null){
    print('에러 케이스가 널 ');
    return;
  }
  final String msg = errorString(errorCase: errorCase);
  showDialog(context: context, builder: (BuildContext context){
    return AlertDialog(
      actions: [
        TextButton(
          child: const Text('확인', style:TextStyle(color:Colors.black)),
          onPressed: (){
            Navigator.of(context).pop();
          },
        )
      ],
      title: const Text('알림'),
      content: SingleChildScrollView(
        child: ListBody(
          children: [
            Text('$msg에 실패했습니다.\n재차 $msg 실패 시 아래 고객센터로 문의하시기 바랍니다.\n'),
            InkWell(onTap: (){
              //sendEmail(context: context);
            },
                child:const Text('', style:TextStyle(color:Colors.blue)))
          ],
        ),
      ),
    );
  });
}
