import 'package:daram/controller/party.dart';
import 'package:daram/models/party.dart';
import 'package:daram/provider/party.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants/Colors.dart';
import '../../../constants/Gaps.dart';
import '../../../constants/sizes.dart';
import '../../../controller/new_party.dart';


class CreateMeetingCategories extends StatelessWidget {
  CreateMeetingCategories({
    super.key,
  });
  @override


  Widget build(BuildContext context) {
    final NewPartyController newPartyController = Get.find<NewPartyController>();

    return Container(
      padding: EdgeInsets.symmetric(vertical: Sizes.size10),
      height: 50,
      child: ListView.separated(
          separatorBuilder: (BuildContext context, int index) => Gaps.h10,
          itemCount: categories.length-1,
          scrollDirection: Axis.horizontal,
          itemBuilder: ((context, index) {
            int _index = index + 1;
            return
              GestureDetector(
                onTap: (){
                  if(newPartyController.partyType.value == _index){
                    newPartyController.partyType.value = 0;
                    print('selectedCategory = ${newPartyController.partyType.value}');
                    print('선택된 인덱스 =$_index');
                  }else{
                    newPartyController.partyType.value = _index;
                    print('selectedCategory = ${newPartyController.partyType.value}');
                    print('선택된 인덱스 =$_index');
                  }
                },
                child:
                Obx(() =>Container(
                  padding: EdgeInsets.symmetric(horizontal: Sizes.size10),
                  height: 10,
                  decoration: BoxDecoration(
                      color: COLORS.meetingCard,
                      borderRadius: BorderRadius.all(Radius.circular(50),),
                      border: newPartyController.partyType.value == _index ? Border.all(color: COLORS.main) : null),
                  alignment: Alignment.center,
                  child: Text('${categories[_index]}',
                    style:TextStyle(color: newPartyController.partyType.value == _index ? COLORS.main : COLORS.categoryText,
                      fontSize: 17,
                    ),
                  ),
                ),
                ),


              );
          })
      ),
    );
  }
}