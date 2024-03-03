import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PostController extends GetxController {
  // late TextEditingController controller;
  // var isFilled = false.obs;
  // var textLength = 0.obs;

  final Map<String, TextEditingController> controllers = {};
  final Map<String, RxBool> isFilled = {};
  final Map<String, RxInt> textLength = {};

  TextEditingController getController(String id) {
    if (!controllers.containsKey(id)) {
      controllers[id] = TextEditingController();
      isFilled[id] = false.obs;
      textLength[id] = 0.obs;

      controllers[id]!.addListener(() {
        textLength[id]!.value = controllers[id]!.text.length;
        isFilled[id]!.value = controllers[id]!.text.isNotEmpty;
      });
    }

    return controllers[id]!;
  }

  int getTextLength(String id) {
    return textLength[id]!.value;
  }

  bool getIsFilled(String id) {
    return isFilled[id]!.value;
  }

  @override
  void onClose() {
    for (var controller in controllers.values) {
      controller.dispose();
    }
    super.onClose();
  }

  // @override
  // void onInit() {
  //   super.onInit();
  //   controller = TextEditingController();

  //   controller.addListener(() {
  //     textLength.value = controller.text.length;
  //     if (controller.text.isEmpty) {
  //       isFilled.value = false;
  //     } else {
  //       isFilled.value = true;
  //     }
  //   });
  // }
}
