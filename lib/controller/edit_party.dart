import 'package:daram/controller/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class EditPartyController extends GetxController {
  final Rx<int> partyId = 0.obs;
  final RxList<XFile?> img = <XFile?>[].obs;
  final Rx<String> title = ''.obs;
  final Rx<String> description = ''.obs;
  final Rx<String> password = ''.obs;
  final Rx<int> max = 0.obs;
  final Rx<String> location = ''.obs;
  final Rx<int> managerId = 0.obs;
  // final Rx<String> startAt = ''.obs;
  // final Rx<String> endAt = ''.obs;

  // int getTextLength(TextEditingController controller) {
  //   return controller.text.length;
  // }

  // bool getIsFilled(TextEditingController controller) {
  //   return controller.text.isNotEmpty;
  // }

  void increaseMax() {
    if (max.value < 10) {
      max.value += 1;
    }
  }

  void decreaseMax() {
    if (max.value > 0) {
      max.value -= 1;
    }
  }

  void clearEditParty() {
    partyId.value = 0;
    img.value = [];
    title.value = '';
    description.value = '';
    password.value = '';
    max.value = 0;
    location.value = '';
    managerId.value = 0;
  }

  void printAllNewParty() {
    print('partyId= ${partyId.value}');
    print('title ${title.value}');
    print('description ${description.value}');
    print('password ${password.value}');
    print('max ${max.value}');
    print('location ${location.value}');
    print('managerId ${managerId.value}');
  }

  bool checkNewParty() {
    if (partyId.value == 0 ||
        title.value == '' ||
        description.value == '' ||
        max.value == 0 ||
        location.value == '') {
      return false;
    } else {
      return true;
    }
  }
}
