import 'package:daram/models/user.dart';
import 'package:get/get.dart';

class UserController extends GetxController{

  final Rx<int> memberId = 0.obs;
  final Rx<String> accessToken = ''.obs;
  final Rx<String> refreshToken = ''.obs;
  final Rx<String> nickname = ''.obs;
  final Rx<String> email = ''.obs;
  final Rx<String> img = ''.obs;
  final Rx<bool> pro = false.obs;
  final Rx<bool> ban = false.obs;


  void fetchUser({required UserForm userForm}){
    memberId.value = userForm.memberId;
    accessToken.value = userForm.accessToken;
    refreshToken.value = userForm.refreshToken;
    nickname.value = userForm.nickname;
    email.value = userForm.email;
    img.value = userForm.img;
    pro.value = userForm.pro;
    ban.value = userForm.ban;
  }

  void showUser(){
print('memberId = $memberId');
print('accessToken = $accessToken');
print('refreshToken = $refreshToken');
print('nickname = $nickname');
print('email = $email');
print('img = $img');
print('pro = $pro');
print('ban = $ban');
  }

}