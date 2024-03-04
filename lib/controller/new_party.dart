import 'package:daram/controller/user.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class NewPartyController extends GetxController{
  final Rx<String> title = ''.obs;
  final Rx<String> description = ''.obs;
  final Rx<String> password = ''.obs;
  final Rx<int> partyType = 0.obs;
  final Rx<int> max = 0.obs;
  final Rx<String> location = ''.obs;
  final Rx<String> memberEmail = ''.obs;
  final Rx<String> startAt = '2022-02-20'.obs;
  final Rx<String> endAt = '2022-02-22'.obs;
  final RxList<XFile?> newImage = <XFile?>[].obs;
  //Rx<int> selectedCategory = 0.obs;

  void increaseMax(){
    if(max.value <10){
      max.value += 1;
    }
  }
  void decreaseMax(){
    if(max.value > 0){
      max.value -= 1;
    }
  }

  void clearNewParty(){
    title.value = '';
    description.value = '';
    password.value = '';
    partyType.value = 0;
    max.value = 0;
    location.value = '';
    memberEmail.value = '';
    startAt.value = '2022-02-20';
    endAt.value = '2022-02-22';
    newImage.value = [];
  }
  void printAllNewParty(){
    print('newImage.value = ${newImage}');
    print('title.value = ${title.value}');
    print('description.value = ${description.value}');
    print('password.value = ${password.value}');
    print('partyType.value = ${partyType.value}');
    print('max.value = ${max.value}');
    print('location.value = ${location.value}');
    print('memberEmail.value = ${memberEmail.value}');
     print('startAt.value = ${startAt.value}');
    print('endAt.value = ${endAt.value}');
  }
  bool checkNewParty(){
    if(
    newImage.isEmpty ||
    title.value == '' ||
    description.value == '' ||
    partyType.value == 0 ||
    max.value == 0 ||
    location.value == '' /*||
    startAt.value == '' ||
    endAt.value == ''*/){
      return false;
    }else{
      final UserController userController = Get.find<UserController>();
      memberEmail.value = userController.email.value;
      return true;
    }

  }
}
