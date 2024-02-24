import 'package:flutter/material.dart';
import 'package:flutter_naver_login/flutter_naver_login.dart';

Widget _logoutButton() {
  return ElevatedButton(
    onPressed: ()async{
      await FlutterNaverLogin.logOut();
    },
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all(
        const Color(0xff0165E1),
      ),
    ),
    child: const Text('로그아웃'),
  );
}