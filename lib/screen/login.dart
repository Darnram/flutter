import 'package:daram/constants/Gaps.dart';
import 'package:daram/constants/sizes.dart';
import 'package:daram/screen/home/home.dart';
import 'package:daram/screen/home/webViewScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants/Colors.dart';
import '../constants/Images.dart';
import '../widgets/authentication/social_login.dart';
import '../widgets/authentication/widgets/loginButton.dart';

enum Login { apple, kakao, naver }

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                IMAGES.loginLogo,
              ),
              Gaps.v10,
              Image.asset(
                IMAGES.loginLogoText,
              ),
              Gaps.v16,
              const Text(
                '단체알람 & 커뮤니티',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                  color: COLORS.defaultGrey,
                ),
              )
            ],
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          height: 180,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Gaps.h10,
                  LoginButton(
                      loginBtnImg: IMAGES.loginAppleBtn, login: Login.apple),
                  LoginButton(
                      loginBtnImg: IMAGES.loginKakaoBtn, login: Login.kakao),
                  LoginButton(
                      loginBtnImg: IMAGES.loginNaverBtn, login: Login.naver),
                  Gaps.h10,
                ],
              ),
              Gaps.v16,
              const Text(
                'SNS 계정으로 로그인',
                style: TextStyle(fontSize: 17, color: COLORS.defaultGrey),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const WebViewScreen(
                          url:
                              'https://sites.google.com/view/danram/%ED%99%88'),
                    ),
                  );
                },
                child: const Text(
                  '개인정보처리방침',
                  style: TextStyle(decoration: TextDecoration.underline),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
