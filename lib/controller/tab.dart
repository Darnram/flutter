import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MeetingTabController extends GetxController with GetSingleTickerProviderStateMixin{
  final List<Widget> meetingTabs = <Widget>[
    Container(
        padding: EdgeInsets.symmetric(vertical: 10,),
        alignment: Alignment.center,

        width: 100,
        child: Text('모임 둘러보기',)

    ),
    Container(
        padding: EdgeInsets.symmetric(vertical: 10,),
        alignment: Alignment.center,
        width: 100,
        child: Text('내 모임',style: TextStyle(fontSize: 17,))
    ),
  ];

  late TabController controller;

  @override
  void onInit() {
    super.onInit();
    controller = TabController(vsync: this, length: meetingTabs.length);
  }

  @override
  void onClose() {
    controller.dispose();
    super.onClose();
  }
}