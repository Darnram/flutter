import 'package:daram/controller/party.dart';
import 'package:daram/provider/login.dart';
import 'package:daram/widgets/authentication/social_login.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants/sizes.dart';
import '../../../provider/party.dart';
import '../../../screen/home/home.dart';
import '../../../screen/login.dart';

class LoginButton extends StatelessWidget {
  LoginButton({
    super.key,
    required this.loginBtnImg, required this.login
  });
  final String loginBtnImg;
  final Login login;

  @override
  Widget build(BuildContext context) {
    Get.put(PartyController());
    return GestureDetector(
      onTap:() async{
        print('네이버 로그인 버튼 클릭');
        await socialLogin(context: context, loginType: login).then((value)async{
          print('value = $value');
          setAutoLogin();
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomeScreen()));
        });
      },
      child: Container(
        child: Image.asset(loginBtnImg,height: Sizes.size64 ,width: Sizes.size64),
      ),
    );
  }
}
