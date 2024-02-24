import 'package:flutter/material.dart';

class UserForm {

  late final int memberId;
  late final String accessToken;
  late final String refreshToken;
  late final String nickname;
  late final String email;
  late final String img;
  late final bool pro;
  late final bool ban;

  UserForm(
      {required this.memberId,
      required  this.accessToken,
      required this.refreshToken,
      required this.nickname,
      required this.email,
      required this.img,
      required this.pro,
     required this.ban,
        });


  UserForm.fromJson(Map<String, dynamic>? map){
    memberId = map?['memberId'] ?? 0;
    accessToken = map?['accessToken'] ?? '';
    refreshToken = map?['refreshToken'] ?? '';
    nickname = map?['nickname'] ?? '';
    email = map?['email'] ?? '';
    img = map?['img'] ?? '';
    pro = map?['pro'] ?? false;
    ban = map?['ban'] ?? false;
  }
}
