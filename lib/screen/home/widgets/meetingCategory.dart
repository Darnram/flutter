import 'package:daram/controller/party.dart';
import 'package:daram/models/party.dart';
import 'package:daram/provider/party.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants/Colors.dart';
import '../../../constants/Gaps.dart';
import '../../../constants/sizes.dart';


class MeetingCategories extends StatelessWidget {
  MeetingCategories({
    super.key,
  });
  @override


  Widget build(BuildContext context) {
    PartyController partyController = Get.find<PartyController>();

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
                  if(partyController.selectedCategory.value == _index){
                    partyController.selectedCategory.value = 0;
                    print('selectedCategory = ${partyController.selectedCategory.value}');
                    print('선택된 인덱스 =$_index');
                  }else{
                    partyController.selectedCategory.value = _index;
                    print('selectedCategory = ${partyController.selectedCategory.value}');
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
                            border: partyController.selectedCategory.value == _index ? Border.all(color: COLORS.main) : null),
                        alignment: Alignment.center,
                        child: Text('${categories[_index]}',
                          style:TextStyle(color: partyController.selectedCategory.value == _index ? COLORS.main : COLORS.categoryText,
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